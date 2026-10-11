import 'package:flutter/material.dart';

import '../constants/app_dimens.dart';
import '../theme/app_colors.dart';

class CustomHover extends StatefulWidget {
  final Widget child;
  final MouseCursor? cursor;
  final bool? isBorder;
  final Color? color; // null = AppColors.surface
  final double lift; // hover-এ কত px ওপরে উঠবে
  final double? radius; // null = AppDimens.radiusMd

  const CustomHover({
    super.key,
    required this.child,
    this.cursor,
    this.isBorder = true,
    this.color,
    this.lift = 4,
    this.radius,
  });

  @override
  State<CustomHover> createState() => _CustomHoverState();
}

class _CustomHoverState extends State<CustomHover> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final base = widget.color ?? AppColors.surface;

    return MouseRegion(
      cursor: widget.cursor ?? SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _hover ? -widget.lift : 0, 0),
        decoration: BoxDecoration(
          color: base,
          borderRadius: BorderRadius.circular(
            widget.radius ?? AppDimens.radiusMd,
          ),
          border: Border.all(
            color: _hover && widget.isBorder == true
                ? AppColors.primaryNavyLight
                : base,
          ),
          boxShadow: _hover
              ? [
                  BoxShadow(
                    color: AppColors.primaryNavyLight.withAlpha(80),
                    blurRadius: 30,
                    spreadRadius: -6,
                  ),
                ]
              : [],
        ),
        child: widget.child,
      ),
    );
  }
}
