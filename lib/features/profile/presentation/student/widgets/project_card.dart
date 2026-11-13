import 'package:flutter/material.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../data/model/student_profile_model.dart';
import '../../../profile_core.dart';
import '../../widgets/profile_widgets.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard(this.project, {super.key});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final tt = context.tt;
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            if (project.category.isNotEmpty)
              StatusPill(label: project.category, color: context.palette.brand),
            CustomText(
              project.title,
              style: tt.titleMedium!.copyWith(color: context.cs.onSurface),
            ),
            if (project.description.isNotEmpty)
              CustomText(project.description, style: tt.bodySmall),
            if (project.technologies.isNotEmpty)
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final t in project.technologies)
                    StatusPill(label: t, color: AppColors.textSecondary),
                ],
              ),
            if (project.liveUrl.isNotEmpty || project.repoUrl.isNotEmpty) ...[
              const Divider(height: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (project.liveUrl.isNotEmpty)
                    TextButton.icon(
                      onPressed: () => openLink(context, project.liveUrl),
                      icon: const Icon(Icons.open_in_new_rounded, size: 16),
                      label: Text(l.pfLiveDemo),
                    ),
                  if (project.repoUrl.isNotEmpty)
                    TextButton.icon(
                      onPressed: () => openLink(context, project.repoUrl),
                      icon: const Icon(Icons.code_rounded, size: 16),
                      label: Text(l.pfGithub),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
