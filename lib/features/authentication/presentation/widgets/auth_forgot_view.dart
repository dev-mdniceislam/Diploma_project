import 'package:diploma_job/core/error/exception.dart';
import 'package:diploma_job/core/extension/l10n_extension.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/theme/orbit_palette.dart';
import 'package:diploma_job/core/utils/auth_validators.dart';
import 'package:diploma_job/core/widgets/custom_button.dart';
import 'package:diploma_job/core/widgets/custom_overlay_notification.dart';
import 'package:diploma_job/core/widgets/labeled_text_field.dart';
import 'package:diploma_job/features/authentication/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

enum _ResetStep { email, otp, newPassword }

class AuthForgotView extends ConsumerStatefulWidget {
  const AuthForgotView({super.key});

  @override
  ConsumerState<AuthForgotView> createState() => _AuthForgotViewState();
}

class _AuthForgotViewState extends ConsumerState<AuthForgotView> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _otp = TextEditingController();
  final _newPassword = TextEditingController();
  final _confirmPassword = TextEditingController();

  _ResetStep _step = _ResetStep.email;
  String? _resetToken;

  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _email.dispose();
    _otp.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  // ── Step 1: email e OTP pathao ─────────────────────────────
  Future<void> _sendEmail() async {
    final l10n = context.l10n;
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final email = _email.text.trim();
    try {
      await ref.read(authNotifierProvider.notifier).requestPasswordReset(email);
      CustomToast.showSuccess(message: l10n.recoverySent(email));
      setState(() => _step = _ResetStep.otp);
    } on AppException catch (e) {
      CustomToast.showError(message: e.message);
    }
  }

  // ── Step 2: OTP verify → resetToken ────────────────────────
  Future<void> _verifyOtp() async {
    if (_otp.text.length != 6) return;
    try {
      _resetToken = await ref
          .read(authNotifierProvider.notifier)
          .verifyResetOtp(email: _email.text.trim(), otp: _otp.text);
      setState(() => _step = _ResetStep.newPassword);
    } on AppException catch (e) {
      CustomToast.showError(message: e.message);
    }
  }

  // ── Step 3: new password set ───────────────────────────────
  Future<void> _resetPassword() async {
    final l10n = context.l10n;
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final token = _resetToken;
    if (token == null) {
      CustomToast.showError(message: l10n.errResetTokenMissing);
      return;
    }
    try {
      await ref
          .read(authNotifierProvider.notifier)
          .resetPassword(resetToken: token, newPassword: _newPassword.text);
      CustomToast.showSuccess(message: l10n.passwordResetSuccess);
      ref.read(authNotifierProvider.notifier).showView(AuthView.form);
    } on AppException catch (e) {
      CustomToast.showError(message: e.message);
    }
  }

  void _goBack() {
    switch (_step) {
      case _ResetStep.email:
        ref.read(authNotifierProvider.notifier).showView(AuthView.form);
      case _ResetStep.otp:
        setState(() => _step = _ResetStep.email);
      case _ResetStep.newPassword:
        setState(() => _step = _ResetStep.otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final v = AuthValidators(l10n);
    final p = OrbitPalette.of(context);
    final isBusy = ref.watch(authNotifierProvider.select((s) => s.isBusy));

    final (title, subtitle, buttonLabel, onPressed) = switch (_step) {
      _ResetStep.email => (
        l10n.resetTitle,
        l10n.resetSubtitle,
        l10n.sendRecoveryLink,
        _sendEmail,
      ),
      _ResetStep.otp => (
        l10n.otpStepTitle,
        l10n.otpStepSubtitle(_email.text.trim()),
        l10n.verifyOtp,
        _verifyOtp,
      ),
      _ResetStep.newPassword => (
        l10n.newPasswordTitle,
        l10n.newPasswordSubtitle,
        l10n.savePassword,
        _resetPassword,
      ),
    };

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: _goBack,
              icon: const Icon(Icons.arrow_back_rounded, size: 16),
              label: Text(l10n.backToSignIn),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: p.indigo.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: p.indigo.withValues(alpha: 0.3)),
            ),
            child: Icon(Icons.vpn_key_rounded, color: p.indigo, size: 22),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: AppTextStyles.headlineMedium.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: p.ink,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: AppTextStyles.bodyMedium.copyWith(color: p.muted),
          ),
          const SizedBox(height: 24),

          if (_step == _ResetStep.email)
            LabeledTextField(
              label: l10n.recoveryEmailLabel,
              controller: _email,
              hintText: l10n.fieldEmailHint,
              preIcon: Icons.mail_outline_rounded,
              keyboardType: TextInputType.emailAddress,
              validator: v.email,
            ),

          if (_step == _ResetStep.otp) _OtpPinField(controller: _otp, p: p),

          if (_step == _ResetStep.newPassword) ...[
            LabeledTextField(
              label: l10n.newPasswordLabel,
              controller: _newPassword,
              hintText: '••••••••••••',
              preIcon: Icons.lock_outline_rounded,
              obscureText: _obscureNew,
              sufIcon: _VisibilityToggle(
                obscure: _obscureNew,
                onTap: () => setState(() => _obscureNew = !_obscureNew),
              ),
              validator: v.password,
            ),
            const SizedBox(height: 16),
            LabeledTextField(
              label: l10n.confirmPasswordLabel,
              controller: _confirmPassword,
              hintText: '••••••••••••',
              preIcon: Icons.lock_outline_rounded,
              obscureText: _obscureConfirm,
              sufIcon: _VisibilityToggle(
                obscure: _obscureConfirm,
                onTap: () => setState(() => _obscureConfirm = !_obscureConfirm),
              ),
              validator: v.confirmPassword(_newPassword),
            ),
          ],

          const SizedBox(height: 20),
          CustomButton(
            label: buttonLabel,
            fullWidth: true,
            buttonHeight: 48,
            borderRadius: 12,
            isLoading: isBusy,
            gradient: p.brandGradient,
            onPressed: () => onPressed(),
          ),
        ],
      ),
    );
  }
}

// ── Pinput OTP field ─────────────────────────────────────────

class _OtpPinField extends StatelessWidget {
  const _OtpPinField({required this.controller, required this.p});

  final TextEditingController controller;
  final OrbitPalette p;

  @override
  Widget build(BuildContext context) {
    final defaultTheme = PinTheme(
      width: 48,
      height: 56,
      textStyle: AppTextStyles.headlineMedium.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: p.ink,
      ),
      decoration: BoxDecoration(
        color: p.canvas,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: p.line),
      ),
    );

    return Pinput(
      controller: controller,
      length: 6,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      defaultPinTheme: defaultTheme,
      focusedPinTheme: defaultTheme.copyWith(
        decoration: defaultTheme.decoration!.copyWith(
          color: Colors.white,
          border: Border.all(color: p.indigo, width: 1.5),
        ),
      ),
      submittedPinTheme: defaultTheme.copyWith(
        decoration: defaultTheme.decoration!.copyWith(
          border: Border.all(color: p.indigo.withValues(alpha: 0.5)),
        ),
      ),
      errorPinTheme: defaultTheme.copyWith(
        decoration: defaultTheme.decoration!.copyWith(
          border: Border.all(color: p.rose),
        ),
      ),
      separatorBuilder: (index) => const SizedBox(width: 8),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}

// ── Eye icon toggle ──────────────────────────────────────────

class _VisibilityToggle extends StatelessWidget {
  const _VisibilityToggle({required this.obscure, required this.onTap});

  final bool obscure;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = OrbitPalette.of(context);
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        size: 18,
        color: p.muted,
      ),
    );
  }
}
