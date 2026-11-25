import 'package:flutter/material.dart';

/// HTML `bg-clip-text bg-gradient-to-r` এর equivalent।
class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    required this.style,
    required this.gradient,
  });

  final String text;
  final TextStyle style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) => ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) => gradient.createShader(bounds),
        child: Text(text, style: style),
      );
}
