import 'package:flutter/material.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../domain/entities/student_profile.dart';
import '../dialogs/edit_profile_dialog.dart';
import '../profile_core.dart';
import '../profile_ui.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key, required this.profile});

  final StudentProfile profile;

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: AppDimens.md);

    final main = Column(
      children: [
        _BioCard(profile: profile),
        gap,
        _SkillsCard(skills: profile.skills),
      ],
    );
    final side = Column(
      children: [
        _ContactCard(profile: profile),
        gap,
        _BoardCard(profile: profile),
      ],
    );

    Widget stacked(BuildContext _) => Column(children: [main, gap, side]);

    return ResponsiveBuilder(
      mobile: stacked,
      tablet: stacked,
      desktop: (_) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: main),
          const SizedBox(width: AppDimens.md),
          Expanded(child: side),
        ],
      ),
    );
  }
}

class _BioCard extends StatelessWidget {
  const _BioCard({required this.profile});

  final StudentProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ProfileCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardTitle(
            icon: Icons.description_outlined,
            title: l10n.aboutMe,
            trailing: TextButton(
              onPressed: () => EditProfileDialog.show(context),
              child: CustomText(l10n.edit),
            ),
          ),
          const SizedBox(height: AppDimens.sm),
          CustomText(
            profile.bio,
            style: AppTextStyles.bodyMedium.copyWith(color: context.bodyColor),
          ),
        ],
      ),
    );
  }
}

class _SkillsCard extends StatelessWidget {
  const _SkillsCard({required this.skills});

  final List<SkillLevel> skills;

  @override
  Widget build(BuildContext context) {
    return ProfileCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardTitle(
            icon: Icons.memory_rounded,
            title: context.l10n.techProficiency,
            iconColor: AppColors.accentGreenDark,
          ),
          const SizedBox(height: AppDimens.md),
          for (var i = 0; i < skills.length; i++) ...[
            if (i > 0) const SizedBox(height: AppDimens.sm + 4),
            _SkillBar(skill: skills[i]),
          ],
        ],
      ),
    );
  }
}

class _SkillBar extends StatelessWidget {
  const _SkillBar({required this.skill});

  final SkillLevel skill;

  @override
  Widget build(BuildContext context) {
    final color = skillToneColor(skill.tone);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomText(
                skill.name,
                style: AppTextStyles.bodySmall.copyWith(
                  color: context.scheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            CustomText(
              context.fmtPercent(skill.percent),
              style: AppTextStyles.bodySmall.copyWith(
                color: context.palette.brand,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: skill.percent / 100),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOut,
            builder: (_, value, __) => LinearProgressIndicator(
              value: value,
              minHeight: 8,
              color: color,
              backgroundColor: context.mutedSurface,
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({required this.profile});

  final StudentProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ProfileCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardTitle(
            icon: Icons.contact_page_outlined,
            title: l10n.contactInfo,
            iconColor: AppColors.featured,
          ),
          Divider(height: AppDimens.md * 1.5, color: context.scheme.outline),
          _ContactRow(
            icon: Icons.mail_outline_rounded,
            label: l10n.emailAddress,
            value: profile.email,
          ),
          const SizedBox(height: AppDimens.sm),
          _ContactRow(
            icon: Icons.phone_outlined,
            label: l10n.phoneNumber,
            value: context.fmtDigits(profile.phone),
          ),
          const SizedBox(height: AppDimens.sm),
          _ContactRow(
            icon: Icons.location_on_outlined,
            label: l10n.currentAddress,
            value: profile.location,
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: context.mutedSurface,
            borderRadius: BorderRadius.circular(AppDimens.radiusSm + 2),
          ),
          child: Icon(icon, size: 17, color: context.bodyColor),
        ),
        const SizedBox(width: AppDimens.sm),
        Expanded(
          child: LabeledValue(label: label, value: value),
        ),
      ],
    );
  }
}

class _BoardCard extends StatelessWidget {
  const _BoardCard({required this.profile});

  final StudentProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ProfileCard(
      gradient: AppColors.heroGradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.verified_user_outlined,
                size: 16,
                color: AppColors.accentGreenLight,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: CustomText(
                  l10n.boardInfo,
                  style: AppTextStyles.overline.copyWith(
                    color: AppColors.accentGreenLight,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.sm),
          _BoardRow(
            label: l10n.boardRoll,
            value: context.fmtDigits(profile.boardRoll),
          ),
          _BoardRow(
            label: l10n.registration,
            value: context.fmtDigits(profile.registration),
          ),
          _BoardRow(
            label: l10n.session,
            value: context.fmtDigits(profile.session),
          ),
          _BoardRow(
            label: l10n.nocLetterNo,
            value: context.fmtDigits(profile.nocNumber),
            valueColor: AppColors.accentGreenLight,
            last: true,
          ),
        ],
      ),
    );
  }
}

class _BoardRow extends StatelessWidget {
  const _BoardRow({
    required this.label,
    required this.value,
    this.valueColor = Colors.white,
    this.last = false,
  });

  final String label;
  final String value;
  final Color valueColor;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        border: last
            ? null
            : Border(
                bottom: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
              ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textOnDarkMuted,
            ),
          ),
          const SizedBox(width: AppDimens.sm),
          Flexible(
            child: CustomText(
              value,
              textAlign: TextAlign.end,
              style: AppTextStyles.bodySmall.copyWith(
                color: valueColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
