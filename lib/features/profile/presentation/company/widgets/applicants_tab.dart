import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/gen/assets_gen.dart';
import '../../../../../core/utils/localized_format.dart';
import '../../../../../core/widgets/custom_overlay_notification.dart';
import '../../../data/profile_models.dart';
import '../../../profile_core.dart';
import '../../../providers/profile_providers.dart';
import '../../widgets/profile_widgets.dart';
import 'company_actions.dart';

class ApplicantsTab extends ConsumerWidget {
  const ApplicantsTab(this.p, {super.key});

  final CompanyProfile p;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final tt = context.tt;
    final bold = tt.bodyMedium!.copyWith(
      fontWeight: FontWeight.w700,
      color: context.cs.onSurface,
    );
    final filter = ref.watch(applicantFilterProvider);
    final shown = filter == 'all'
        ? p.applicants
        : p.applicants.where((a) => a.status.name == filter);

    return ProfileCard(
      title: l.pfApplicantsTitle,
      subtitle: l.pfApplicantsSub,
      trailing: FilterDropdown(
        value: filter,
        items: statusFilterItems(l),
        onChanged: ref.read(applicantFilterProvider.notifier).select,
      ),
      child: ProfileTable(
        columns: [
          l.pfColStudent,
          l.pfColTechCgpa,
          l.pfColPosition,
          l.pfColDocs,
          l.pfStatus,
          l.pfColAction,
        ],
        rows: <List<Widget>>[
          for (final a in shown)
            [
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                children: [
                  CustomImage(
                    imagePath: a.avatarUrl.isEmpty
                        ? Assets.icons.maleAvatar
                        : a.avatarUrl,
                    width: 36,
                    height: 36,
                    borderRadius: BorderRadius.circular(AppDimens.radiusMd - 2),
                    errorWidget: Image.asset(
                      Assets.icons.maleAvatar,
                      width: 36,
                      height: 36,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(a.name, style: bold),
                      CustomText(a.polytechnic, style: tt.bodySmall),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(a.technology, style: bold),
                  CustomText(
                    l.pfCgpaValue(context.fmtNumber(a.cgpa, decimals: 2)),
                    style: tt.bodySmall!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: context.palette.brand,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 4,
                children: [
                  TypePill(a.type),
                  CustomText(a.position, style: tt.bodySmall),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 4,
                children: [
                  InkWell(
                    onTap: () => openLink(context, a.cvUrl),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 4,
                      children: [
                        Icon(
                          Icons.description_outlined,
                          size: 14,
                          color: context.palette.brand,
                        ),
                        CustomText(
                          'CV',
                          style: tt.bodySmall!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: context.palette.brand,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (a.nocAttached)
                    StatusPill(
                      label: l.pfNocAttached,
                      color: context.palette.success,
                    ),
                ],
              ),
              ApplyStatusPill(a.status, interviewAt: a.interviewAt),
              switch (a.status) {
                ApplyStatus.shortlisted => CustomButton(
                  label: l.pfScheduleInterview,
                  buttonHeight: 34,
                  onPressed: () => scheduleInterview(context, ref, a),
                ),
                ApplyStatus.pending => CustomButton(
                  label: l.pfShortlistAction,
                  variant: CustomButtonVariant.accent,
                  buttonHeight: 34,
                  onPressed: () {
                    ref.read(companyProfileProvider.notifier).shortlist(a.id);
                    CustomToast.showSuccess(message: l.pfShortlistedToast);
                  },
                ),
                ApplyStatus.interview => CustomText(
                  l.pfDone,
                  style: tt.bodySmall!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textMuted,
                  ),
                ),
              },
            ],
        ],
      ),
    );
  }
}
