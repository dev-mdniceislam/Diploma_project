import 'package:diploma_job/core/constants/app_dimens.dart';
import 'package:diploma_job/core/responsive/responsive.dart';
import 'package:diploma_job/core/responsive/responsive_builder.dart';
import 'package:diploma_job/core/responsive/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileShimmerPage extends StatelessWidget {
  const ProfileShimmerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      ignorePointers: false,
      effect: const ShimmerEffect(
        baseColor: Color(0xFFE2E8F0),
        highlightColor: Color(0xFFF8FAFC),
        duration: Duration(milliseconds: 1400),
      ),
      child: ColoredBox(
        color: const Color(0xFFF8FAFC),
        child: SingleChildScrollView(
          child: ResponsiveContainer(
            padding: EdgeInsets.symmetric(horizontal: 100),
            child: Column(
              children: const [
                SizedBox(height: 16),
                _HeaderSkeleton(),
                SizedBox(height: 16),
                _StatsSkeleton(),
                SizedBox(height: 16),
                _TabsSkeleton(),
                SizedBox(height: 16),
                _BodySkeleton(),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Fixed-size skeleton block (rectangle or circle) with explicit width/height.
/// Skeleton.leaf turns this into a bone that Skeletonizer animates.
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
            color: const Color(0xFFE2E8F0),
            shape: circle ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: circle ? null : BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }
}

/// Reusable white card, same look as the real profile cards
class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard({
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: child,
    );
  }
}

/// Cover + overlapping avatar + name + action buttons
class _HeaderSkeleton extends StatelessWidget {
  const _HeaderSkeleton();

  static const double _cardPad = 20;

  @override
  Widget build(BuildContext context) {
    final coverH = Responsive.value<double>(
      context,
      mobile: 150,
      tablet: 200,
      desktop: 260,
    );
    final avatar = Responsive.value<double>(
      context,
      mobile: 92,
      tablet: 112,
      desktop: 128,
    );
    final isMobile = Responsive.isMobile(context);

    const nameBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Bone.text(words: 3, fontSize: 22),
        SizedBox(height: 10),
        Bone.text(words: 5, fontSize: 14),
        SizedBox(height: 8),
        Bone.text(words: 3, fontSize: 12),
      ],
    );

    const actions = Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _Block(width: 150, height: 44, radius: 12),
        _Block(width: 140, height: 44, radius: 12),
        _Block(width: 140, height: 44, radius: 12),
        _Block(width: 44, height: 44, circle: true),
      ],
    );

    return _SkeletonCard(
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Block(width: double.infinity, height: coverH, radius: 0),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    _cardPad,
                    isMobile ? avatar * 0.5 + 12 : 16,
                    _cardPad,
                    _cardPad,
                  ),
                  child: isMobile
                      ? const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [nameBlock, SizedBox(height: 16), actions],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: avatar + 20),
                            const Expanded(child: nameBlock),
                            const SizedBox(width: 16),
                            actions,
                          ],
                        ),
                ),
              ],
            ),
            Positioned(
              left: _cardPad,
              top: coverH - avatar / 2,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: _Block(width: avatar, height: avatar, circle: true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 4 stat cards: 2 columns on mobile, 4 on tablet/desktop
class _StatsSkeleton extends StatelessWidget {
  const _StatsSkeleton();

  @override
  Widget build(BuildContext context) {
    final cols = Responsive.value<int>(
      context,
      mobile: 2,
      tablet: 4,
      desktop: 4,
    );

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cols,
        mainAxisExtent: 96,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (_, __) => _SkeletonCard(
        padding: const EdgeInsets.all(14),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Bone.text(words: 1, fontSize: 10),
            SizedBox(height: 12),
            Bone.text(words: 1, fontSize: 18),
          ],
        ),
      ),
    );
  }
}

/// Pill tabs row
class _TabsSkeleton extends StatelessWidget {
  const _TabsSkeleton();

  @override
  Widget build(BuildContext context) {
    const widths = [110.0, 120.0, 150.0, 130.0, 150.0];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: widths
          .map((w) => _Block(width: w, height: 40, radius: 999))
          .toList(),
    );
  }
}

/// About + Skills on left, Contact + Board info on right (desktop)
class _BodySkeleton extends StatelessWidget {
  const _BodySkeleton();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: (_) => _singleColumn(),
      tablet: (_) => _singleColumn(),
      desktop: (_) => _twoColumn(),
    );
  }

  Widget _singleColumn() => Column(
    children: [
      _aboutCard(),
      const SizedBox(height: 16),
      _techCard(),
      const SizedBox(height: 16),
      _contactCard(),
      const SizedBox(height: 16),
      _boardCard(),
    ],
  );

  Widget _twoColumn() => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: 2,
        child: Column(
          children: [_aboutCard(), const SizedBox(height: 16), _techCard()],
        ),
      ),
      const SizedBox(width: 20),
      Expanded(
        child: Column(
          children: [_contactCard(), const SizedBox(height: 16), _boardCard()],
        ),
      ),
    ],
  );

  Widget _sectionTitle(double titleWidth) => Row(
    children: [
      const _Block(width: 40, height: 40, radius: 10),
      const SizedBox(width: 12),
      Bone.text(words: 2, fontSize: titleWidth / 10),
    ],
  );

  Widget _aboutCard() => _SkeletonCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _sectionTitle(180),
            const Spacer(),
            const Bone.text(words: 1, fontSize: 14),
          ],
        ),
        const SizedBox(height: 20),
        const Bone.text(words: 14, fontSize: 14),
        const SizedBox(height: 10),
        const Bone.text(words: 10, fontSize: 14),
      ],
    ),
  );

  Widget _techCard() => _SkeletonCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(200),
        const SizedBox(height: 20),
        ...List.generate(
          4,
          (i) => Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: _SkillBar(words: 3 + i),
          ),
        ),
      ],
    ),
  );

  Widget _contactCard() => _SkeletonCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(220),
        const SizedBox(height: 20),
        _labelValue(),
        const SizedBox(height: 18),
        _labelValue(),
        const SizedBox(height: 18),
        _labelValue(),
      ],
    ),
  );

  Widget _boardCard() => _SkeletonCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Bone.text(words: 2, fontSize: 18),
        const SizedBox(height: 20),
        ...List.generate(
          4,
          (_) => const Padding(
            padding: EdgeInsets.only(bottom: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Bone.text(words: 2, fontSize: 14),
                Bone.text(words: 1, fontSize: 14),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget _labelValue() => const Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _Block(width: 40, height: 40, radius: 10),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Bone.text(words: 1, fontSize: 10),
            SizedBox(height: 8),
            Bone.text(words: 3, fontSize: 14),
          ],
        ),
      ),
    ],
  );
}

class _SkillBar extends StatelessWidget {
  const _SkillBar({required this.words});

  final int words;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Bone.text(words: words, fontSize: 14)),
            const Bone.text(words: 1, fontSize: 14),
          ],
        ),
        const SizedBox(height: 10),
        const _Block(width: double.infinity, height: 8, radius: 999),
      ],
    );
  }
}
