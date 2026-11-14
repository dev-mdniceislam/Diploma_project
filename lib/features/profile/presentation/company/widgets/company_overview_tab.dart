import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:diploma_job/features/profile/data/model/company_profile_model.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/utils/localized_format.dart';
import '../../../profile_core.dart';
import '../../widgets/profile_widgets.dart';
import 'company_actions.dart';

class CompanyOverviewTab extends ConsumerWidget {
  const CompanyOverviewTab(this.p, {super.key});

  final CompanyProfileModel p;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final tt = context.tt;
    final cs = context.cs;

    return TwoColumn(
      main: [
        ProfileCard(
          title: l.pfAboutCompany,
          icon: Icons.apartment_rounded,
          trailing: TextButton(
            onPressed: () => editCompanyInfo(context, ref, p),
            child: Text(l.pfEditProfile),
          ),
          child: CustomText(
            p.about.isEmpty ? '—' : p.about,
            style: tt.bodyLarge,
          ),
        ),
        if (p.engineeringDomains.isNotEmpty)
          ProfileCard(
            title: l.pfDomains,
            icon: Icons.build_outlined,
            iconColor: AppColors.accentGreen,
            child: ResponsiveWrap(
              mobile: 1,
              tablet: 2,
              desktop: 2,
              gap: 12,
              children: [
                for (final (i, d) in p.engineeringDomains.indexed)
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: cs.onSurface.withValues(alpha: .03),
                      borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                      border: Border.all(color: cs.outline),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 12,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors
                                .avatarPalette[i %
                                    AppColors.avatarPalette.length]
                                .withValues(alpha: .14),
                            borderRadius: BorderRadius.circular(
                              AppDimens.radiusSm + 2,
                            ),
                          ),
                          child: Icon(
                            Icons.settings_suggest_rounded,
                            size: 18,
                            color:
                                AppColors.avatarPalette[i %
                                    AppColors.avatarPalette.length],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                d.title,
                                style: tt.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: cs.onSurface,
                                ),
                              ),
                              CustomText(d.description, style: tt.bodySmall),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        if (p.benefits.isNotEmpty)
          ProfileCard(
            title: l.pfBenefits,
            icon: Icons.card_giftcard_rounded,
            iconColor: AppColors.amber,
            child: ResponsiveWrap(
              mobile: 1,
              tablet: 3,
              desktop: 3,
              gap: 12,
              children: [
                for (final b in p.benefits)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: cs.onSurface.withValues(alpha: .03),
                      borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                      border: Border.all(color: cs.outline),
                    ),
                    child: Row(
                      spacing: 8,
                      children: [
                        Icon(
                          Icons.check_circle_outline_rounded,
                          size: 16,
                          color: context.palette.success,
                        ),
                        Expanded(
                          child: CustomText(
                            b,
                            style: tt.bodySmall!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: cs.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
      ],
      side: [
        ProfileCard(
          title: l.pfHrDesk,
          icon: Icons.support_agent_rounded,
          child: Column(
            spacing: 14,
            children: [
              InfoRow(
                icon: Icons.mail_outline_rounded,
                label: l.pfHrEmail,
                value: p.hrEmail,
                onTap: () => openLink(context, 'mailto:${p.hrEmail}'),
              ),
              InfoRow(
                icon: Icons.phone_outlined,
                label: l.pfHelpline,
                value: context.fmtDigits(p.helplineNumber),
                onTap: () => openLink(context, 'tel:${p.helplineNumber}'),
              ),
              InfoRow(
                icon: Icons.place_outlined,
                label: l.pfHeadOffice,
                value: p.location,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
