import 'package:flutter/material.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/gen/assets_gen.dart';
import '../../../data/profile_models.dart';
import '../../../profile_core.dart';
import '../../widgets/profile_widgets.dart';

class StudentCertificatesTab extends StatelessWidget {
  const StudentCertificatesTab(this.p, {super.key});

  final StudentProfile p;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final tt = context.tt;
    final cs = context.cs;

    Widget socialIcon(String type) {
      final path = switch (type) {
        'linkedin' => Assets.icons.linkedin,
        'facebook' => Assets.icons.facebook,
        'youtube' => Assets.icons.youtube,
        'twitter' => Assets.icons.twiter,
        'instagram' => Assets.icons.instagram,
        _ => null,
      };
      return path == null
          ? const Icon(Icons.code_rounded, size: 20)
          : Image.asset(path, width: 20, height: 20);
    }

    return Column(
      spacing: AppDimens.md - 4,
      children: [
        if (p.certificates.isNotEmpty)
          ProfileCard(
            title: l.pfCertsTitle,
            icon: Icons.workspace_premium_outlined,
            iconColor: AppColors.amber,
            child: ResponsiveWrap(
              mobile: 1,
              tablet: 3,
              desktop: 3,
              children: [
                for (final c in p.certificates)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: cs.onSurface.withValues(alpha: .03),
                      borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                      border: Border.all(color: cs.outline),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8,
                      children: [
                        Container(
                          height: 96,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: context.palette.brand.withValues(alpha: .12),
                            borderRadius: BorderRadius.circular(
                              AppDimens.radiusSm + 2,
                            ),
                          ),
                          child: Icon(
                            Icons.verified_outlined,
                            size: 40,
                            color: context.palette.brand,
                          ),
                        ),
                        CustomText(
                          c.title,
                          style: tt.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: cs.onSurface,
                          ),
                        ),
                        CustomText(c.issuer, style: tt.bodySmall),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        if (p.socials.isNotEmpty)
          ProfileCard(
            title: l.pfSocialTitle,
            icon: Icons.public_rounded,
            child: ResponsiveWrap(
              mobile: 1,
              tablet: 2,
              desktop: 2,
              children: [
                for (final s in p.socials)
                  InkWell(
                    borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                    onTap: () => openLink(context, s.url),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                        border: Border.all(color: cs.outline),
                      ),
                      child: Row(
                        spacing: 8,
                        children: [
                          socialIcon(s.type),
                          Expanded(
                            child: CustomText(
                              s.label,
                              style: tt.bodySmall!.copyWith(
                                fontWeight: FontWeight.w700,
                                color: cs.onSurface,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right_rounded,
                            size: 18,
                            color: AppColors.textMuted,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
