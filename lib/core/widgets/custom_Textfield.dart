import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/theme/app_colors.dart';
import '../theme/app_text_style.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.controller,
    this.validator,
    this.sufIcon,
    this.obsecureText,
    this.keyboardType,
    this.inputFormatter,
    this.filled,
    this.fillColor,
    this.preIcon,
    this.onchanged,
    this.textAlign,
    this.border,
    this.focusBorder,
    this.contentPadding,
    this.errorBuilder,
    this.autovalidateMode,
    this.maxline,
    this.textColor,
    this.textFieldEnabled,
    this.borderRadius,
    this.focusNode,
    this.ontap,
    this.onSubmitted,
    this.maxLength,
    this.readOnly,
    this.autofillHints,
  });

  final String? hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final Widget? sufIcon;
  final bool? obsecureText;
  final bool? filled;
  final bool? textFieldEnabled;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatter;
  final Color? fillColor;
  final Iterable<String>? autofillHints;
  final Widget? preIcon;
  final ValueChanged<String>? onchanged;
  final TextAlign? textAlign;
  final InputBorder? border;
  final InputBorder? focusBorder;
  final EdgeInsetsGeometry? contentPadding;
  final FormFieldErrorBuilder? errorBuilder;
  final AutovalidateMode? autovalidateMode;
  final int? maxline;
  final Color? textColor;
  final double? borderRadius;
  final FocusNode? focusNode;
  final VoidCallback? ontap;
  final ValueChanged<String>? onSubmitted;
  final int? maxLength;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? AppDimens.radiusMd),
      borderSide: BorderSide(color: AppColors.border.withOpacity(0.6)),
    );

    final defaultFocusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? AppDimens.radiusMd),
      borderSide: BorderSide(color: AppColors.primaryNavy, width: 1.5),
    );

    final errorBorderSide = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? AppDimens.radiusMd),
      borderSide: const BorderSide(color: Colors.redAccent),
    );

    return TextFormField(
      readOnly: readOnly ?? false,
      maxLength: maxLength,
      onFieldSubmitted: onSubmitted,
      onTap: ontap,
      autofillHints: autofillHints,
      focusNode: focusNode,
      autofocus: false,
      enabled: textFieldEnabled ?? true,
      maxLines: maxline ?? 1,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
      cursorErrorColor: colorScheme.error,
      textAlign: textAlign ?? TextAlign.start,
      onChanged: onchanged,
      keyboardType: keyboardType,
      inputFormatters: inputFormatter,
      obscureText: obsecureText ?? false,
      controller: controller,
      style: AppTextStyles.bodyMedium.responsive(context).copyWith(
            color: textColor ?? AppColors.textPrimary,
          ),
      cursorColor: AppColors.primaryNavy,
      errorBuilder: errorBuilder,
      decoration: InputDecoration(
        prefixIcon: preIcon,
        suffixIcon: sufIcon,
        filled: filled ?? true,
        fillColor: fillColor ?? AppColors.surface,
        hintText: hintText ?? "",
        hintStyle: AppTextStyles.bodyMedium.responsive(context).copyWith(
              color: AppColors.textSecondary.withOpacity(0.5),
            ),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: AppDimens.md,
              vertical: AppDimens.sm + 2,
            ),
        border: border ?? defaultBorder,
        enabledBorder: border ?? defaultBorder,
        focusedBorder: focusBorder ?? defaultFocusBorder,
        errorBorder: errorBorderSide,
        focusedErrorBorder: errorBorderSide,
        errorStyle: AppTextStyles.bodySmall.responsive(context).copyWith(
              color: Colors.redAccent,
            ),
      ),
      validator: validator,
    );
  }
}
