import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/utils/localized_format.dart';
import '../../../data/profile_models.dart';
import '../../../profile_core.dart';
import '../../widgets/profile_widgets.dart';
import 'student_actions.dart';
import 'skill_bar.dart';

class StudentOverviewTab extends ConsumerWidget {
  const StudentOverviewTab(this.p, {super.key});

  final StudentProfile p;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final tt = context.tt;
    final board = [
      (l.pfBoardRoll, p.boardRoll),
      (l.pfRegistration, p.registration),
      (l.pfSession, p.session),
      (l.pfNocNumber, p.nocNumber),
    ].where((e) => e.$2.isNotEmpty);

    return TwoColumn(
      main: [
        ProfileCard(
          title: l.pfAboutMe,
          icon: Icons.description_outlined,
          trailing: TextButton(
            onPressed: () => editStudentInfo(context, ref, p),
            child: Text(l.pfEditProfile),
          ),
          child: CustomText(p.bio.isEmpty ? '—' : p.bio, style: tt.bodyLarge),
        ),
        if (p.skills.isNotEmpty)
          ProfileCard(
            title: l.pfSkills,
            icon: Icons.memory_rounded,
            iconColor: AppColors.accentGreen,
            child: Column(
              spacing: 14,
              children: [
                for (final (i, s) in p.skills.indexed)
                  SkillBar(
                    s,
                    AppColors.avatarPalette[i % AppColors.avatarPalette.length],
                  ),
              ],
            ),
          ),
      ],
      side: [
        ProfileCard(
          title: l.pfContactInfo,
          icon: Icons.contacts_outlined,
          child: Column(
            spacing: 14,
            children: [
              InfoRow(
                icon: Icons.mail_outline_rounded,
                label: l.pfEmail,
                value: p.email,
                onTap: () => openLink(context, 'mailto:${p.email}'),
              ),
              InfoRow(
                icon: Icons.phone_outlined,
                label: l.pfPhone,
                value: context.fmtDigits(p.phone),
              ),
              InfoRow(
                icon: Icons.place_outlined,
                label: l.pfAddress,
                value: p.address,
              ),
            ],
          ),
        ),
        if (board.isNotEmpty)
          ProfileCard(
            gradient: AppColors.heroGradient,
            title: l.pfBoardInfo,
            icon: Icons.shield_outlined,
            iconColor: AppColors.accentGreenLight,
            child: Column(
              spacing: 10,
              children: [
                for (final r in board)
                  Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          r.$1,
                          style: tt.bodySmall!.copyWith(
                            color: AppColors.textOnDarkMuted,
                          ),
                        ),
                      ),
                      CustomText(
                        context.fmtDigits(r.$2),
                        style: tt.bodySmall!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
