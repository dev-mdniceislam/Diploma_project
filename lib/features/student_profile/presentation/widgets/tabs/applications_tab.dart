import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/widgets/custom_overlay_notification.dart';
import '../../../domain/entities/student_profile.dart';
import '../../providers/student_profile_providers.dart';
import '../profile_core.dart';
import '../profile_ui.dart';

/// Column flex used by both the header and the rows on wide layouts.
const _flex = [4, 2, 2, 3, 2];

class ApplicationsTab extends ConsumerWidget {
  const ApplicationsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final apps = ref.watch(filteredApplicationsProvider);

    return ProfileCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimens.md),
            child: PanelHeader(
              title: l10n.trackerTitle,
              subtitle: l10n.trackerSubtitle,
              trailing: const _FilterDropdown(),
            ),
          ),
          Divider(height: 1, color: context.scheme.outline),
          if (apps.isEmpty)
            Padding(
              padding: const EdgeInsets.all(AppDimens.lg),
              child: Center(
                child: CustomText(
                  l10n.noApplications,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: context.bodyColor,
                  ),
                ),
              ),
            )
          else
            ResponsiveBuilder(
              mobile: (_) => _CardList(apps: apps),
              desktop: (_) => _Table(apps: apps),
            ),
        ],
      ),
    );
  }
}

String _filterLabel(BuildContext context, ApplicationFilter f) {
  final l10n = context.l10n;
  return switch (f) {
    ApplicationFilter.all => l10n.filterAll,
    ApplicationFilter.shortlisted => l10n.filterShortlisted,
    ApplicationFilter.pending => l10n.filterPending,
    ApplicationFilter.interview => l10n.filterInterview,
  };
}

class _FilterDropdown extends ConsumerWidget {
  const _FilterDropdown();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(applicationFilterProvider);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          context.l10n.filter,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textMuted,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: AppDimens.xs + 2),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.sm),
          decoration: BoxDecoration(
            color: context.mutedSurface,
            borderRadius: BorderRadius.circular(AppDimens.radiusMd - 2),
            border: Border.all(color: context.scheme.outline),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<ApplicationFilter>(
              value: current,
              isDense: true,
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
              dropdownColor: context.scheme.surface,
              style: AppTextStyles.bodySmall.copyWith(
                color: context.scheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
              items: [
                for (final f in ApplicationFilter.values)
                  DropdownMenuItem(
                    value: f,
                    child: CustomText(_filterLabel(context, f)),
                  ),
              ],
              onChanged: (f) {
                if (f != null) {
                  ref.read(applicationFilterProvider.notifier).select(f);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

// ── Shared pieces ───────────────────────────────────────────────────────────
({String label, IconData icon, Color fg, Color bg}) _statusStyle(
  BuildContext context,
  ApplicationStatus status,
) {
  final l10n = context.l10n;
  final p = context.palette;
  return switch (status) {
    ApplicationStatus.shortlisted => (
      label: l10n.statusShortlisted,
      icon: Icons.check_circle_outline_rounded,
      fg: p.success,
      bg: p.successBg,
    ),
    ApplicationStatus.interview => (
      label: l10n.statusInterview,
      icon: Icons.event_available_outlined,
      fg: p.brand,
      bg: p.pillBg,
    ),
    ApplicationStatus.pending => (
      label: l10n.statusPending,
      icon: Icons.schedule_rounded,
      fg: AppColors.urgent,
      bg: AppColors.amber.withValues(alpha: 0.16),
    ),
  };
}

String _typeLabel(BuildContext context, ApplicationType t) => switch (t) {
  ApplicationType.attachment => context.l10n.typeAttachment,
  ApplicationType.job => context.l10n.typeJob,
};

String _actionLabel(BuildContext context, ApplicationStatus s) => switch (s) {
  ApplicationStatus.shortlisted => context.l10n.actionViewMessage,
  ApplicationStatus.interview => context.l10n.actionDetails,
  ApplicationStatus.pending => context.l10n.actionPleaseWait,
};

class _StatusBadgeFor extends StatelessWidget {
  const _StatusBadgeFor(this.status);

  final ApplicationStatus status;

  @override
  Widget build(BuildContext context) {
    final s = _statusStyle(context, status);
    return StatusBadge(
      label: s.label,
      icon: s.icon,
      foreground: s.fg,
      background: s.bg,
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.app});

  final JobApplication app;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => CustomToast.showSuccess(
        message: app.message ?? context.l10n.noMessage,
      ),
      child: CustomText(
        _actionLabel(context, app.status),
        style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _CompanyBlock extends StatelessWidget {
  const _CompanyBlock({required this.app});

  final JobApplication app;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          app.company,
          style: AppTextStyles.bodyMedium.copyWith(
            color: context.scheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        CustomText(
          app.position,
          style: AppTextStyles.bodySmall.copyWith(color: context.bodyColor),
        ),
      ],
    );
  }
}

// ── Wide layout (tablet / desktop) ──────────────────────────────────────────
class _Table extends StatelessWidget {
  const _Table({required this.apps});

  final List<JobApplication> apps;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final headers = [
      l10n.colCompany,
      l10n.colType,
      l10n.colAppliedDate,
      l10n.colCurrentStatus,
      l10n.colAction,
    ];

    return Column(
      children: [
        Container(
          color: context.mutedSurface,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.md,
            vertical: AppDimens.sm,
          ),
          child: Row(
            children: [
              for (var i = 0; i < headers.length; i++)
                Expanded(
                  flex: _flex[i],
                  child: CustomText(
                    headers[i],
                    style: AppTextStyles.bodySmall.copyWith(
                      color: context.bodyColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
        ),
        for (final app in apps) ...[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.md,
              vertical: AppDimens.sm + 2,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: _flex[0],
                  child: _CompanyBlock(app: app),
                ),
                Expanded(
                  flex: _flex[1],
                  child: CustomText(
                    _typeLabel(context, app.type),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: context.scheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  flex: _flex[2],
                  child: CustomText(
                    context.fmtDate(app.appliedAt),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: context.bodyColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: _flex[3],
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: _StatusBadgeFor(app.status),
                  ),
                ),
                Expanded(
                  flex: _flex[4],
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: _ActionButton(app: app),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: context.scheme.outline),
        ],
      ],
    );
  }
}

// ── Mobile layout ───────────────────────────────────────────────────────────
class _CardList extends StatelessWidget {
  const _CardList({required this.apps});

  final List<JobApplication> apps;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final app in apps) ...[
          Padding(
            padding: const EdgeInsets.all(AppDimens.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CompanyBlock(app: app),
                const SizedBox(height: AppDimens.sm),
                Wrap(
                  spacing: AppDimens.sm,
                  runSpacing: AppDimens.xs,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _StatusBadgeFor(app.status),
                    CustomText(
                      _typeLabel(context, app.type),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: context.scheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    CustomText(
                      context.fmtDate(app.appliedAt),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: context.bodyColor,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: _ActionButton(app: app),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: context.scheme.outline),
        ],
      ],
    );
  }
}
