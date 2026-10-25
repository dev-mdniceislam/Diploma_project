import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/widgets/custom_overlay_notification.dart';
import '../../providers/student_profile_providers.dart';
import '../profile_core.dart';

class AddProjectDialog extends ConsumerStatefulWidget {
  const AddProjectDialog({super.key});

  static Future<void> show(BuildContext context) => showDialog<void>(
    context: context,
    builder: (_) => const AddProjectDialog(),
  );

  @override
  ConsumerState<AddProjectDialog> createState() => _AddProjectDialogState();
}

class _AddProjectDialogState extends ConsumerState<AddProjectDialog> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _tech = TextEditingController();
  final _desc = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _title.dispose();
    _tech.dispose();
    _desc.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final l10n = context.l10n;
    final navigator = Navigator.of(context);
    final techs = _tech.text
        .split(',')
        .map((t) => t.trim())
        .where((t) => t.isNotEmpty)
        .toList();

    setState(() => _saving = true);
    try {
      await ref
          .read(studentProfileProvider.notifier)
          .addProject(
            title: _title.text.trim(),
            technologies: techs,
            description: _desc.text.trim(),
          );
      navigator.pop();
      CustomToast.showSuccess(message: l10n.projectAdded);
    } on AppException catch (e) {
      CustomToast.showError(message: e.message);
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    String? required(String? v) =>
        (v == null || v.trim().isEmpty) ? l10n.fieldRequired : null;
    const gap = SizedBox(height: AppDimens.sm);

    return AppDialog(
      title: l10n.addProjectTitle,
      actions: [
        CustomButton(
          label: l10n.cancel,
          variant: CustomButtonVariant.outline,
          onPressed: _saving ? null : () => Navigator.of(context).pop(),
        ),
        CustomButton(
          label: l10n.publish,
          isLoading: _saving,
          onPressed: _submit,
        ),
      ],
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LabeledTextField(
              label: '${l10n.projectName} *',
              controller: _title,
              hintText: 'PLC Automation System',
              validator: required,
            ),
            gap,
            LabeledTextField(
              label: '${l10n.projectTech} *',
              controller: _tech,
              hintText: l10n.projectTechHint,
              validator: required,
            ),
            gap,
            LabeledTextField(
              label: '${l10n.projectDesc} *',
              controller: _desc,
              maxLines: 3,
              validator: required,
            ),
          ],
        ),
      ),
    );
  }
}
