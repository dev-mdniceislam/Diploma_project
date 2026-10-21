import 'package:flutter/material.dart';

import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/widgets/labeled_text_field.dart';

/// Password input with show/hide toggle.
class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.trailingLabel,
    this.onSubmitted,
    this.autofillHints,
  });

  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final Widget? trailingLabel;
  final ValueChanged<String>? onSubmitted;
  final Iterable<String>? autofillHints;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return LabeledTextField(
      label: widget.label,
      controller: widget.controller,
      hintText: '••••••••',
      preIcon: Icons.lock_outline_rounded,
      obscureText: _obscure,
      validator: widget.validator,
      trailingLabel: widget.trailingLabel,
      onSubmitted: widget.onSubmitted,
      autofillHints: widget.autofillHints,
      sufIcon: IconButton(
        onPressed: () => setState(() => _obscure = !_obscure),
        icon: Icon(
          _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          size: 20,
          color: AppColors.textMuted,
        ),
      ),
    );
  }
}
