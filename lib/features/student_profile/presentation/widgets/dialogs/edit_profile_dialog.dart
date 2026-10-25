import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/widgets/custom_overlay_notification.dart';
import '../../providers/student_profile_providers.dart';
import '../profile_core.dart';
import '../profile_ui.dart';

class EditProfileDialog extends ConsumerStatefulWidget {
  const EditProfileDialog({super.key});

  static Future<void> show(BuildContext context) => showDialog<void>(
    context: context,
    builder: (_) => const EditProfileDialog(),
  );

  @override
  ConsumerState<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends ConsumerState<EditProfileDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _institute;
  late final TextEditingController _department;
  late final TextEditingController _phone;
  late final TextEditingController _email;
  late final TextEditingController _bio;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final p = ref.read(studentProfileProvider).value!;
    _name = TextEditingController(text: p.name);
    _institute = TextEditingController(text: p.institute);
    _department = TextEditingController(text: p.department);
    _phone = TextEditingController(text: p.phone);
    _email = TextEditingController(text: p.email);
    _bio = TextEditingController(text: p.bio);
  }

  @override
  void dispose() {
    for (final c in [_name, _institute, _department, _phone, _email, _bio]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final l10n = context.l10n;
    final navigator = Navigator.of(context);

    setState(() => _saving = true);
    try {
      await ref
          .read(studentProfileProvider.notifier)
          .updateBasicInfo(
            name: _name.text.trim(),
            institute: _institute.text.trim(),
            department: _department.text.trim(),
            phone: _phone.text.trim(),
            email: _email.text.trim(),
            bio: _bio.text.trim(),
          );
      navigator.pop();
      CustomToast.showSuccess(message: l10n.profileUpdated);
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
    String? email(String? v) {
      final base = required(v);
      if (base != null) return base;
      return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v!.trim())
          ? null
          : l10n.invalidEmail;
    }

    const gap = SizedBox(height: AppDimens.sm);

    return AppDialog(
      title: l10n.editProfileTitle,
      maxWidth: 560,
      actions: [
        CustomButton(
          label: l10n.cancel,
          variant: CustomButtonVariant.outline,
          onPressed: _saving ? null : () => Navigator.of(context).pop(),
        ),
        CustomButton(label: l10n.save, isLoading: _saving, onPressed: _submit),
      ],
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LabeledTextField(
              label: '${l10n.fullName} *',
              controller: _name,
              validator: required,
              autofillHints: const [AutofillHints.name],
            ),
            gap,
            FieldPair(
              first: LabeledTextField(
                label: '${l10n.polytechnicName} *',
                controller: _institute,
                validator: required,
              ),
              second: LabeledTextField(
                label: '${l10n.technology} *',
                controller: _department,
                validator: required,
              ),
            ),
            gap,
            FieldPair(
              first: LabeledTextField(
                label: '${l10n.phoneNumber} *',
                controller: _phone,
                validator: required,
                keyboardType: TextInputType.phone,
              ),
              second: LabeledTextField(
                label: '${l10n.email} *',
                controller: _email,
                validator: email,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            gap,
            LabeledTextField(
              label: l10n.bioLabel,
              controller: _bio,
              maxLines: 4,
            ),
          ],
        ),
      ),
    );
  }
}
