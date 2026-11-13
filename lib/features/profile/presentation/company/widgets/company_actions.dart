import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/widgets/custom_overlay_notification.dart';
import '../../../data/profile_models.dart';
import '../../../providers/profile_providers.dart';
import '../../widgets/profile_form_dialog.dart';

Future<void> editCompanyInfo(
  BuildContext context,
  WidgetRef ref,
  CompanyProfile p,
) async {
  final l = context.l10n;
  final v = await showProfileForm(
    context,
    title: l.pfEditCompanyTitle,
    submitLabel: l.pfSave,
    fields: [
      FormFieldSpec('name', l.pfCompanyName, initial: p.name),
      FormFieldSpec('industry', l.pfIndustry, initial: p.industry),
      FormFieldSpec(
        'hrEmail',
        l.pfHrEmail,
        kind: FieldKind.email,
        initial: p.hrEmail,
      ),
      FormFieldSpec(
        'hrPhone',
        l.pfHelpline,
        kind: FieldKind.phone,
        initial: p.hrPhone,
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
  ref.read(companyProfileProvider.notifier).addPosting(v);
  ref.read(postingFilterProvider.notifier).select('all');
  ref.read(companyTabProvider.notifier).select(0);
  CustomToast.showSuccess(message: l.pfPostedToast);
}

Future<void> scheduleInterview(
  BuildContext context,
  WidgetRef ref,
  Applicant a,
) async {
  final l = context.l10n;
  final v = await showProfileForm(
    context,
    title: l.pfInterviewTitle,
    submitLabel: l.pfSendNotice,
    note: l.pfInterviewCandidate(a.name),
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
  ref
      .read(companyProfileProvider.notifier)
      .scheduleInterview(a.id, v['when']!, v['place']!);
  CustomToast.showSuccess(message: l.pfInterviewSentToast);
}
