import 'package:diploma_job/core/responsive/responsive.dart';
import 'package:diploma_job/core/responsive/responsive_builder.dart';
import 'package:diploma_job/core/responsive/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

const _lightBase = Color(0xFFE2E8F0);
const _lightHighlight = Color(0xFFF8FAFC);
const _darkBase = Color(0xFF1E293B);
const _darkHighlight = Color(0xFF334155);
const _heroBg = Color(0xFF0B1224);
const _pageBg = Color(0xFFF8FAFC);

class HomeShimmerPage extends StatelessWidget {
  const HomeShimmerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _pageBg,
      child: const SingleChildScrollView(
        child: Column(
          children: [
            _HeroSkeleton(),
            _ListingSkeleton(),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

/// Fixed-size skeleton block. Skeleton.leaf makes Skeletonizer animate it.
class _Block extends StatelessWidget {
  const _Block({this.width, this.height, this.radius = 8, this.circle = false});

  final double? width;
  final double? height;
  final double radius;
  final bool circle;

  @override
  Widget build(BuildContext context) {
    return Skeleton.leaf(
      child: SizedBox(
        width: width,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: _lightBase,
            shape: circle ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: circle ? null : BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────
///  Hero section (dark banner)
/// ─────────────────────────────────────────────────────────────

class _HeroSkeleton extends StatelessWidget {
  const _HeroSkeleton();

  @override
  Widget build(BuildContext context) {
    final vPad = Responsive.value<double>(
      context,
      mobile: 32,
      tablet: 48,
      desktop: 64,
    );

    return Skeletonizer(
      enabled: true,
      ignorePointers: false,
      effect: const ShimmerEffect(
        baseColor: _darkBase,
        highlightColor: _darkHighlight,
        duration: Duration(milliseconds: 1400),
      ),
      child: Container(
        width: double.infinity,
        color: _heroBg,
        padding: EdgeInsets.symmetric(vertical: vPad),
        child: ResponsiveContainer(
          child: ResponsiveBuilder(
            mobile: (_) => const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HeroText(),
                SizedBox(height: 32),
                _HeroVisual(height: 220),
              ],
            ),
            desktop: (_) => const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 11, child: _HeroText()),
                SizedBox(width: 40),
                Expanded(flex: 9, child: _HeroVisual(height: 380)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroText extends StatelessWidget {
  const _HeroText();

  @override
  Widget build(BuildContext context) {
    final titleSize = Responsive.value<double>(
      context,
      mobile: 32,
      tablet: 42,
      desktop: 52,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // "Top career hub" badge
        const _Block(width: 300, height: 34, radius: 999),
        const SizedBox(height: 24),
        // Headline (2 lines)
        Bone.text(words: 4, fontSize: titleSize),
        const SizedBox(height: 10),
        Bone.text(words: 4, fontSize: titleSize),
        const SizedBox(height: 20),
        // Subtitle (2 lines)
        const Bone.text(words: 14, fontSize: 17),
        const SizedBox(height: 8),
        const Bone.text(words: 9, fontSize: 17),
        const SizedBox(height: 28),
        // Search bar
        const _Block(width: double.infinity, height: 60, radius: 16),
        const SizedBox(height: 16),
        // Popular filters
        const Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Bone.text(words: 2, fontSize: 14),
            _Block(width: 90, height: 30, radius: 999),
            _Block(width: 90, height: 30, radius: 999),
            _Block(width: 90, height: 30, radius: 999),
          ],
        ),
      ],
    );
  }
}

class _HeroVisual extends StatelessWidget {
  const _HeroVisual({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return _Block(width: double.infinity, height: height, radius: 24);
  }
}

/// ─────────────────────────────────────────────────────────────
///  Listing section (light)
/// ─────────────────────────────────────────────────────────────

class _ListingSkeleton extends StatelessWidget {
  const _ListingSkeleton();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      ignorePointers: false,
      effect: const ShimmerEffect(
        baseColor: _lightBase,
        highlightColor: _lightHighlight,
        duration: Duration(milliseconds: 1400),
      ),
      child: const ResponsiveContainer(
        child: Padding(
          padding: EdgeInsets.only(top: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FilterRow(),
              SizedBox(height: 24),
              Divider(height: 1, color: _lightBase),
              SizedBox(height: 24),
              _JobGrid(),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  const _FilterRow();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _Block(width: 150, height: 44, radius: 999),
        _Block(width: 140, height: 44, radius: 999),
        _Block(width: 230, height: 44, radius: 999),
        _Block(width: 200, height: 46, radius: 12),
      ],
    );
  }
}

class _JobGrid extends StatelessWidget {
  const _JobGrid();

  @override
  Widget build(BuildContext context) {
    final cols = Responsive.gridColumns(context, desktopMax: 3);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cols,
        mainAxisExtent: 330,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (_, __) => const _JobCardSkeleton(),
    );
  }
}

class _JobCardSkeleton extends StatelessWidget {
  const _JobCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _lightBase),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo + title + company + bookmark
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Block(width: 52, height: 52, radius: 14),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Bone.text(words: 5, fontSize: 16),
                    SizedBox(height: 8),
                    Bone.text(words: 3, fontSize: 13),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const _Block(width: 20, height: 24, radius: 4),
            ],
          ),
          const SizedBox(height: 14),
          // Tags
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Block(width: 130, height: 26, radius: 999),
              _Block(width: 90, height: 26, radius: 999),
              _Block(width: 110, height: 26, radius: 999),
              _Block(width: 100, height: 26, radius: 999),
            ],
          ),
          const SizedBox(height: 14),
          // Description
          const Bone.text(words: 14, fontSize: 14),
          const SizedBox(height: 6),
          const Bone.text(words: 10, fontSize: 14),
          const SizedBox(height: 16),
          Container(height: 1, color: _lightBase),
          const SizedBox(height: 12),
          // Location + salary
          const Row(
            children: [
              Expanded(child: Bone.text(words: 3, fontSize: 13)),
              SizedBox(width: 12),
              Bone.text(words: 1, fontSize: 13),
            ],
          ),
          const Spacer(),
          // Deadline + apply button
          const Row(
            children: [
              Bone.text(words: 2, fontSize: 13),
              Spacer(),
              _Block(width: 110, height: 40, radius: 10),
            ],
          ),
        ],
      ),
    );
  }
}