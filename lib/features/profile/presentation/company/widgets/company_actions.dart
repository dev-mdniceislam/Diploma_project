import 'package:diploma_job/features/profile/data/model/company_profile_model.dart';
import 'package:diploma_job/features/profile/providers/company_application_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/widgets/custom_overlay_notification.dart';
import '../../../providers/company_posting_provider.dart';
import '../../../providers/company_profile_provider.dart';
import '../../../providers/profile_infra_provider.dart'; // profileRepositoryProvider
import '../../../providers/ui_state_provider.dart';
import '../../widgets/profile_form_dialog.dart';

Future<void> editCompanyInfo(
  BuildContext context,
  WidgetRef ref,
  CompanyProfileModel p,
) async {
  final l = context.l10n;
  final v = await showProfileForm(
    context,
    title: l.pfEditCompanyTitle,
    submitLabel: l.pfSave,
    fields: [
      FormFieldSpec('companyName', l.pfCompanyName, initial: p.companyName),
      FormFieldSpec(
        'industryCategory',
        l.pfIndustry,
        initial: p.industryCategory,
      ),
      FormFieldSpec(
        'hrEmail',
        l.pfHrEmail,
        kind: FieldKind.email,
        initial: p.hrEmail,
      ),
      FormFieldSpec(
        'helplineNumber',
        l.pfHelpline,
        kind: FieldKind.phone,
        initial: p.helplineNumber,
      ),
      FormFieldSpec(
        'about',
        l.pfCompanyAbout,
        kind: FieldKind.multiline,
        initial: p.about,
        required: false,
      ),
    ],
  );
  if (v == null) return;
  ref.read(companyProfileProvider.notifier).updateInfo(v);
  CustomToast.showSuccess(message: l.pfSaved);
}

Future<void> newPosting(BuildContext context, WidgetRef ref) async {
  final l = context.l10n;
  final v = await showProfileForm(
    context,
    title: l.pfNewPostTitle,
    submitLabel: l.pfPublishNow,
    fields: [
      FormFieldSpec(
        'type',
        l.pfPostCategory,
        kind: FieldKind.choice,
        initial: 'attachment',
        options: {'attachment': l.pfTypeAttachment, 'job': l.pfTypeJob},
      ),
      FormFieldSpec(
        'title',
        l.pfPostTitle,
        hint: 'Sub-Assistant Engineer (PLC & Automation)',
      ),
      FormFieldSpec(
        'tech',
        l.pfPostTech,
        hint: 'Computer, Electrical, Mechanical',
      ),
      FormFieldSpec('seats', l.pfPostSeats, kind: FieldKind.number),
      FormFieldSpec('salary', l.pfPostSalary),
      FormFieldSpec('deadline', l.pfPostDeadline, kind: FieldKind.date),
      FormFieldSpec('location', l.pfPostLocation),
      FormFieldSpec('benefits', l.pfPostBenefits, required: false),
    ],
  );
  if (v == null) return;

  try {
    await ref.read(profileRepositoryProvider).createPosting({
      'jobType': v['type'],
      'title': v['title'],
      'location': v['location'],
      'vacancies': int.tryParse(v['seats'] ?? '') ?? 0,
      'stipend': num.tryParse(v['salary'] ?? '') ?? 0,
      'deadline': v['deadline'],
      'accommodation': v['benefits'] ?? '',
    });
    ref.invalidate(companyPostingsProvider);
  } on AppException catch (e) {
    CustomToast.showError(message: e.message);
    return;
  }

  ref.read(postingFilterProvider.notifier).select('all');
  ref.read(companyTabProvider.notifier).select(0);
  CustomToast.showSuccess(message: l.pfPostedToast);
}

Future<void> scheduleInterview(
  BuildContext context,
  WidgetRef ref,
  CompanyApplicantsModel a,
) async {
  final l = context.l10n;
  final v = await showProfileForm(
    context,
    title: l.pfInterviewTitle,
    submitLabel: l.pfSendNotice,
    note: l.pfInterviewCandidate(a.applicant.name),
    fields: [
      FormFieldSpec('when', l.pfInterviewDate, kind: FieldKind.dateTime),
      FormFieldSpec(
        'place',
        l.pfInterviewPlace,
        hint: 'Boardroom / Google Meet link',
      ),
    ],
  );
  if (v == null) return;

  try {
    await ref
        .read(profileRepositoryProvider)
        .scheduleApplicantInterview(
          applicantId: a.id,
          at: v['when']!,
          place: v['place']!,
        );
    ref.invalidate(companyApplicantsProvider);
  } on AppException catch (e) {
    CustomToast.showError(message: e.message);
    return;
  }

  CustomToast.showSuccess(message: l.pfInterviewSentToast);
}

Future<void> shortlistApplicant(
  BuildContext context,
  WidgetRef ref,
  CompanyApplicantsModel a,
) async {
  final l = context.l10n;
  try {
    await ref
        .read(profileRepositoryProvider)
        .updateApplicantStatus(
          applicationId: a.id,
          body: {'status': 'shortlisted'},
        );
    ref.invalidate(companyApplicantsProvider);
  } on AppException catch (e) {
    CustomToast.showError(message: e.message);
    return;
  }
  CustomToast.showSuccess(message: l.pfSaved);
}
