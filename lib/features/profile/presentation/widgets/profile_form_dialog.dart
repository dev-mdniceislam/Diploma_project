import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../../core/extension/l10n_extension.dart';
import '../../profile_core.dart';
import 'profile_widgets.dart';

enum FieldKind {
  text,
  email,
  phone,
  url,
  number,
  multiline,
  date,
  dateTime,
  choice,
}

/// Describes one input. The dialog builds the UI + validation from this list,
/// so every modal in the HTML (edit profile, CV link, add project, new post,
/// schedule interview ...) is just a list of specs.
class FormFieldSpec {
  const FormFieldSpec(
    this.key,
    this.label, {
    this.kind = FieldKind.text,
    this.initial = '',
    this.hint,
    this.required = true,
    this.options = const {},
  });

  final String key, label, initial;
  final String? hint;
  final FieldKind kind;
  final bool required;
  final Map<String, String> options; // choice: value -> label
}

/// Returns the trimmed values by `key`, or null when cancelled.
Future<Map<String, String>?> showProfileForm(
  BuildContext context, {
  required String title,
  required String submitLabel,
  required List<FormFieldSpec> fields,
  String? note,
}) {
  return showDialog<Map<String, String>>(
    context: context,
    builder: (_) => _ProfileFormDialog(
      title: title,
      submitLabel: submitLabel,
      fields: fields,
      note: note,
    ),
  );
}

class _ProfileFormDialog extends StatefulWidget {
  const _ProfileFormDialog({
    required this.title,
    required this.submitLabel,
    required this.fields,
    this.note,
  });

  final String title, submitLabel;
  final List<FormFieldSpec> fields;
  final String? note;

  @override
  State<_ProfileFormDialog> createState() => _ProfileFormDialogState();
}

class _ProfileFormDialogState extends State<_ProfileFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> _ctrl = {
    for (final f in widget.fields)
      f.key: TextEditingController(text: f.initial),
  };

  @override
  void dispose() {
    for (final c in _ctrl.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDate(FormFieldSpec f) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(const Duration(days: 30)),
      lastDate: now.add(const Duration(days: 365 * 5)),
    );
    if (date == null || !mounted) return;

    var picked = date;
    if (f.kind == FieldKind.dateTime) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(now),
      );
      if (time == null || !mounted) return;
      picked = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    }
    final pattern = f.kind == FieldKind.dateTime
        ? 'yyyy-MM-dd HH:mm'
        : 'yyyy-MM-dd';
    _ctrl[f.key]!.text = DateFormat(pattern).format(picked);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(context, {
      for (final e in _ctrl.entries) e.key: e.value.text.trim(),
    });
  }

  FormFieldValidator<String> _validator(FormFieldSpec f, AuthValidators v) =>
      switch (f.kind) {
        FieldKind.email => v.email,
        FieldKind.url =>
          f.required ? (x) => v.notEmpty(x) ?? v.optionalUrl(x) : v.optionalUrl,
        _ => f.required ? v.notEmpty : (_) => null,
      };

  TextInputType? _keyboard(FieldKind k) => switch (k) {
    FieldKind.email => TextInputType.emailAddress,
    FieldKind.phone => TextInputType.phone,
    FieldKind.number => TextInputType.number,
    FieldKind.url => TextInputType.url,
    FieldKind.multiline => TextInputType.multiline,
    _ => null,
  };

  Widget _field(FormFieldSpec f, AuthValidators v) {
    final ctrl = _ctrl[f.key]!;
    final label = f.required ? '${f.label} *' : f.label;

    switch (f.kind) {
      case FieldKind.choice:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            formFieldLabel(context, label),
            SegmentedButton<String>(
              showSelectedIcon: false,
              segments: [
                for (final e in f.options.entries)
                  ButtonSegment(value: e.key, label: Text(e.value)),
              ],
              selected: {ctrl.text},
              onSelectionChanged: (s) => setState(() => ctrl.text = s.first),
            ),
          ],
        );
      case FieldKind.date:
      case FieldKind.dateTime:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            formFieldLabel(context, label),
            CustomTextField(
              controller: ctrl,
              readOnly: true,
              ontap: () => _pickDate(f),
              hintText: f.hint,
              validator: v.notEmpty,
              preIcon: const Icon(
                Icons.event_rounded,
                size: 20,
                color: AppColors.textMuted,
              ),
              fillColor: formFieldFill(context),
              textColor: context.cs.onSurface,
              borderRadius: 12,
            ),
          ],
        );
      default:
        return LabeledTextField(
          label: label,
          controller: ctrl,
          hintText: f.hint,
          validator: _validator(f, v),
          keyboardType: _keyboard(f.kind),
          maxLines: f.kind == FieldKind.multiline ? 3 : 1,
          inputFormatters: f.kind == FieldKind.number
              ? [FilteringTextInputFormatter.digitsOnly]
              : null,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final cs = context.cs;
    final validators = AuthValidators(l);

    return Dialog(
      insetPadding: const EdgeInsets.all(AppDimens.md),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: cs.primary,
                padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        widget.title,
                        style: context.tt.titleMedium!.copyWith(
                          color: cs.onPrimary,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close_rounded, color: cs.onPrimary),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppDimens.md),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 14,
                    children: [
                      if (widget.note != null)
                        CustomText(widget.note!, style: context.tt.bodyMedium),
                      for (final f in widget.fields) _field(f, validators),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 12,
                        children: [
                          CustomButton(
                            label: l.pfCancel,
                            variant: CustomButtonVariant.outline,
                            onPressed: () => Navigator.pop(context),
                          ),
                          CustomButton(
                            label: widget.submitLabel,
                            onPressed: _submit,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
