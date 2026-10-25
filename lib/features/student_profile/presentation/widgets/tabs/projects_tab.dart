import 'package:flutter/material.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../domain/entities/student_profile.dart';
import '../../../../../core/utils/open_link.dart';
import '../dialogs/add_project_dialog.dart';
import '../profile_core.dart';
import '../profile_ui.dart';

class ProjectsTab extends StatelessWidget {
  const ProjectsTab({super.key, required this.projects});

  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PanelHeader(
          title: l10n.portfolioTitle,
          subtitle: l10n.portfolioSubtitle,
          trailing: CustomButton(
            label: l10n.addProject,
            icon: Icons.add_rounded,
            onPressed: () => AddProjectDialog.show(context),
          ),
        ),
        const SizedBox(height: AppDimens.md),
        ResponsiveGrid(
          mobileColumns: 1,
          tabletColumns: 2,
          desktopColumns: 2,
          spacing: AppDimens.md,
          children: [for (final p in projects) _ProjectCard(project: p)],
        ),
      ],
    );
  }
}

IconData _projectIcon(ProjectIcon icon) => switch (icon) {
  ProjectIcon.calculator => Icons.calculate_outlined,
  ProjectIcon.shopping => Icons.shopping_bag_outlined,
  ProjectIcon.code => Icons.code_rounded,
};

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final p = context.palette;
    final hasLinks = project.liveUrl != null || project.repoUrl != null;

    return ProfileCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      project.category ?? l10n.newProject,
                      style: AppTextStyles.overline.copyWith(color: p.brand),
                    ),
                    const SizedBox(height: 2),
                    CustomText(
                      project.title,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: context.scheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppDimens.sm),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: p.pillBg,
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                ),
                child: Icon(
                  _projectIcon(project.icon),
                  size: 22,
                  color: p.brand,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.sm),
          CustomText(
            project.description,
            style: AppTextStyles.bodyMedium.copyWith(color: context.bodyColor),
          ),
          const SizedBox(height: AppDimens.sm),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final t in project.technologies)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: context.mutedSurface,
                    borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                  ),
                  child: CustomText(
                    t,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: context.bodyColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 11.5,
                    ),
                  ),
                ),
            ],
          ),
          if (hasLinks) ...[
            const SizedBox(height: AppDimens.sm),
            Divider(height: 1, color: context.scheme.outline),
            const SizedBox(height: AppDimens.xs),
            Wrap(
              spacing: AppDimens.sm,
              children: [
                if (project.liveUrl != null)
                  TextButton.icon(
                    onPressed: () => openLink(context, project.liveUrl!,context.l10n.linkOpenFailed),
                    icon: const Icon(Icons.open_in_new_rounded, size: 16),
                    label: CustomText(l10n.liveDemo),
                  ),
                if (project.repoUrl != null)
                  TextButton.icon(
                    onPressed: () => openLink(context, project.repoUrl!,context.l10n.linkOpenFailed),
                    icon: const Icon(Icons.code_rounded, size: 16),
                    label: CustomText(l10n.githubCode),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
