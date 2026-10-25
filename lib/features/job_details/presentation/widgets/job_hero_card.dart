import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extension/l10n_extension.dart';
import '../../domain/entities/job_circular.dart';
import 'job_core.dart';
import 'job_ui.dart';

/// Cover strip + logo + title + CTA bar + highlights grid.
class JobHeroCard extends StatelessWidget {
  const JobHeroCard({
    super.key,
    required this.details,
    required this.onApply,
    required this.onBookmark,
    required this.onShare,
  });

  final JobDetails details;
  final VoidCallback onApply;
  final VoidCallback onBookmark;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    final c = details.circular;
    final wide = Responsive.isDesktop(context);
    final logoSize = wide ? 88.0 : 72.0;
    final pad = wide ? AppDimens.lg : AppDimens.md;

    final logo = CustomImage(
      imagePath: c.company.logoUrl,
      width: logoSize,
      height: logoSize,
      borderRadius: BorderRadius.circular(AppDimens.radiusMd),
    );
    final info = _Info(circular: c);
    final actions = _Actions(
      applied: details.isApplied,
      bookmarked: details.isBookmarked,
      stretch: !wide,
      onApply: onApply,
      onBookmark: onBookmark,
      onShare: onShare,
    );

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.scheme.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: context.scheme.outline),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: wide ? 86 : 54,
                decoration: const BoxDecoration(
                  gradient: AppColors.heroGradient,
                ),
              ),
              Positioned(left: 10, child: _BackButton()),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(pad),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (wide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      logo,
                      const SizedBox(width: AppDimens.md),
                      Expanded(child: info),
                      const SizedBox(width: AppDimens.md),
                      actions,
                    ],
                  )
                else ...[
                  logo,
                  const SizedBox(height: AppDimens.sm),
                  info,
                  const SizedBox(height: AppDimens.md),
                  actions,
                ],
                const SizedBox(height: AppDimens.md),
                Divider(height: 1, color: context.scheme.outline),
                const SizedBox(height: AppDimens.md),
                _Highlights(circular: c),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    final label = context.l10n.back;

    return Tooltip(
      message: label,
      child: Material(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          onTap: () => context.canPop() ? context.pop() : context.go('/'),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.sm + 2,
              vertical: AppDimens.xs + 2,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.arrow_back_rounded,
                  size: 18,
                  color: Colors.white,
                ),
                const SizedBox(width: 6),
                CustomText(
                  label,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.circular});

  final JobCircular circular;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final p = context.palette;
    final c = circular;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: AppDimens.xs + 2,
          runSpacing: AppDimens.xs,
          children: [
            InfoBadge(
              label: context.circularTypeLabel(c.type, c.semester),
              foreground: p.brand,
              background: p.pillBg,
            ),
            if (c.isVerifiedEmployer)
              InfoBadge(
                label: l10n.verifiedEmployer,
                icon: Icons.verified_rounded,
                foreground: p.success,
                background: p.successBg,
              ),
          ],
        ),
        const SizedBox(height: AppDimens.sm),
        CustomText(
          c.title,
          style: AppTextStyles.headlineMedium
              .responsive(context)
              .copyWith(
                color: context.scheme.onSurface,
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: AppDimens.xs + 2),
        Wrap(
          spacing: AppDimens.sm,
          runSpacing: AppDimens.xs,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _IconText(
              icon: Icons.apartment_rounded,
              text: c.company.name,
              color: p.brand,
              bold: true,
            ),
            _IconText(
              icon: Icons.memory_rounded,
              text: '${l10n.technologyLabel} ${c.technologies.join(', ')}',
              color: context.bodyColor,
            ),
          ],
        ),
      ],
    );
  }
}

class _IconText extends StatelessWidget {
  const _IconText({
    required this.icon,
    required this.text,
    required this.color,
    this.bold = false,
  });

  final IconData icon;
  final String text;
  final Color color;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: color),
        const SizedBox(width: 6),
        Flexible(
          child: CustomText(
            text,
            style: AppTextStyles.bodyMedium.copyWith(
              color: color,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({
    required this.applied,
    required this.bookmarked,
    required this.stretch,
    required this.onApply,
    required this.onBookmark,
    required this.onShare,
  });

  final bool applied;
  final bool bookmarked;
  final bool stretch;
  final VoidCallback onApply;
  final VoidCallback onBookmark;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final p = context.palette;

    final apply = CustomButton(
      label: applied ? l10n.applied : l10n.applyNow,
      icon: applied
          ? Icons.check_circle_outline_rounded
          : Icons.arrow_forward_rounded,
      variant: applied
          ? CustomButtonVariant.accent
          : CustomButtonVariant.primary,
      fullWidth: stretch,
      buttonHeight: 46,
      onPressed: onApply,
    );

    final bookmark = IconButton.outlined(
      tooltip: l10n.bookmarkTooltip,
      onPressed: onBookmark,
      style: bookmarked
          ? IconButton.styleFrom(
              foregroundColor: p.brand,
              backgroundColor: p.pillBg,
              side: BorderSide(color: p.brand.withValues(alpha: 0.4)),
            )
          : null,
      icon: Icon(
        bookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
        size: 20,
      ),
    );

    final share = IconButton.outlined(
      tooltip: l10n.shareTooltip,
      onPressed: onShare,
      icon: const Icon(Icons.share_outlined, size: 19),
    );

    if (stretch) {
      return Row(
        children: [
          Expanded(child: apply),
          const SizedBox(width: AppDimens.sm),
          bookmark,
          const SizedBox(width: AppDimens.xs),
          share,
        ],
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        apply,
        const SizedBox(width: AppDimens.sm),
        bookmark,
        const SizedBox(width: AppDimens.xs),
        share,
      ],
    );
  }
}

class _Highlights extends StatelessWidget {
  const _Highlights({required this.circular});

  final JobCircular circular;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = circular;

    return ResponsiveGrid(
      mobileColumns: 2,
      tabletColumns: 3,
      desktopColumns: 5,
      spacing: AppDimens.sm,
      children: [
        _Highlight(
          label: l10n.hlLocation,
          icon: Icons.location_on_outlined,
          value: c.location,
        ),
        _Highlight(
          label: l10n.hlStipend,
          icon: Icons.payments_outlined,
          value: l10n.stipendPerMonth(c.stipend),
        ),
        _Highlight(
          label: l10n.hlExperience,
          icon: Icons.school_outlined,
          value: context.semesterName(c.semester),
        ),
        _Highlight(
          label: l10n.hlDeadline,
          icon: Icons.schedule_rounded,
          value: context.fmtDate(c.deadline),
        ),
        _Highlight(
          label: l10n.hlVacancies,
          icon: Icons.groups_outlined,
          value: l10n.vacanciesCount(c.vacancies),
        ),
      ],
    );
  }
}

class _Highlight extends StatelessWidget {
  const _Highlight({
    required this.label,
    required this.icon,
    required this.value,
  });

  final String label;
  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.sm + 2),
      decoration: BoxDecoration(
        color: context.mutedSurface,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: context.scheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w700,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(icon, size: 15, color: context.palette.brand),
              const SizedBox(width: 5),
              Expanded(
                child: CustomText(
                  value,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: context.scheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
