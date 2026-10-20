import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

enum CustomButtonVariant { primary, accent, outline, outlineOnDark }

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = CustomButtonVariant.primary,
    this.icon,
    this.fullWidth = false,
    this.buttonHeight,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final CustomButtonVariant variant;
  final IconData? icon;
  final bool fullWidth;
  final double? buttonHeight;
  final bool isLoading;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _hovering = false;

  bool get _isDisabled => widget.isLoading || widget.onPressed == null;

  Color get _bg => switch (widget.variant) {
    CustomButtonVariant.primary => AppColors.primaryNavy,
    CustomButtonVariant.accent => AppColors.accentGreen,
    CustomButtonVariant.outline => Colors.transparent,
    CustomButtonVariant.outlineOnDark => Colors.transparent,
  };

  Color get _fg => switch (widget.variant) {
    CustomButtonVariant.primary => AppColors.white,
    CustomButtonVariant.accent => AppColors.white,
    CustomButtonVariant.outline => AppColors.primaryNavy,
    CustomButtonVariant.outlineOnDark => AppColors.white,
  };

  Border? get _border => switch (widget.variant) {
    CustomButtonVariant.outline =>
        Border.all(color: AppColors.border, width: 1.4),
    CustomButtonVariant.outlineOnDark =>
        Border.all(color: AppColors.textOnDarkMuted, width: 1.2),
    _ => null,
  };

  @override
  Widget build(BuildContext context) {
    final content = Row(
      mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.isLoading)
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(_fg),
            ),
          )
        else ...[
          Text(
            widget.label,
            style: AppTextStyles.labelLarge.copyWith(color: _fg),
          ),
          if (widget.icon != null) ...[
            const SizedBox(width: 8),
            Icon(widget.icon, size: 16, color: _fg),
          ],
        ],
      ],
    );

    final hovering = _hovering && !widget.isLoading;

    return MouseRegion(
      cursor: widget.isLoading
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        scale: hovering ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: GestureDetector(
          onTap: _isDisabled ? null : widget.onPressed,
          child: AnimatedContainer(
            height: widget.buttonHeight ?? 45,
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: hovering ? _bg.withOpacity(0.9) : _bg,
              border: _border,
              borderRadius: BorderRadius.circular(5),
            ),
            child: content,
          ),
        ),
      ),
    );
  }
}