import 'package:diploma_job/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diploma_job/core/extension/l10n_extension.dart';
import 'package:diploma_job/core/widgets/custom_button.dart';

import '../../../../../core/utils/auth_feedback.dart';
import '../../../../../core/utils/auth_validators.dart';
import '../../../../../core/widgets/labeled_text_field.dart';
import '../../../login/widget/password_field.dart';
import '../../../login/widget/responsive_form_row.dart';
import '../../domain/entities/auth_enums.dart';
import '../../domain/entities/registration_data.dart';
import '../providers/registration_provider.dart';

/// Registration form — fields switch with the selected role.
class SignupForm extends ConsumerStatefulWidget {
  const SignupForm({super.key});

  @override
  ConsumerState<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends ConsumerState<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _studentName = TextEditingController();
  final _companyName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  final _otp = TextEditingController();

  @override
  void dispose() {
    for (final c in [
      _studentName,
      _companyName,
      _email,
      _password,
      _confirm,
      _otp,
    ]) {
      c.dispose();
    }
    super.dispose();
    ref.read(sessionProvider.notifier).resetOtp();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context)!;
    final role = ref.read(authRoleProvider);
    final isStudent = role == UserRole.student;

    final data = RegistrationData(
      role: role,
      name: (isStudent ? _studentName : _companyName).text.trim(),
      email: _email.text.trim(),
      password: _password.text,
      otp: _otp.text.trim(),
    );

    final ok = await ref.read(sessionProvider.notifier).register(data);
    if (!mounted) return;
    notifyAuthResult(l10n, ok: ok, role: role, registration: true);

    if (ok) {
      _resetForm();
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    for (final c in [
      _studentName,
      _companyName,
      _email,
      _password,
      _confirm,
      _otp,
    ]) {
      c.clear();
    }
    ref.read(sessionProvider.notifier).resetOtp();
  }

  Future<void> _emailVerify() async {
    final error = AuthValidators(context.l10n).email(_email.text.trim());
    if (error != null) {
      _formKey.currentState!.validate();
      return;
    }
    await ref.read(sessionProvider.notifier).verifyEmail(_email.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final v = AuthValidators(l10n);
    final role = ref.watch(authRoleProvider);
    final isLoading = ref.watch(sessionProvider.select((s) => s.isLoading));
    final showOtp = ref.watch(sessionProvider.select((s) => s.isShowOtpField));
    final isVerifyButton = ref.watch(
      sessionProvider.select((s) => s.verifyButton),
    );

    final roleFields = role == UserRole.student
        ? <Widget>[
            LabeledTextField(
              label: l10n.fieldFullName,
              controller: _studentName,
              hintText: l10n.fullNameHint,
              validator: v.notEmpty,
            ),
            const SizedBox(height: 16),
          ]
        : <Widget>[
            LabeledTextField(
              label: l10n.fieldCompanyName,
              controller: _companyName,
              hintText: 'ex: Walton Hi-Tech PLC',
              validator: v.notEmpty,
            ),
            const SizedBox(height: 16),
          ];

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...roleFields,
          const SizedBox(height: 16),
          Row(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: LabeledTextField(
                  label: l10n.fieldEmail,
                  controller: _email,
                  hintText: 'user@domain.com',
                  keyboardType: TextInputType.emailAddress,
                  validator: v.email,
                ),
              ),
              CustomButton(
                label: "Verify",
                onPressed: _emailVerify,
                isLoading: isVerifyButton,
                buttonHeight: 50,
              ),
            ],
          ),
          if (showOtp) ...[
            const SizedBox(height: 16),
            LabeledTextField(
              label: 'OTP',
              controller: _otp,
              hintText: '6-digit code',
              keyboardType: TextInputType.number,
              validator: v.notEmpty,
            ),
          ],
          const SizedBox(height: 16),
          ResponsiveFormRow(
            children: [
              PasswordField(
                label: l10n.fieldPassword,
                controller: _password,
                validator: v.password,
              ),
              PasswordField(
                label: l10n.fieldConfirmPassword,
                controller: _confirm,
                validator: v.confirmPassword(_password),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Opacity(
            opacity: isLoading ? 0.6 : 1,
            child: CustomButton(
              isLoading: isLoading,
              label: l10n.registerAction,
              icon: Icons.person_add_alt_1_rounded,
              fullWidth: true,
              buttonHeight: 48,
              variant: role == UserRole.company
                  ? CustomButtonVariant.accent
                  : CustomButtonVariant.primary,
              onPressed: isLoading ? null : _submit,
            ),
          ),
        ],
      ),
    );
  }
}
