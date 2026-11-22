import 'package:diploma_job/core/database/local_storage.dart';
import 'package:diploma_job/core/router/app_router.dart';
import 'package:diploma_job/features/splash/presentation/provider/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diploma_job/core/extension/l10n_extension.dart';
import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/theme/theme_pellete.dart';
import 'package:diploma_job/core/widgets/custom_button.dart';
import 'package:diploma_job/core/widgets/custom_text.dart';
import 'package:diploma_job/core/widgets/labeled_text_field.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/auth_validators.dart';
import '../../../forgot_password/presentation/page/forgot_pass_dialogue.dart';
import '../../widget/password_field.dart';
import '../providers/login_providers.dart';

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
  bool _remember = false;
  bool _submitting = false; // login + profile load দুটোই cover করবে

  @override
  void initState() {
    super.initState();
    _loadRememberedEmail();
  }

  Future<void> _loadRememberedEmail() async {
    final data = await LocalStorage().readData(key: 'remember_email');
    if (!mounted || data == null) return;
    widget.emailController.text = data;
  }

  Future<void> _submit() async {
    if (_submitting) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);

    try {
      final ok = await ref
          .read(loginNotifierProvider.notifier)
          .login(
            email: widget.emailController.text.trim(),
            password: widget.passwordController.text,
          );
      if (!mounted || !ok) return;

      if (_remember) {
        await LocalStorage().writeData(
          key: 'remember_email',
          value: widget.emailController.text.trim(),
        );
      }
      if (!mounted) return;

      // Token save হয়ে গেছে, এখন profile আনুন
      await ref.read(userProfileProvider.notifier).refresh();
      if (!mounted) return;

      final profile = ref.read(userProfileProvider).value;
      if (profile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile load করা যায়নি, আবার চেষ্টা করুন'),
          ),
        );
        return;
      }

      _resetForm();
      context.replace(AppRoutes.home);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    if (!_remember) widget.emailController.clear();
    widget.passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final validators = AuthValidators(l10n);
    final loginLoading = ref.watch(
      loginNotifierProvider.select((s) => s.isLoading),
    );
    final busy = _submitting || loginLoading;

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
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: _remember,
                        activeColor: AppColors.primary,
                        onChanged: busy
                            ? null
                            : (v) => setState(() => _remember = v ?? false),
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
              ),
              GestureDetector(
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
            ],
          ),
          const SizedBox(height: 20),
          Opacity(
            opacity: busy ? 0.6 : 1,
            child: CustomButton(
              isLoading: busy,
              label: l10n.loginAction,
              icon: Icons.arrow_forward_rounded,
              fullWidth: true,
              buttonHeight: 48,
              onPressed: busy ? null : _submit,
            ),
          ),
        ],
      ),
    );
  }
}
