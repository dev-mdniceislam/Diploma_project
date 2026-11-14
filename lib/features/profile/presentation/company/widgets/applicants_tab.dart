import 'package:diploma_job/features/profile/data/model/company_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/gen/assets_gen.dart';
import '../../../../../core/utils/localized_format.dart';
import '../../../../../core/widgets/custom_overlay_notification.dart';
import '../../../data/profile_models.dart';
import '../../../profile_core.dart';
import '../../../providers/ui_state_provider.dart';
import '../../widgets/profile_widgets.dart';

/// Takes the LIST of applications received by the company.
/// Status changes go through callbacks, so the parent decides which API to call.
class ApplicantsTab extends ConsumerWidget {
  const ApplicantsTab(
    this.applicants, {
    required this.onShortlist,
    required this.onSchedule,
    super.key,
  });

  final List<CompanyApplicantsModel> applicants;
  final void Function(CompanyApplicantsModel a) onShortlist;
  final void Function(CompanyApplicantsModel a) onSchedule;

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
        ? applicants
        : applicants.where((a) => ApplyStatus.parse(a.status).name == filter);

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
          l.pfColPosition,
          l.pfColDate,
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
                    imagePath: a.applicant.avatarUrl.isEmpty
                        ? Assets.icons.maleAvatar
                        : a.applicant.avatarUrl,
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
                      CustomText(a.applicant.name, style: bold),
                      CustomText(a.applicant.email, style: tt.bodySmall),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 4,
                children: [
                  CustomText(a.job.title, style: bold),
                  TypePill(PostType.parse(a.job.jobType)),
                ],
              ),
              CustomText(context.fmtDate(a.createdAt)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () => openLink(context, a.cv),
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
                  if (a.shortMessage.isNotEmpty)
                    InkWell(
                      onTap: () =>
                          CustomToast.showSuccess(message: a.shortMessage),
                      child: CustomText(l.pfViewMessage, style: tt.bodySmall),
                    ),
                ],
              ),
              ApplyStatusPill(ApplyStatus.parse(a.status)),
              switch (ApplyStatus.parse(a.status)) {
                ApplyStatus.shortlisted => CustomButton(
                  label: l.pfScheduleInterview,
                  buttonHeight: 34,
                  onPressed: () => onSchedule(a),
                ),
                ApplyStatus.pending => CustomButton(
                  label: l.pfShortlistAction,
                  variant: CustomButtonVariant.accent,
                  buttonHeight: 34,
                  onPressed: () => onShortlist(a),
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
