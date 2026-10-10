import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_dimens.dart';
import '../../../../core/theme/app_colors.dart';
import '../theme/app_text_style.dart';
import 'custom_Textfield.dart';

class CustomFieldWithTitle extends StatelessWidget {
  const CustomFieldWithTitle({
    super.key,
    this.title,
    this.validator,
    this.controller,
    this.hintText,
    this.preIcon,
    this.sufIcon,
    this.obsecureText,
    this.errorBuilder,
    this.autovalidateMode,
    this.onchanged,
    this.fillColor,
    this.contentPadding,
    this.maxline,
    this.inputFormatter,
    this.keyboardType,
    this.titleColor,
    this.textColor,
    this.borderRadius,
    this.fieldValueRequired,
    this.titleSize,
    this.readOnly,
    this.autofillHints,
  });

  final String? title;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final String? hintText;
  final Widget? preIcon;
  final Widget? sufIcon;
  final bool? obsecureText;
  final FormFieldErrorBuilder? errorBuilder;
  final AutovalidateMode? autovalidateMode;
  final ValueChanged<String>? onchanged;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxline;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType? keyboardType;
  final Color? titleColor;
  final Color? textColor;
  final double? borderRadius;
  final bool? fieldValueRequired;
  final double? titleSize;
  final Iterable<String>? autofillHints;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null && title!.isNotEmpty) ...[
          RichText(
            text: TextSpan(
              text: title,
              style: AppTextStyles.titleMedium
                  .responsive(context)
                  .copyWith(
                    color: titleColor ?? AppColors.textPrimary,
                    fontSize: titleSize,
                    fontWeight: FontWeight.w600,
                  ),
              children: (fieldValueRequired ?? false)
                  ? [
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: Colors.red.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]
                  : [],
            ),
          ),
          const SizedBox(height: AppDimens.xs),
        ],
        if (maxline != null && maxline! > 1)
          _buildTextField()
        else
          SizedBox(height: 38, child: _buildTextField()),
      ],
    );
  }

  Widget _buildTextField() {
    return CustomTextField(
      readOnly: readOnly,
      borderRadius: borderRadius ?? AppDimens.radiusMd,
      textColor: textColor,
      keyboardType: keyboardType ?? TextInputType.text,
      inputFormatter: inputFormatter,
      maxline: maxline ?? 1,
      contentPadding:
          contentPadding ??
          const EdgeInsets.symmetric(horizontal: AppDimens.sm, vertical: 7),
      onchanged: onchanged,
      autovalidateMode: autovalidateMode,
      errorBuilder: errorBuilder,
      obsecureText: obsecureText ?? false,
      controller: controller,
      validator: validator,
      autofillHints: autofillHints,
      preIcon: preIcon,
      sufIcon: sufIcon,
      filled: true,
      hintText: hintText,
      fillColor: fillColor ?? AppColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? AppDimens.radiusSm),
        borderSide: BorderSide(color: AppColors.border),
      ),
      focusBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? AppDimens.radiusSm),
        borderSide: BorderSide(color: AppColors.primaryNavy, width: 1.5),
      ),
    );
  }
}
