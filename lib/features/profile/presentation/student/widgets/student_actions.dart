import 'package:diploma_job/features/profile/data/model/student_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/widgets/custom_overlay_notification.dart';
import '../../../providers/student_provider.dart';
import '../../widgets/profile_form_dialog.dart';

Future<void> editStudentInfo(
  BuildContext context,
  WidgetRef ref,
  StudentFullProfileModel p,
) async {
  final l = context.l10n;
  final v = await showProfileForm(
    context,
    title: l.pfEditStudentTitle,
    submitLabel: l.pfSave,
    fields: [
      FormFieldSpec('name', l.pfFullName, initial: p.name),
      FormFieldSpec('institute', l.pfPolytechnic, initial: p.institute),
      FormFieldSpec('department', l.pfTechnology, initial: p.department),
      FormFieldSpec(
        'phone',
        l.pfPhone,
        kind: FieldKind.phone,
        initial: p.phone,
      ),
      FormFieldSpec(
        'email',
        l.pfEmail,
        kind: FieldKind.email,
        initial: p.email,
      ),
      FormFieldSpec(
        'bio',
        l.pfBio,
        kind: FieldKind.multiline,
        initial: p.bio,
        required: false,
      ),
    ],
  );
  if (v == null) return;
  ref.read(studentProfileProvider.notifier).updateInfo(v);
  CustomToast.showSuccess(message: l.pfSaved);
}

Future<void> updateStudentCv(
  BuildContext context,
  WidgetRef ref,
  StudentFullProfileModel p,
) async {
  final l = context.l10n;
  final v = await showProfileForm(
    context,
    title: l.pfUpdateCv,
    submitLabel: l.pfUpdate,
    note: l.pfCvHint,
    fields: [
      FormFieldSpec(
        'cvUrl',
        l.pfCvLink,
        kind: FieldKind.url,
        initial: p.cvUrl ?? "",
        hint: 'https://drive.google.com/file/d/...',
      ),
    ],
  );
  if (v == null) return;
  ref.read(studentProfileProvider.notifier).updateCv(v['cvUrl']!);
  CustomToast.showSuccess(message: l.pfSaved);
}

Future<void> addStudentProject(BuildContext context, WidgetRef ref) async {
  final l = context.l10n;
  final v = await showProfileForm(
    context,
    title: l.pfAddProject,
    submitLabel: l.pfPublish,
    fields: [
      FormFieldSpec('title', l.pfProjectName),
      FormFieldSpec('tech', l.pfProjectTech, hint: 'HTML, Tailwind, JS'),
      FormFieldSpec('description', l.pfProjectDesc, kind: FieldKind.multiline),
    ],
  );
  if (v == null) return;
  ref.read(studentProfileProvider.notifier).addProject(v);
  CustomToast.showSuccess(message: l.pfSaved);
}
