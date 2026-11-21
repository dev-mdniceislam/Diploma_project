import 'package:diploma_job/core/extension/l10n_extension.dart';
import 'package:diploma_job/core/responsive/responsive.dart';
import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/utils/type_writter.dart';
import 'package:diploma_job/core/widgets/app_container.dart';
import 'package:diploma_job/core/widgets/custom_text.dart';
import 'package:diploma_job/features/home_screen/presentation/providers/home_providers.dart';
import 'package:diploma_job/features/home_screen/presentation/widgets/hero_section/grouwth_card.dart';
import 'package:diploma_job/features/home_screen/presentation/widgets/hero_section/hero_badge.dart';
import 'package:diploma_job/features/home_screen/presentation/widgets/hero_section/hero_popular_filter.dart';
import 'package:diploma_job/features/home_screen/presentation/widgets/hero_section/hero_search_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Home hero: left = badge, title, subtitle, search, popular filters;
/// right = "Growth Matrix" card. Desktop is 7/5 columns, below that it stacks.
class HomeHero extends ConsumerStatefulWidget {
  const HomeHero({super.key});

  @override
  ConsumerState<HomeHero> createState() => _HomeHeroState();
}

class _HomeHeroState extends ConsumerState<HomeHero> {
  static const _sky300 = Color(
    0xFF7DD3FC,
  ); // tailwind sky-300 (title gradient middle)

  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final desktop = Responsive.isDesktop(context);
    final cross = desktop
        ? CrossAxisAlignment.start
        : CrossAxisAlignment.center;
    final textAlign = desktop ? TextAlign.start : TextAlign.center;
    final wrapAlign = desktop ? WrapAlignment.start : WrapAlignment.center;

    // Keep the field in sync when the filter is reset elsewhere.
    ref.listen<String>(jobFilterProvider.select((f) => f.query), (_, query) {
      if (_searchController.text != query) _searchController.text = query;
    });

    final titleStyle = AppTextStyles.displayLarge.copyWith(
      color: AppColors.white,
      fontSize: Responsive.value(
        context,
        mobile: 30.0,
        tablet: 48.0,
        desktop: 48.0,
      ),
      fontWeight: FontWeight.w900,
      height: 1.25,
    );

    final left = Column(
      crossAxisAlignment: cross,
      spacing: 24,
      children: [
        HeroBadge(text: l10n.heroBadge),
        TypewriterTitle(
          line: l10n.heroTitleLine,
          highlight: l10n.heroTitleHighlight,
          suffix: l10n.heroTitleSuffix,
          style: titleStyle,
          crossAlign: cross,
          textAlign: textAlign,
          wrapAlign: wrapAlign,
          gradient: const LinearGradient(
            colors: [AppColors.primary400, _sky300, AppColors.accentGreenLight],
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 672),
          child: CustomText(
            l10n.heroSubtitle,
            textAlign: textAlign,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textOnDarkMuted,
              fontSize: Responsive.value(context, mobile: 16.0, desktop: 18.0),
              height: 1.6,
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: HeroSearchCard(controller: _searchController),
        ),
        HeroPopularFilters(alignment: wrapAlign),
      ],
    );

    final card = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 448),
      child: const HeroGrowthCard(),
    );

    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.navy900, AppColors.navy900, AppColors.navy950],
        ),
      ),
      child: Stack(
        children: [
          const Positioned(top: -96, right: -96, child: _GlowCircle()),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: Responsive.value(context, mobile: 48.0, desktop: 80.0),
            ),
            child: AppContainer(
              child: desktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 40,
                      children: [
                        Expanded(flex: 7, child: left),
                        Expanded(flex: 5, child: Center(child: card)),
                      ],
                    )
                  : Column(
                      spacing: 40,
                      children: [
                        SizedBox(width: double.infinity, child: left),
                        card,
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Types out the hero title one character at a time.
/// Text keeps its full size from the start (unrevealed part is transparent),
/// so the layout does not jump while typing.

/// Soft blue glow in the top-right corner (HTML: w-96 h-96 bg-primary-600/25 blur-3xl).
class _GlowCircle extends StatelessWidget {
  const _GlowCircle();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: 384,
        height: 384,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              AppColors.primary600.withValues(alpha: 0.25),
              AppColors.primary600.withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }
}
