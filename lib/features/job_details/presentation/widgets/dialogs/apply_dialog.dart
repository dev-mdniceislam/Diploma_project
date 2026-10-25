import 'package:flutter/material.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/gen/assets_gen.dart';
import '../../../../../core/widgets/custom_overlay_notification.dart';
import '../../../domain/entities/job_circular.dart';
import '../../utils/pick_document.dart';
import '../job_core.dart';
import '../job_ui.dart';
import 'file_drop_zone.dart';

const _maxBytes = 10 * 1024 * 1024; // 5 MB

class ApplyDialog extends StatefulWidget {
  const ApplyDialog({
    super.key,
    required this.circular,
    required this.applicant,
    required this.onSubmit,
  });

  final JobCircular circular;
  final Applicant applicant;
  final Future<void> Function(ApplicationDraft draft) onSubmit;

  static Future<void> show(
    BuildContext context, {
    required JobCircular circular,
    required Applicant applicant,
    required Future<void> Function(ApplicationDraft draft) onSubmit,
  }) => showDialog<void>(
    context: context,
    builder: (_) => ApplyDialog(
      circular: circular,
      applicant: applicant,
      onSubmit: onSubmit,
    ),
  );

  @override
  State<ApplyDialog> createState() => _ApplyDialogState();
}

class _ApplyDialogState extends State<ApplyDialog> {
  final _note = TextEditingController();
  AttachedFile? _cv;
  AttachedFile? _noc;
  String? _cvError;
  String? _nocError;
  bool _submitting = false;

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _pickCv() async {
    final l10n = context.l10n;
    final file = await pickDocument();
    if (file == null || !mounted) return;
    setState(() {
      if (file.sizeBytes > _maxBytes) {
        _cv = null;
        _cvError = l10n.fileTooLarge;
      } else {
        _cv = file;
        _cvError = null;
      }
    });
  }

  Future<void> _pickNoc() async {
    final l10n = context.l10n;
    final file = await pickDocument(
      extensions: const ['pdf', 'jpg', 'jpeg', 'png'],
    );
    if (file == null || !mounted) return;
    setState(() {
      if (file.sizeBytes > _maxBytes) {
        _noc = null;
        _nocError = l10n.fileTooLarge;
      } else {
        _noc = file;
        _nocError = null;
      }
    });
  }

  Future<void> _submit() async {
    final cv = _cv;
    if (cv == null) {
      setState(() => _cvError = context.l10n.cvRequired);
      return;
    }
    final navigator = Navigator.of(context);
    setState(() => _submitting = true);
    try {
      await widget.onSubmit(
        ApplicationDraft(cv: cv, noc: _noc, coverNote: _note.text.trim()),
      );
      navigator.pop();
    } on AppException catch (e) {
      CustomToast.showError(message: e.message);
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = widget.circular;
    final a = widget.applicant;
    const gap = SizedBox(height: AppDimens.sm + 4);

    return AppDialog(
      title: l10n.applyDialogTitle,
      maxWidth: 600,
      actions: [
        CustomButton(
          label: l10n.cancel,
          variant: CustomButtonVariant.outline,
          onPressed: _submitting ? null : () => Navigator.of(context).pop(),
        ),
        CustomButton(
          label: l10n.confirmApplication,
          icon: Icons.check_rounded,
          isLoading: _submitting,
          onPressed: _submit,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            '${c.title} • ${c.company.name}',
            style: AppTextStyles.bodySmall.copyWith(color: context.bodyColor),
          ),
          gap,
          _ApplicantTile(applicant: a),
          gap,
          _FieldLabel(l10n.cvUploadLabel),
          FileDropZone(
            file: _cv,
            hint: l10n.maxFileSize,
            errorText: _cvError,
            onPick: _pickCv,
            onRemove: () => setState(() => _cv = null),
          ),
          gap,
          _FieldLabel(l10n.nocUploadLabel),
          FileDropZone(
            file: _noc,
            compact: true,
            hint: l10n.maxFileSize,
            errorText: _nocError,
            onPick: _pickNoc,
            onRemove: () => setState(() => _noc = null),
          ),
          gap,
          _ReadOnlyPair(
            first: LabeledValue(
              label: l10n.expectedStipend,
              value:
                  '${l10n.stipendPerMonth(c.stipend)} ${l10n.companyDecided}',
            ),
            second: LabeledValue(
              label: l10n.currentSemester,
              value: l10n.metricStatusValue(context.semesterName(a.semester)),
            ),
          ),
          gap,
          LabeledTextField(
            label: l10n.coverNoteLabel,
            controller: _note,
            hintText: l10n.coverNoteHint,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => formFieldLabel(context, text);
}

class _ApplicantTile extends StatelessWidget {
  const _ApplicantTile({required this.applicant});

  final Applicant applicant;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.sm + 2),
      decoration: BoxDecoration(
        color: context.palette.pillBg,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
      ),
      child: Row(
        children: [
          CustomImage(
            imagePath: applicant.avatarUrl.isEmpty
                ? Assets.icons.maleAvatar
                : applicant.avatarUrl,
            width: 44,
            height: 44,
            borderRadius: BorderRadius.circular(22),
          ),
          const SizedBox(width: AppDimens.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  context.l10n.applicantNameRoll(
                    applicant.name,
                    context.fmtDigits(applicant.roll),
                  ),
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: context.scheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                CustomText(
                  applicant.institute,
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

class _ReadOnlyPair extends StatelessWidget {
  const _ReadOnlyPair({required this.first, required this.second});

  final Widget first;
  final Widget second;

  @override
  Widget build(BuildContext context) {
    Widget box(Widget child) => Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimens.sm + 2),
      decoration: BoxDecoration(
        color: context.mutedSurface,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: context.scheme.outline),
      ),
      child: child,
    );

    if (Responsive.isMobile(context)) {
      return Column(
        children: [
          box(first),
          const SizedBox(height: AppDimens.sm),
          box(second),
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: box(first)),
        const SizedBox(width: AppDimens.sm),
        Expanded(child: box(second)),
      ],
    );
  }
}
