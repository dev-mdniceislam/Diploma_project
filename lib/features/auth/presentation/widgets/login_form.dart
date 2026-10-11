import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:diploma_job/core/extension/l10n_extension.dart';
import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/theme/theme_pellete.dart';
import 'package:diploma_job/core/widgets/custom_button.dart';
import 'package:diploma_job/core/widgets/custom_text.dart';
import 'package:diploma_job/core/widgets/labeled_text_field.dart';

import '../../../../core/utils/auth_validators.dart';
import '../providers/auth_providers.dart';
import '../../../../core/utils/auth_feedback.dart';
import 'forgot_password_dialog.dart';
import 'password_field.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _remember = true;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final l10n = context.l10n;
    final role = ref.read(authRoleProvider);

    final ok = await ref
        .read(sessionProvider.notifier)
        .login(
          email: widget.emailController.text.trim(),
          password: widget.passwordController.text,
          role: role,
        );
    notifyAuthResult(l10n, ok: ok, role: role);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final validators = AuthValidators(l10n);
    final isLoading = ref.watch(sessionProvider.select((s) => s.isLoading));

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LabeledTextField(
            label: l10n.fieldEmail,
            controller: widget.emailController,
            hintText: 'example@polytechnic.edu.bd',
            preIcon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            validator: validators.email,
          ),
          const SizedBox(height: 16),
          PasswordField(
            label: l10n.fieldPassword,
            controller: widget.passwordController,
            validator: validators.notEmpty,
            autofillHints: const [AutofillHints.password],
            onSubmitted: (_) => _submit(),
            trailingLabel: GestureDetector(
              onTap: () => ForgotPasswordDialog.show(context),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: CustomText(
                  l10n.forgotPassword,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: context.palette.brand,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: _remember,
                  activeColor: AppColors.primary,
                  onChanged: (v) => setState(() => _remember = v ?? false),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: CustomText(
                  l10n.rememberMe,
                  style: AppTextStyles.bodySmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Opacity(
            opacity: isLoading ? 0.6 : 1,
            child: CustomButton(
              label: l10n.loginAction,
              icon: Icons.arrow_forward_rounded,
              fullWidth: true,
              buttonHeight: 48,
              onPressed: isLoading ? null : _submit,
            ),
          ),
        ],
      ),
    );
  }
}
