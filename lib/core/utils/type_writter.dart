import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TypewriterTitle extends StatefulWidget {
  const TypewriterTitle({
    super.key,
    required this.line,
    required this.highlight,
    required this.suffix,
    required this.style,
    required this.crossAlign,
    required this.textAlign,
    required this.wrapAlign,
    required this.gradient,
  });

  final String line;
  final String highlight;
  final String suffix;
  final TextStyle style;
  final CrossAxisAlignment crossAlign;
  final TextAlign textAlign;
  final WrapAlignment wrapAlign;
  final Gradient gradient;

  @override
  State<TypewriterTitle> createState() => TypewriterTitleState();
}

class TypewriterTitleState extends State<TypewriterTitle>
    with SingleTickerProviderStateMixin {
  static const _msPerChar = 150;

  late final AnimationController _controller;

  int get _total =>
      widget.line.length + widget.highlight.length + widget.suffix.length;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _total * _msPerChar),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Clamps [value] into 0..[max].
  int _clamp(int value, int max) => value < 0 ? 0 : (value > max ? max : value);

  /// Builds a span where the first [visible] characters are shown
  /// and the rest are transparent (keeps layout size stable).
  TextSpan _span(String text, int visible, TextStyle style) {
    return TextSpan(
      style: style,
      children: [
        TextSpan(text: text.substring(0, visible)),
        TextSpan(
          text: text.substring(visible),
          style: style.copyWith(color: Colors.transparent),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final typed = (_total * _controller.value).floor();

        final lineN = _clamp(typed, widget.line.length);
        final highlightN = _clamp(
          typed - widget.line.length,
          widget.highlight.length,
        );
        final suffixN = _clamp(
          typed - widget.line.length - widget.highlight.length,
          widget.suffix.length,
        );

        return Column(
          crossAxisAlignment: widget.crossAlign,
          children: [
            Text.rich(
              _span(widget.line, lineN, widget.style),
              textAlign: widget.textAlign,
            ),
            Wrap(
              alignment: widget.wrapAlign,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              children: [
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) =>
                      widget.gradient.createShader(bounds),
                  child: Text.rich(
                    _span(widget.highlight, highlightN, widget.style),
                  ),
                ),
                Text.rich(_span(widget.suffix, suffixN, widget.style)),
              ],
            ),
          ],
        );
      },
    );
  }
}
