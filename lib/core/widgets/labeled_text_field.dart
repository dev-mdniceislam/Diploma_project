import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/theme/theme_pellete.dart';

import 'custom_Textfield.dart';
import 'custom_text.dart';

Color formFieldFill(BuildContext context) =>
    context.isDark ? AppColors.darkSurfaceSecondary : AppColors.background;

Widget formFieldLabel(BuildContext context, String label, {Widget? trailing}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: CustomText(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.85),
            ),
          ),
        ),
        if (trailing != null) trailing,
      ],
    ),
  );
}

/// Label above a themed [CustomTextField].
class LabeledTextField extends StatelessWidget {
  const LabeledTextField({
    super.key,
    required this.label,
    this.controller,
    this.hintText,
    this.validator,
    this.preIcon,
    this.sufIcon,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.onSubmitted,
    this.maxLines = 1,
    this.autofillHints,
    this.inputFormatters,
    this.trailingLabel,
  });

  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final IconData? preIcon;
  final Widget? sufIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final int maxLines;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? trailingLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        formFieldLabel(context, label, trailing: trailingLabel),
        CustomTextField(
          controller: controller,
          hintText: hintText,
          validator: validator,
          preIcon: preIcon == null
              ? null
              : Icon(preIcon, size: 20, color: AppColors.textMuted),
          sufIcon: sufIcon,
          obsecureText: obscureText,
          keyboardType: keyboardType,
          onchanged: onChanged,
          onSubmitted: onSubmitted,
          maxline: maxLines,
          autofillHints: autofillHints,
          inputFormatter: inputFormatters,
          fillColor: formFieldFill(context),
          textColor: Theme.of(context).colorScheme.onSurface,
          borderRadius: 12,
        ),
      ],
    );
  }
}
