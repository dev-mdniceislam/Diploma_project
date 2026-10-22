import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diploma_job/core/extension/l10n_extension.dart';
import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/utils/auth_validators.dart';
import 'package:diploma_job/core/widgets/app_dialog.dart';
import 'package:diploma_job/core/widgets/custom_button.dart';
import 'package:diploma_job/core/widgets/custom_text.dart';
import 'package:diploma_job/core/widgets/labeled_text_field.dart';
import 'package:diploma_job/features/auth/login/widget/password_field.dart';

import '../providers/password_reset_provider.dart';
import '../widgets/otp_field.dart';

enum _Step { email, otp, newPassword, done }

class ForgotPasswordDialog extends ConsumerStatefulWidget {
  const ForgotPasswordDialog({super.key, this.initialEmail});

  final String? initialEmail;

  static Future<void> show(BuildContext context, {String? initialEmail}) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => ForgotPasswordDialog(initialEmail: initialEmail),
    );
  }

  @override
  ConsumerState<ForgotPasswordDialog> createState() =>
      _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends ConsumerState<ForgotPasswordDialog> {
  final _emailKey = GlobalKey<FormState>();
  final _otpKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormState>();

  late final TextEditingController _email;
  final _otp = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  _Step _step = _Step.email;
  String? _resetToken;

  PasswordResetController get _ctrl =>
      ref.read(passwordResetControllerProvider.notifier);

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: widget.initialEmail);
    Future.microtask(_ctrl.reset); // clear stale state
  }

  @override
  void dispose() {
    _email.dispose();
    _otp.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  // ── Actions ──────────────────────────────────────────────────────────────
  Future<void> _sendOtp() async {
    if (!_emailKey.currentState!.validate()) return;
    final ok = await _ctrl.sendOtp(_email.text);
    if (ok && mounted) {
      setState(() {
        _otp.clear();
        _step = _Step.otp;
      });
    }
  }

  Future<void> _resendOtp() async {
    _otp.clear();
    await _ctrl.sendOtp(_email.text);
  }

  Future<void> _verifyOtp() async {
    if (ref.read(passwordResetControllerProvider).isLoading) return;
    if (!_otpKey.currentState!.validate()) return;
    final token = await _ctrl.verifyOtp(email: _email.text, otp: _otp.text);
    if (token != null && mounted) {
      setState(() {
        _resetToken = token;
        _step = _Step.newPassword;
      });
    }
  }

  Future<void> _resetPassword() async {
    if (!_passKey.currentState!.validate()) return;
    final ok = await _ctrl.submitNewPassword(
      resetToken: _resetToken!,
      newPassword: _password.text,
    );
    if (ok && mounted) setState(() => _step = _Step.done);
  }

  void _backToEmail() {
    _ctrl.reset();
    setState(() => _step = _Step.email);
  }

  // ── Build ────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final loading = ref.watch(passwordResetControllerProvider).isLoading;
    void close() => Navigator.of(context).pop();

    final (title, actions, body) = switch (_step) {
      _Step.email => (
        l10n.resetPasswordTitle,
        [
          CustomButton(
            label: l10n.cancel,
            variant: CustomButtonVariant.outline,
            onPressed: loading ? null : close,
          ),
          CustomButton(
            label: l10n.sendCode,
            isLoading: loading,
            onPressed: _sendOtp,
          ),
        ],
        _emailForm(),
      ),
      _Step.otp => (
        l10n.resetPasswordTitle,
        [
          CustomButton(
            label: l10n.back,
            variant: CustomButtonVariant.outline,
            onPressed: loading ? null : _backToEmail,
          ),
          CustomButton(
            label: l10n.verifyOtp,
            isLoading: loading,
            onPressed: _verifyOtp,
          ),
        ],
        _otpForm(loading),
      ),
      _Step.newPassword => (
        l10n.setNewPasswordTitle,
        [
          CustomButton(
            label: l10n.cancel,
            variant: CustomButtonVariant.outline,
            onPressed: loading ? null : close,
          ),
          CustomButton(
            label: l10n.resetPasswordButton,
            isLoading: loading,
            onPressed: _resetPassword,
          ),
        ],
        _passwordForm(),
      ),
      _Step.done => (
        l10n.resetPasswordTitle,
        [CustomButton(label: l10n.backToLogin, onPressed: close)],
        _successView(),
      ),
    };

    return AppDialog(
      title: title,
      maxWidth: 440,
      actions: actions,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 180),
        alignment: Alignment.topCenter,
        child: body,
      ),
    );
  }

  // ── Steps ────────────────────────────────────────────────────────────────
  Widget _emailForm() {
    final l10n = context.l10n;
    return Form(
      key: _emailKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(l10n.resetPasswordDesc, style: AppTextStyles.bodyMedium),
          const SizedBox(height: 20),
          LabeledTextField(
            label: '${l10n.emailAddress} *',
            controller: _email,
            hintText: l10n.emailHint,
            preIcon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            validator: AuthValidators(l10n).email,
            onSubmitted: (_) => _sendOtp(),
          ),
          const _ErrorText(),
        ],
      ),
    );
  }

  Widget _otpForm(bool loading) {
    final l10n = context.l10n;
    return Form(
      key: _otpKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            l10n.otpSentTo(_email.text.trim()),
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: 20),
          OtpPinField(
            controller: _otp,
            enabled: !loading,
            autofocus: true,
            onCompleted: (_) => _verifyOtp(), // auto-submit on 6th digit
          ),
          const _ErrorText(),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: loading ? null : _resendOtp,
              child: CustomText(
                l10n.resendOtp,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primaryNavy,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordForm() {
    final l10n = context.l10n;
    final v = AuthValidators(l10n);
    return Form(
      key: _passKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(l10n.setNewPasswordDesc, style: AppTextStyles.bodyMedium),
          const SizedBox(height: 20),
          PasswordField(
            label: '${l10n.newPassword} *',
            controller: _password,
            validator: v.password,
          ),
          const SizedBox(height: 16),
          PasswordField(
            label: '${l10n.fieldConfirmPassword} *',
            controller: _confirm,
            validator: v.confirmPassword(_password),
          ),
          const _ErrorText(),
        ],
      ),
    );
  }

  Widget _successView() {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutBack,
        builder: (context, t, child) {
          return Opacity(
            opacity: t.clamp(0.0, 1.0),
            child: Transform.translate(
              offset: Offset(0, (1 - t) * 12),
              child: child,
            ),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Outer soft ring + inner circle + check icon
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.4, end: 1),
              duration: const Duration(milliseconds: 700),
              curve: Curves.elasticOut,
              builder: (context, scale, child) =>
                  Transform.scale(scale: scale, child: child),
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accentGreenSoft.withOpacity(0.5),
                ),
                alignment: Alignment.center,
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accentGreenSoft,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accentGreenDark.withOpacity(0.18),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: AppColors.accentGreenDark,
                    size: 40,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            CustomText(
              l10n.passwordResetSuccessTitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.accentGreenDark,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            CustomText(
              l10n.passwordResetSuccess,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

/// Shows the controller error (if any) under a form.
class _ErrorText extends ConsumerWidget {
  const _ErrorText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final error = ref.watch(passwordResetControllerProvider).error;
    if (error == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: CustomText(
        error,
        style: AppTextStyles.bodySmall.copyWith(color: AppColors.dangerDark),
      ),
    );
  }
}
