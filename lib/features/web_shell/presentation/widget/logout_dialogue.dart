import 'dart:ui';

import 'package:diploma_job/core/extension/l10n_extension.dart';
import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/widgets/custom_button.dart';
import 'package:diploma_job/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

/// Logout confirmation dialog দেখায়।
/// User Logout চাইলে `true`, বাতিল করলে `false` ফেরত আসে।
Future<bool> showLogoutDialog(BuildContext context, {String? name}) async {
  final result = await showGeneralDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'logout',
    barrierColor: Colors.black.withValues(alpha: 0.25),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, _, _) => _LogoutDialog(name: name),
    transitionBuilder: (context, animation, _, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeIn,
      );
      return AnimatedBuilder(
        animation: curved,
        builder: (context, child) {
          final sigma = 6 * curved.value;
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
            child: FadeTransition(
              opacity: curved,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.92, end: 1).animate(curved),
                child: child,
              ),
            ),
          );
        },
        child: child,
      );
    },
  );
  return result ?? false;
}

class _LogoutDialog extends StatelessWidget {
  const _LogoutDialog({this.name});

  final String? name;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 340,
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppColors.primary600.withValues(alpha: 0.15),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 40,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _PulsingIcon(),
              const SizedBox(height: 20),
              CustomText(
                l10n.logoutConfirmTitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.titleLarge.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: scheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              CustomText(
                name == null || name!.isEmpty
                    ? l10n.logoutConfirmMessage
                    : l10n.logoutConfirmMessageNamed(name!),
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textMuted,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      label: l10n.stayLoggedIn,
                      variant: CustomButtonVariant.outline,
                      borderRadius: 14,
                      buttonHeight: 46,
                      fullWidth: true,
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      label: l10n.logout,
                      icon: Icons.logout_rounded,
                      variant: CustomButtonVariant.primary,
                      gradient: AppColors.loginGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.featured.withValues(alpha: 0.35),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                      borderRadius: 14,
                      buttonHeight: 46,
                      fullWidth: true,
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Gradient icon-এর চারপাশে আস্তে আস্তে pulse করা ring।
class _PulsingIcon extends StatefulWidget {
  const _PulsingIcon();

  @override
  State<_PulsingIcon> createState() => _PulsingIconState();
}

class _PulsingIconState extends State<_PulsingIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 84,
      height: 84,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (_, _) {
              return Container(
                width: 84 + 12 * _controller.value,
                height: 84 + 12 * _controller.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.featured.withValues(
                    alpha: 0.12 * (1 - _controller.value),
                  ),
                ),
              );
            },
          ),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.loginGradient,
              boxShadow: [
                BoxShadow(
                  color: AppColors.featured.withValues(alpha: 0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Icon(
              Icons.logout_rounded,
              color: AppColors.white,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}