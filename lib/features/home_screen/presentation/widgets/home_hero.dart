import 'package:diploma_job/core/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extension/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/app_container.dart';
import '../../../../core/widgets/app_dropdown.dart';
import '../../../../core/widgets/custom_Textfield.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../domain/entities/job.dart';
import '../providers/home_providers.dart';
import 'hero_stats.dart';
import 'job_localizations.dart';

class HomeHero extends ConsumerStatefulWidget {
  const HomeHero({super.key});

  @override
  ConsumerState<HomeHero> createState() => _HomeHeroState();
}

class _HomeHeroState extends ConsumerState<HomeHero> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    // Keep the field in sync when the filter is reset elsewhere.
    ref.listen<String>(jobFilterProvider.select((f) => f.query), (_, query) {
      if (_searchController.text != query) _searchController.text = query;
    });

    final titleStyle = AppTextStyles.displayLarge
        .responsive(context)
        .copyWith(color: AppColors.white, height: 1.3);

    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(gradient: AppColors.heroGradient),
      child: Stack(
        children: [
          const Positioned(
            top: -96,
            right: -96,
            child: _GlowCircle(color: AppColors.primary500),
          ),
          const Positioned(
            bottom: -96,
            left: -96,
            child: _GlowCircle(color: AppColors.accentGreenLight),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: Responsive.value(
                context,
                mobile: 48.0,
                desktop: 80.0,
                tablet: 64.0,
              ),
            ),
            child: AppContainer(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 820),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _HeroBadge(text: l10n.heroBadge),
                      const SizedBox(height: 20),
                      CustomText(
                        l10n.heroTitleLine,
                        textAlign: TextAlign.center,
                        style: titleStyle,
                      ),
                      ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            AppColors.accentGreenLight,
                            AppColors.primary200,
                          ],
                        ).createShader(bounds),
                        child: CustomText(
                          l10n.heroTitleHighlight,
                          textAlign: TextAlign.center,
                          style: titleStyle,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomText(
                        l10n.heroSubtitle,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.textOnDarkMuted,
                        ),
                      ),
                      const SizedBox(height: 32),
                      _SearchCard(controller: _searchController),
                      const HeroStats(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.white.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.accentGreenLight,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: CustomText(
              text,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.accentGreenLight,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: 384,
        height: 384,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color.withOpacity(0.22), color.withOpacity(0)],
          ),
        ),
      ),
    );
  }
}

class _SearchCard extends ConsumerWidget {
  const _SearchCard({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n!;
    final notifier = ref.read(jobFilterProvider.notifier);
    final tech = ref.watch(jobFilterProvider.select((f) => f.tech));

    final searchField = CustomTextField(
      controller: controller,
      hintText: l10n.searchHint,
      preIcon: const Icon(Icons.search_rounded, color: AppColors.textMuted),
      fillColor: AppColors.background,
      borderRadius: 12,
      onchanged: notifier.setQuery, // live filtering, like the HTML keyup
      onSubmitted: (_) => FocusScope.of(context).unfocus(),
    );

    final techDropdown = AppDropdown<String>(
      value: tech?.name ?? 'all',
      prefixIcon: Icons.memory_rounded,
      fillColor: AppColors.background,
      textColor: AppColors.textPrimary,
      dropdownColor: AppColors.white,
      items: [
        AppDropdownItem(value: 'all', label: l10n.allTechnologiesDept),
        for (final t in JobTech.values)
          AppDropdownItem(value: t.name, label: '${t.emoji} ${t.label(l10n)}'),
      ],
      onChanged: (v) =>
          notifier.setTech(v == 'all' ? null : JobTech.values.byName(v)),
    );

    final filterButton = CustomButton(
      label: l10n.filterAction,
      icon: Icons.tune_rounded,
      fullWidth: true,
      buttonHeight: 48,
      // Filtering is live; the button just dismisses the keyboard.
      onPressed: () => FocusScope.of(context).unfocus(),
    );

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Responsive.isMobile(context)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                searchField,
                const SizedBox(height: 12),
                techDropdown,
                const SizedBox(height: 12),
                filterButton,
              ],
            )
          : Row(
              children: [
                Expanded(flex: 5, child: searchField),
                const SizedBox(width: 12),
                Expanded(flex: 4, child: techDropdown),
                const SizedBox(width: 12),
                Expanded(flex: 3, child: filterButton),
              ],
            ),
    );
  }
}
