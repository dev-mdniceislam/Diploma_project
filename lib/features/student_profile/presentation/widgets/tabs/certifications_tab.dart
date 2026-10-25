import 'package:flutter/material.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/widgets/custom_overlay_notification.dart';
import '../../../domain/entities/student_profile.dart';
import '../../../../../core/utils/open_link.dart';
import '../profile_core.dart';
import '../profile_ui.dart';

class CertificationsTab extends StatelessWidget {
  const CertificationsTab({super.key, required this.profile});

  final StudentProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        ProfileCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardTitle(
                icon: Icons.workspace_premium_outlined,
                title: l10n.certificatesTitle,
                iconColor: AppColors.urgent,
                trailing: TextButton(
                  onPressed: () =>
                      CustomToast.showSuccess(message: l10n.comingSoon),
                  child: CustomText('+ ${l10n.add}'),
                ),
              ),
              const SizedBox(height: AppDimens.sm),
              ResponsiveGrid(
                mobileColumns: 1,
                tabletColumns: 2,
                desktopColumns: 2,
                spacing: AppDimens.sm,
                children: [
                  for (final c in profile.certificates)
                    _CertificateTile(cert: c),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppDimens.md),
        ProfileCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardTitle(icon: Icons.public_rounded, title: l10n.socialTitle),
              const SizedBox(height: AppDimens.sm),
              for (final link in profile.socialLinks) ...[
                _SocialTile(link: link),
                const SizedBox(height: AppDimens.xs + 2),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _CertificateTile extends StatelessWidget {
  const _CertificateTile({required this.cert});

  final Certificate cert;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      padding: const EdgeInsets.all(AppDimens.sm + 4),
      decoration: BoxDecoration(
        color: context.mutedSurface,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: context.scheme.outline),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: p.successBg,
              borderRadius: BorderRadius.circular(AppDimens.radiusMd - 2),
            ),
            child: Icon(Icons.task_alt_rounded, size: 22, color: p.success),
          ),
          const SizedBox(width: AppDimens.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  cert.title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: context.scheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                CustomText(
                  cert.issuer,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: context.bodyColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialTile extends StatelessWidget {
  const _SocialTile({required this.link});

  final SocialLink link;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (icon, label) = switch (link.type) {
      SocialType.linkedin => (
        Icons.business_center_outlined,
        l10n.linkedinProfile,
      ),
      SocialType.github => (Icons.code_rounded, l10n.githubRepos),
    };

    return InkWell(
      borderRadius: BorderRadius.circular(AppDimens.radiusMd),
      onTap: () => openLink(context, link.url, context.l10n.linkOpenFailed),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.sm + 4,
          vertical: AppDimens.sm + 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          border: Border.all(color: context.scheme.outline),
        ),
        child: Row(
          children: [
            Icon(icon, size: 19, color: context.palette.brand),
            const SizedBox(width: AppDimens.sm),
            Expanded(
              child: CustomText(
                label,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: context.scheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}
