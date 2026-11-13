import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/gen/assets_gen.dart';
import '../../../../../core/utils/localized_format.dart';
import '../../../data/profile_models.dart';
import '../../../profile_core.dart';
import '../../widgets/profile_widgets.dart';
import 'company_actions.dart';

class CompanyHeader extends ConsumerWidget {
  const CompanyHeader(this.p, {super.key});

  final CompanyProfile p;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final palette = context.palette;

    return ProfileHeader(
      name: p.name,
      imageUrl: p.logoUrl,
      fallbackAsset: Assets.images.appLogo.path,
      coverUrl: p.coverUrl,
      subtitle: p.industry,
      badges: [
        if (p.verified)
          (
            label: l.pfVerifiedRecruiter,
            icon: Icons.verified_rounded,
            color: palette.success,
          ),
        if (p.btebPartner)
          (
            label: l.pfBtebApproved,
            icon: Icons.workspace_premium_rounded,
            color: palette.brand,
          ),
      ],
      meta: [
        if (p.location.isNotEmpty)
          (icon: Icons.place_outlined, text: p.location),
        if (p.employees > 0)
          (
            icon: Icons.groups_outlined,
            text: l.pfEmployees(context.fmtNumber(p.employees)),
          ),
        if (p.website.isNotEmpty)
          (icon: Icons.language_rounded, text: p.website),
      ],
      actions: [
        CustomButton(
          label: l.pfNewPost,
          icon: Icons.add_circle_outline_rounded,
          onPressed: () => newPosting(context, ref),
        ),
        CustomButton(
          label: l.pfEditProfile,
          icon: Icons.settings_outlined,
          variant: CustomButtonVariant.outline,
          onPressed: () => editCompanyInfo(context, ref, p),
        ),
        IconButton.outlined(
          onPressed: () => copyProfileLink(context),
          icon: const Icon(Icons.share_outlined, size: 18),
        ),
      ],
      stats: [
        HeaderStat(
          label: l.pfStatTotalPosts,
          icon: Icons.layers_rounded,
          value: context.fmtNumber(p.postings.length),
          color: palette.brand,
        ),
        HeaderStat(
          label: l.pfStatJobs,
          icon: Icons.work_outline_rounded,
          value: context.fmtNumber(p.jobCount),
          color: AppColors.info,
        ),
        HeaderStat(
          label: l.pfStatAttachments,
          icon: Icons.school_outlined,
          value: context.fmtNumber(p.attachmentCount),
          color: AppColors.urgent,
        ),
        HeaderStat(
          label: l.pfStatApplications,
          icon: Icons.fact_check_outlined,
          value: context.fmtNumber(p.applicationCount),
          color: palette.success,
        ),
      ],
    );
  }
}
