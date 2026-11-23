import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CtaButton extends StatelessWidget {
  const CtaButton({
    super.key,
    required this.label,
    required this.icon,
    required this.height,
    required this.onPressed,
    this.borderRadius,
  });

  final String label;
  final IconData icon;
  final double height;
  final VoidCallback onPressed;
  final double? borderRadius;

  static final List<BoxShadow> _ctaShadow = [
    BoxShadow(
      color: AppColors.featured.withValues(alpha: 0.35),
      blurRadius: 14,
      offset: const Offset(0, 6),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      label: label,
      icon: icon,
      variant: CustomButtonVariant.primary,
      gradient: AppColors.loginGradient,
      boxShadow: _ctaShadow,
      borderRadius: borderRadius ?? 16,
      buttonHeight: height,
      onPressed: onPressed,
    );
  }
}
