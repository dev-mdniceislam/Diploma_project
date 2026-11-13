import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/custom_Textfield.dart';
import '../widgets/labeled_text_field.dart';

/// Read-only labeled field that opens a picker (date / time) on tap.
class PickerField extends StatelessWidget {
  const PickerField({
    super.key,
    required this.label,
    required this.controller,
    required this.onTap,
    this.hintText,
    this.validator,
    this.icon = Icons.calendar_today_outlined,
  });

  final String label;
  final TextEditingController controller;
  final VoidCallback onTap;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        formFieldLabel(context, label),
        CustomTextField(
          controller: controller,
          hintText: hintText,
          validator: validator,
          readOnly: true,
          ontap: onTap,
          sufIcon: Icon(icon, size: 18, color: AppColors.textMuted),
          fillColor: formFieldFill(context),
          textColor: Theme.of(context).colorScheme.onSurface,
          borderRadius: 12,
        ),
      ],
    );
  }
}
