import 'package:diploma_job/core/constants/app_dimens.dart';
import 'package:diploma_job/core/extension/l10n_extension.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/theme/orbit_palette.dart';
import 'package:flutter/material.dart';

import 'floating_card.dart';

/// Orbital visualization + floating milestone cards।
class OrbitShowcase extends StatefulWidget {
  const OrbitShowcase({super.key});

  @override
  State<OrbitShowcase> createState() => _OrbitShowcaseState();
}

class _OrbitShowcaseState extends State<OrbitShowcase>
    with TickerProviderStateMixin {
  late final AnimationController _outer = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 30),
  )..repeat();

  late final AnimationController _inner = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 40),
  )..repeat();

  @override
  void dispose() {
    _outer.dispose();
    _inner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final p = OrbitPalette.of(context);
    final isLarge = MediaQuery.sizeOf(context).width >= AppDimens.mobileMax;

    final height = isLarge ? 420.0 : 340.0;
    final outerSize = isLarge ? 410.0 : 310.0;
    final innerSize = isLarge ? 290.0 : 220.0;
    final coreSize = isLarge ? 112.0 : 96.0;

    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ── Orbit rings + core ──────────────────────────────
          Center(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                RotationTransition(
                  turns: _outer,
                  child: SizedBox.square(
                    dimension: outerSize,
                    child: Container(
                      width: innerSize,
                      height: innerSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: p.indigo.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: -8,
                            left: outerSize / 2 - 8,
                            child: _Node(size: 16, color: p.cyan, core: true),
                          ),
                          Positioned(
                            bottom: 24,
                            right: 32,
                            child: _Node(size: 14, color: p.amber),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                RotationTransition(
                  turns: Tween<double>(begin: 1, end: 0).animate(_inner),
                  child: Container(
                    width: innerSize,
                    height: innerSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: p.indigo.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: -8,
                          top: innerSize / 2 - 7,
                          child: _Node(size: 14, color: p.violet),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: coreSize,
                  height: coreSize,
                  padding: const EdgeInsets.all(2.5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: p.brandGradient,
                    boxShadow: [
                      BoxShadow(
                        color: p.indigo.withValues(alpha: 0.28),
                        blurRadius: 35,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: FittedBox(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.bolt_outlined,
                              color: p.indigo,
                              size: 28,
                            ),
                            Text(
                              l10n.orbitCoreTitle,
                              style: AppTextStyles.titleMedium.copyWith(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                color: p.ink,
                              ),
                            ),
                            Text(
                              l10n.orbitCoreSubtitle,
                              style: AppTextStyles.bodySmall.copyWith(
                                fontSize: 5,
                                fontWeight: FontWeight.w600,
                                color: p.cyan,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Card 1: Attachment approved (top-left) ─────────
          Positioned(
            top: isLarge ? 24 : 8,
            left: isLarge ? 16 : 0,
            child: FloatingCard(
              period: const Duration(seconds: 6),
              child: _Milestone(
                width: isLarge ? 255 : 225,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _IconBox(
                      icon: Icons.check_circle_outline_rounded,
                      color: p.emerald,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _Badge(
                            text: l10n.cardAttachmentApproved,
                            color: p.emerald,
                          ),
                          const SizedBox(height: 4),
                          _CardTitle(l10n.cardFullStackTitle),
                          const SizedBox(height: 2),
                          _CardSub(l10n.cardFullStackSub),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Card 2: Role match (right-middle) ──────────────
          Positioned(
            right: isLarge ? 45 : 0,
            top: isLarge ? 0 : null,
            bottom: isLarge ? 0 : 56,
            child: Center(
              child: FloatingCard(
                period: const Duration(milliseconds: 7400),
                delay: const Duration(milliseconds: 1200),
                child: _Milestone(
                  width: isLarge ? 200 : 180,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: p.indigo,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              l10n.cardRoleMatch,
                              style: AppTextStyles.bodySmall.copyWith(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: p.indigo,
                              ),
                            ),
                          ),
                          Text(
                            '98%',
                            style: AppTextStyles.headlineMedium.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: p.ink,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(99),
                        child: Container(
                          height: 6,
                          color: p.line,
                          child: FractionallySizedBox(
                            widthFactor: 0.98,
                            alignment: Alignment.centerLeft,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: p.brandGradient,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _CardSub(l10n.cardRoleMatchSub),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Card 3: Interview (bottom-left) ────────────────
          Positioned(
            left: isLarge ? 32 : 8,
            bottom: isLarge ? 16 : -8,
            child: FloatingCard(
              period: const Duration(milliseconds: 6600),
              delay: const Duration(milliseconds: 2400),
              child: _Milestone(
                width: isLarge ? 250 : 225,
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    _IconBox(
                      icon: Icons.work_outline_rounded,
                      color: p.amber,
                      size: 36,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _CardTitle(l10n.cardInterviewTitle),
                          const SizedBox(height: 2),
                          Text(
                            l10n.cardInterviewSub,
                            style: AppTextStyles.bodySmall.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: p.amber,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Private pieces ────────────────────────────────────────────

class _Node extends StatelessWidget {
  const _Node({required this.size, required this.color, this.core = false});

  final double size;
  final Color color;
  final bool core;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
      boxShadow: [
        BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 12),
      ],
    ),
    child: core
        ? Center(
            child: Container(
              width: size * 0.38,
              height: size * 0.38,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          )
        : null,
  );
}

class _Milestone extends StatelessWidget {
  const _Milestone({
    required this.child,
    required this.width,
    this.padding = const EdgeInsets.all(14),
  });

  final Widget child;
  final double width;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final p = OrbitPalette.of(context);
    return Container(
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: p.cardBorder),
        boxShadow: [
          BoxShadow(
            color: p.indigo.withValues(alpha: 0.14),
            blurRadius: 36,
            spreadRadius: -10,
            offset: const Offset(0, 18),
          ),
          BoxShadow(
            color: p.ink.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _IconBox extends StatelessWidget {
  const _IconBox({required this.icon, required this.color, this.size = 36});

  final IconData icon;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Icon(icon, size: size * 0.55, color: color),
  );
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(99),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Text(
      text.toUpperCase(),
      style: AppTextStyles.bodySmall.copyWith(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
        color: color,
      ),
    ),
  );
}

class _CardTitle extends StatelessWidget {
  const _CardTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: AppTextStyles.bodySmall.copyWith(
      fontSize: 13,
      fontWeight: FontWeight.w700,
      color: OrbitPalette.of(context).ink,
    ),
  );
}

class _CardSub extends StatelessWidget {
  const _CardSub(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    maxLines: 1,
    style: AppTextStyles.bodySmall.copyWith(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: OrbitPalette.of(context).muted,
    ),
  );
}
