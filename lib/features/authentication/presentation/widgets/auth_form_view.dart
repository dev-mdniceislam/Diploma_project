import 'package:diploma_job/core/error/exception.dart';
import 'package:diploma_job/core/extension/l10n_extension.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/theme/orbit_palette.dart';
import 'package:diploma_job/core/utils/auth_validators.dart';
import 'package:diploma_job/core/widgets/custom_button.dart';
import 'package:diploma_job/core/widgets/custom_overlay_notification.dart';
import 'package:diploma_job/core/widgets/labeled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/auth_user.dart';
import '../providers/auth_providers.dart';
import '../utils/password_score.dart';
import 'auth_widgets.dart';

class AuthFormView extends ConsumerStatefulWidget {
  const AuthFormView({super.key});

  @override
  ConsumerState<AuthFormView> createState() => _AuthFormViewState();
}

class _AuthFormViewState extends ConsumerState<AuthFormView> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _org = TextEditingController();
  final _email = TextEditingController();
  final _otp = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    for (final c in [_name, _org, _email, _otp, _password]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final v = AuthValidators(l10n);
    final p = OrbitPalette.of(context);
    final state = ref.watch(authNotifierProvider);
    final notifier = ref.read(authNotifierProvider.notifier);
    final isSignup = state.mode == AuthMode.signup;
    final isStudent = state.role == UserRole.student;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          AuthModeTabs(mode: state.mode, onChanged: notifier.switchMode),
          const SizedBox(height: 20),
          Text(
            isSignup ? l10n.signupHeading : l10n.loginHeading,
            style: AppTextStyles.headlineMedium.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: p.ink,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isSignup ? l10n.signupSubheading : l10n.loginSubheading,
            style: AppTextStyles.bodyMedium.copyWith(color: p.muted),
          ),
          const SizedBox(height: 20),

          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isSignup) ...[
                  RoleSelector(
                    selected: state.role,
                    onChanged: notifier.selectRole,
                  ),
                  const SizedBox(height: 20),
                ],
              ],
            ),
          ),

          SocialAuthRow(
            onTap: (provider) =>
                CustomToast.showError(message: l10n.socialComingSoon(provider)),
          ),
          const SizedBox(height: 20),
          const OrDivider(),
          const SizedBox(height: 20),

          if (isSignup) ...[
            LabeledTextField(
              label: l10n.fieldFullName,
              controller: _name,
              hintText: l10n.fieldFullNameHint,
              preIcon: Icons.person_outline_rounded,
              validator: v.notEmpty,
              autofillHints: const [AutofillHints.name],
            ),
            const SizedBox(height: 16),
            LabeledTextField(
              label: isStudent ? l10n.fieldInstitute : l10n.fieldCompany,
              controller: _org,
              hintText: isStudent
                  ? l10n.fieldInstituteHint
                  : l10n.fieldCompanyHint,
              preIcon: Icons.apartment_rounded,
              validator: v.notEmpty,
            ),
            const SizedBox(height: 16),
          ],

          LabeledTextField(
            label: l10n.fieldEmail,
            controller: _email,
            hintText: l10n.fieldEmailHint,
            preIcon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            validator: v.email,
            autofillHints: const [AutofillHints.email],
          ),

          if (isSignup) ...[
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: LabeledTextField(
                    label: l10n.fieldOtp,
                    controller: _otp,
                    hintText: l10n.fieldOtpHint,
                    preIcon: Icons.pin_outlined,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    validator: v.otp,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 128,
                  child: CustomButton(
                    label: state.otpSent ? l10n.resendOtp : l10n.sendOtp,
                    variant: CustomButtonVariant.outline,
                    buttonHeight: 48,
                    borderRadius: 12,
                    fullWidth: true,
                    isLoading: state.isBusy,
                    onPressed: () => _sendOtp(),
                  ),
                ),
              ],
            ),
          ],

          const SizedBox(height: 16),
          LabeledTextField(
            label: l10n.fieldPassword,
            controller: _password,
            hintText: '••••••••••••',
            preIcon: Icons.lock_outline_rounded,
            obscureText: state.obscurePassword,
            validator: isSignup ? v.password : v.notEmpty,
            onChanged: (_) => setState(() {}),
            trailingLabel: isSignup
                ? null
                : TextButton(
                    onPressed: () => notifier.showView(AuthView.forgotPassword),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      l10n.forgotPassword,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: p.indigo,
                      ),
                    ),
                  ),
            sufIcon: IconButton(
              onPressed: notifier.togglePasswordVisibility,
              icon: Icon(
                state.obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 18,
                color: p.muted,
              ),
            ),
          ),

          if (isSignup)
            PasswordStrengthMeter(score: passwordScore(_password.text)),

          const SizedBox(height: 12),
          AgreementCheckbox(
            value: isSignup ? state.acceptedTerms : state.keepSignedIn,
            label: isSignup ? l10n.acceptTerms : l10n.keepSignedIn,
            onChanged: isSignup
                ? notifier.setAcceptedTerms
                : notifier.setKeepSignedIn,
          ),
          const SizedBox(height: 20),

          CustomButton(
            label: isSignup ? l10n.submitSignup : l10n.submitLogin,
            icon: Icons.arrow_forward_rounded,
            fullWidth: true,
            buttonHeight: 48,
            borderRadius: 12,
            isLoading: state.isBusy,
            gradient: p.brandGradient,
            boxShadow: [
              BoxShadow(
                color: p.indigo.withValues(alpha: 0.22),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
            onPressed: () => _submit(),
          ),
        ],
      ),
    );
  }

  Future<void> _sendOtp() async {
    final l10n = context.l10n;
    final error = AuthValidators(l10n).email(_email.text);
    if (error != null) {
      CustomToast.showError(message: error);
      return;
    }
    try {
      await ref.read(authNotifierProvider.notifier).sendOtp(_email.text.trim());
      CustomToast.showSuccess(message: l10n.otpSentToast);
    } on AppException catch (e) {
      CustomToast.showError(message: e.message);
    }
  }

  Future<void> _submit() async {
    final l10n = context.l10n;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final state = ref.read(authNotifierProvider);
    final notifier = ref.read(authNotifierProvider.notifier);
    final email = _email.text.trim();

    try {
      if (state.mode == AuthMode.login) {
        await notifier.login(email: email, password: _password.text);
        CustomToast.showSuccess(message: l10n.loginSuccessToast);
        return;
      }

      if (!state.acceptedTerms) {
        CustomToast.showError(message: l10n.errAcceptTerms);
        return;
      }
      if (!state.otpSent) {
        CustomToast.showError(message: l10n.errSendOtpFirst);
        return;
      }

      await notifier.register(
        name: _name.text.trim(),
        email: email,
        otp: _otp.text.trim(),
        password: _password.text,
      );
      CustomToast.showSuccess(message: l10n.signupSuccessToast);
    } on AppException catch (e) {
      CustomToast.showError(message: e.message);
    }
  }
}
