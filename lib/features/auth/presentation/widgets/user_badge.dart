import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:diploma_job/core/extension/l10n_extension.dart';
import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/theme/theme_pellete.dart';
import 'package:diploma_job/core/widgets/custom_hover.dart';
import 'package:diploma_job/core/widgets/custom_overlay_notification.dart';
import 'package:diploma_job/core/widgets/custom_text.dart';

import '../../domain/entities/auth_enums.dart';
import '../providers/auth_providers.dart';
import '../../../../core/utils/auth_localizations.dart';

class UserBadge extends ConsumerWidget {
  const UserBadge({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    if (user == null) return const SizedBox.shrink();

    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final avatarColor = user.role == UserRole.student
        ? context.palette.avatarBg
        : AppColors.accentGreen;

    return CustomHover(
      cursor: SystemMouseCursors.click,
      color: scheme.surface,
      lift: 2,
      radius: 12,
      child: GestureDetector(
        //  onTap: () => context.go(user.dashboardRoute),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: scheme.outline),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: avatarColor,
                child: CustomText(
                  user.initial,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (!compact) ...[
                const SizedBox(width: 10),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 150),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        user.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: scheme.onSurface,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),
                      // CustomText(
                      //   user.subtitle(l10n),
                      //   maxLines: 1,
                      //   overflow: TextOverflow.ellipsis,
                      //   style: AppTextStyles.bodySmall
                      //       .copyWith(fontSize: 10.5, color: AppColors.textMuted, height: 1.2),
                      // ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Logout helper shared by navbar + drawer.
void logout(WidgetRef ref, BuildContext context) {
  ref.read(sessionProvider.notifier).logout();
  CustomToast.showSuccess(message: context.l10n.loggedOut);
}
