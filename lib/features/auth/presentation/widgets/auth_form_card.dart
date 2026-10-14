import 'package:diploma_job/core/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diploma_job/core/extension/l10n_extension.dart';
import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/theme/theme_pellete.dart';
import 'package:diploma_job/core/widgets/custom_button.dart';
import 'package:diploma_job/core/widgets/custom_overlay_notification.dart';
import 'package:diploma_job/core/widgets/custom_text.dart';

import '../../../../core/widgets/segmented_toggle.dart';
import '../../domain/entities/auth_enums.dart';
import '../providers/auth_providers.dart';
import 'login_form.dart';
import 'signup_form.dart';

class AuthFormCard extends ConsumerWidget {
  const AuthFormCard({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final mode = ref.watch(authModeProvider);
    final role = ref.watch(authRoleProvider);

    return Padding(
      padding: EdgeInsets.all(
        Responsive.value(context, mobile: 20.0, desktop: 40.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ModeTabs(
            mode: mode,
            onChanged: ref.read(authModeProvider.notifier).set,
          ),
          const SizedBox(height: 20),
          mode == AuthMode.signup
              ? SegmentedToggle<UserRole>(
                  selected: role,
                  onChanged: ref.read(authRoleProvider.notifier).set,
                  options: [
                    SegmentedOption(
                      value: UserRole.student,
                      label: l10n.roleStudent,
                      icon: Icons.person_outline_rounded,
                      color: context.palette.brand,
                    ),
                    SegmentedOption(
                      value: UserRole.company,
                      label: l10n.roleCompany,
                      icon: Icons.apartment_rounded,
                      color: AppColors.accentGreen,
                    ),
                  ],
                )
              : SizedBox(),
          const SizedBox(height: 24),
          Consumer(
            builder: (context, ref, child) {
              final mode = ref.watch(authModeProvider);
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: mode == AuthMode.login
                    ? LoginForm(
                        key: const ValueKey('login'),
                        emailController: emailController,
                        passwordController: passwordController,
                      )
                    : const SignupForm(key: ValueKey('signup')),
              );
            },
          ),
          const SizedBox(height: 24),
          _OrDivider(text: l10n.socialDivider),
          const SizedBox(height: 16),
          CustomButton(
            label: l10n.googleSignIn,
            icon: Icons.account_circle_outlined,
            variant: CustomButtonVariant.outline,
            fullWidth: true,
            buttonHeight: 46,
            onPressed: () => _google(ref, context),
          ),
        ],
      ),
    );
  }

  Future<void> _google(WidgetRef ref, BuildContext context) async {
    final l10n = context.l10n;
    CustomToast.showSuccess(message: l10n.googleVerifying);
    final ok = await ref.read(sessionProvider.notifier).signInWithGoogle();
    ok
        ? CustomToast.showSuccess(message: l10n.googleSuccess)
        : CustomToast.showError(message: l10n.authFailed);
  }
}

class _ModeTabs extends StatelessWidget {
  const _ModeTabs({required this.mode, required this.onChanged});

  final AuthMode mode;
  final ValueChanged<AuthMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _Tab(
              label: l10n.tabLogin,
              selected: mode == AuthMode.login,
              onTap: () => onChanged(AuthMode.login),
            ),
          ),
          Expanded(
            child: _Tab(
              label: l10n.tabRegister,
              selected: mode == AuthMode.signup,
              onTap: () => onChanged(AuthMode.signup),
            ),
          ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final brand = context.palette.brand;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected ? brand : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: CustomText(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: selected ? brand : AppColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final line = Expanded(
      child: Divider(color: Theme.of(context).colorScheme.outline, height: 1),
    );
    return Row(
      children: [
        line,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: CustomText(
            text,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
          ),
        ),
        line,
      ],
    );
  }
}
