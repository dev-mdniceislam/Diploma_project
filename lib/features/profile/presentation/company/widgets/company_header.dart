import 'package:diploma_job/features/profile/data/model/company_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/gen/assets_gen.dart';
import '../../../../../core/utils/localized_format.dart';
import '../../../profile_core.dart';
import '../../widgets/profile_widgets.dart';
import 'company_actions.dart';

class CompanyHeader extends ConsumerWidget {
  const CompanyHeader(this.p, {super.key});

  final CompanyProfileModel p;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final palette = context.palette;

    return ProfileHeader(
      name: p.companyName,
      imageUrl: p.profileUrl,
      fallbackAsset: Assets.images.appLogo.path,
      coverUrl: p.coverImageUrl,
      subtitle: p.industryCategory,
      badges: [
        if (p.isVerified)
          (
            label: l.pfVerifiedRecruiter,
            icon: Icons.verified_rounded,
            color: palette.success,
          ),
        if (p.isBtebApproved)
          (
            label: l.pfBtebApproved,
            icon: Icons.workspace_premium_rounded,
            color: palette.brand,
          ),
      ],
      meta: [
        if (p.location.isNotEmpty)
          (icon: Icons.place_outlined, text: p.location),
        if (p.employeeCount.trim().isNotEmpty && p.employeeCount.trim() != '0')
          (
            icon: Icons.groups_outlined,
            text: int.tryParse(p.employeeCount.trim()) != null
                ? l.pfEmployees(
                    context.fmtNumber(int.parse(p.employeeCount.trim())),
                  )
                : p.employeeCount.trim(),
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
          value: context.fmtNumber(5000),
          color: palette.brand,
        ),
        HeaderStat(
          label: l.pfStatJobs,
          icon: Icons.work_outline_rounded,
          value: context.fmtNumber(125),
          color: AppColors.info,
        ),
        HeaderStat(
          label: l.pfStatAttachments,
          icon: Icons.school_outlined,
          value: context.fmtNumber(500),
          color: AppColors.urgent,
        ),
        HeaderStat(
          label: l.pfStatApplications,
          icon: Icons.fact_check_outlined,
          value: context.fmtNumber(300),
          color: palette.success,
        ),
      ],
    );
  }
}
