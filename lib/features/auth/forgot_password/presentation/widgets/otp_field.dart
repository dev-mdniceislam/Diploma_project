import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as mui;
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

import 'package:diploma_job/core/extension/l10n_extension.dart'; // context.l10n
import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/utils/auth_validators.dart';
import 'package:diploma_job/core/widgets/custom_button.dart';
import 'package:diploma_job/core/widgets/custom_text.dart';
import 'package:diploma_job/core/widgets/labeled_text_field.dart'; // formFieldFill, formFieldLabel

/// 6-digit OTP input (Pinput) themed with the app palette.
/// Drop-in replacement for the plain OTP LabeledTextField.
class OtpPinField extends StatelessWidget {
  const OtpPinField({
    super.key,
    required this.controller,
    this.label,
    this.onCompleted,
    this.onChanged,
    this.validator,
    this.focusNode,
    this.enabled = true,
    this.autofocus = false,
    this.length = 6,
  });

  final TextEditingController controller;
  final String? label;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final bool enabled;
  final bool autofocus;
  final int length;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    const gap = 8.0;

    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        formFieldLabel(context, label ?? l10n.otpLabel),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: LayoutBuilder(
            builder: (context, c) {
              // Fit all boxes in the available width (mobile-safe).
              final size = ((c.maxWidth - gap * (length - 1)) / length).clamp(
                33.0,
                51.0,
              );

              final base = PinTheme(
                width: size,
                height: size + 4,
                textStyle: AppTextStyles.titleLarge.copyWith(
                  color: scheme.onSurface,
                ),
                decoration: BoxDecoration(
                  color: formFieldFill(context),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border.withOpacity(0.9)),
                ),
              );

              return Material(
                type: MaterialType.transparency,
                child: Pinput(
                  length: length,
                  controller: controller,
                  focusNode: focusNode,
                  enabled: enabled,
                  autofocus: autofocus,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  autofillHints: const [AutofillHints.oneTimeCode],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  separatorBuilder: (_) => const SizedBox(width: gap),
                  defaultPinTheme: base,
                  focusedPinTheme: base.copyDecorationWith(
                    border: Border.all(
                      color: AppColors.primaryNavy,
                      width: 1.6,
                    ),
                  ),
                  submittedPinTheme: base.copyDecorationWith(
                    border: Border.all(color: AppColors.primaryNavy),
                  ),
                  errorPinTheme: base.copyDecorationWith(
                    border: Border.all(color: AppColors.dangerDark),
                  ),
                  errorTextStyle: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.dangerDark,
                  ),
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  validator: validator ?? AuthValidators(l10n).otp,
                  onCompleted: onCompleted,
                  onChanged: onChanged,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Standalone OTP form: 6-digit pin + Verify button (+ optional resend).
class OtpVerifyForm extends StatefulWidget {
  const OtpVerifyForm({
    super.key,
    required this.onVerify,
    this.onResend,
    this.isLoading = false,
    this.title,
    this.subtitle,
  });

  /// Called with the 6-digit code once validation passes.
  final Future<void> Function(String otp) onVerify;
  final VoidCallback? onResend;
  final bool isLoading;
  final String? title;
  final String? subtitle;

  @override
  State<OtpVerifyForm> createState() => _OtpVerifyFormState();
}

class _OtpVerifyFormState extends State<OtpVerifyForm> {
  final _formKey = GlobalKey<FormState>();
  final _otp = TextEditingController();

  @override
  void dispose() {
    _otp.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await widget.onVerify(_otp.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            widget.subtitle ?? l10n.otpSubtitle,
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: 20),
          OtpPinField(
            controller: _otp,
            enabled: !widget.isLoading,
            autofocus: true,
            onCompleted: (_) => _submit(), // auto-submit on 6th digit
          ),
          const SizedBox(height: 20),
          CustomButton(
            label: l10n.verifyOtp,
            fullWidth: true,
            buttonHeight: 48,
            isLoading: widget.isLoading,
            onPressed: widget.isLoading ? null : _submit,
          ),
          if (widget.onResend != null) ...[
            const SizedBox(height: 8),
            TextButton(
              onPressed: widget.isLoading ? null : widget.onResend,
              child: CustomText(
                l10n.resendOtp,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primaryNavy,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
