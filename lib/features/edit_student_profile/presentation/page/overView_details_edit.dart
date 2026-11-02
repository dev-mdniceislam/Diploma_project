import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_dimens.dart';
import '../../../../core/responsive/responsive_builder.dart';
import '../../../../core/responsive/responsive_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/custom_hover.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../data/model/student_details_model.dart';
import '../widgets/student_profile_dialogue.dart';

class StudentProfileEditScreen extends ConsumerWidget {
  const StudentProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(studentProfileEditProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: AppDimens.sectionPaddingV(
              MediaQuery.sizeOf(context).width,
            ),
          ),
          child: ResponsiveContainer(
            child: ResponsiveBuilder(
              mobile: (context) => Column(
                children: [
                  _buildLeftColumn(context, ref, profile),
                  const SizedBox(height: AppDimens.md),
                  _buildRightColumn(context, profile),
                ],
              ),
              desktop: (context) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: _buildLeftColumn(context, ref, profile),
                  ),
                  const SizedBox(width: AppDimens.md),
                  Expanded(flex: 4, child: _buildRightColumn(context, profile)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Left Side Column: Bio & Technical Proficiency
  // ---------------------------------------------------------------------------
  Widget _buildLeftColumn(
    BuildContext context,
    WidgetRef ref,
    StudentProfileState profile,
  ) {
    return Column(
      children: [
        // 1. About Me (Bio) Card
        CustomHover(
          radius: AppDimens.radiusMd,
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.description_outlined,
                          color: AppColors.primary600,
                          size: 20,
                        ),
                        const SizedBox(width: AppDimens.xs),
                        Text(
                          'About me (Bio)',
                          style: AppTextStyles.titleLarge.responsive(context),
                        ),
                      ],
                    ),
                    TextButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => const EditStudentProfileDialog(),
                        );
                      },
                      icon: const Icon(Icons.edit, size: 16),
                      label: const Text('Edit'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimens.sm),
                CustomText(
                  profile.bio,
                  style: AppTextStyles.bodyMedium.copyWith(
                    height: 1.6,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppDimens.md),

        // 2. Technical Proficiency Card
        CustomHover(
          radius: AppDimens.radiusMd,
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.code,
                      color: AppColors.primary600,
                      size: 20,
                    ),
                    const SizedBox(width: AppDimens.xs),
                    Text(
                      'Technical proficiency',
                      style: AppTextStyles.titleLarge.responsive(context),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimens.md),
                ...List.generate(profile.skills.length, (index) {
                  final skill = profile.skills[index];
                  return _buildSkillProgressItem(
                    context: context,
                    ref: ref,
                    index: index,
                    skill: skill,
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Skill Bar Builder
  Widget _buildSkillProgressItem({
    required BuildContext context,
    required WidgetRef ref,
    required int index,
    required TechnicalSkill skill,
  }) {
    final percentageInt = (skill.percentage * 100).round();
    final List<Color> skillColors = [
      AppColors.primary600,
      AppColors.accentGreen,
      AppColors.featured,
      AppColors.amber,
    ];
    final color = skillColors[index % skillColors.length];

    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                skill.title,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              CustomText(
                '$percentageInt%',
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimens.radiusSm),
            child: LinearProgressIndicator(
              value: skill.percentage,
              minHeight: 8,
              backgroundColor: AppColors.surfaceSecondary,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Right Side Column: Contact & Technical Education Board
  // ---------------------------------------------------------------------------
  Widget _buildRightColumn(BuildContext context, StudentProfileState profile) {
    return Column(
      children: [
        // 1. Contact Information Card
        CustomHover(
          radius: AppDimens.radiusMd,
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.contact_mail_outlined,
                      color: AppColors.primary600,
                      size: 20,
                    ),
                    const SizedBox(width: AppDimens.xs),
                    Text(
                      'Contact information',
                      style: AppTextStyles.titleLarge.responsive(context),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimens.md),
                _buildContactTile(
                  icon: Icons.email_outlined,
                  label: 'Email address',
                  value: profile.email,
                ),
                const SizedBox(height: AppDimens.sm),
                _buildContactTile(
                  icon: Icons.phone_outlined,
                  label: 'Phone number',
                  value: profile.phone,
                ),
                const SizedBox(height: AppDimens.sm),
                _buildContactTile(
                  icon: Icons.location_on_outlined,
                  label: 'Current address',
                  value: profile.address,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppDimens.md),

        // 2. Technical Education Board Card (Dark Navy Style)
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.navy900,
            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          ),
          padding: const EdgeInsets.all(AppDimens.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.verified_outlined,
                    color: AppColors.accentGreenLight,
                    size: 20,
                  ),
                  const SizedBox(width: AppDimens.xs),
                  Text(
                    'Technical education board',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.accentGreenLight,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimens.md),
              _buildBoardRow('Board roll:', profile.boardRoll),
              const SizedBox(height: AppDimens.xs),
              _buildBoardRow('Registration:', profile.registrationNo),
              const SizedBox(height: AppDimens.xs),
              _buildBoardRow('Session:', profile.session),
              const SizedBox(height: AppDimens.xs),
              _buildBoardRow(
                'NOC letter no:',
                profile.nocLetterNo,
                valueColor: AppColors.primary300,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.textMuted),
        const SizedBox(width: AppDimens.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
              CustomText(
                value,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBoardRow(String title, String val, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          title,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textOnDarkMuted,
          ),
        ),
        CustomText(
          val,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w700,
            color: valueColor ?? AppColors.textOnDark,
          ),
        ),
      ],
    );
  }
}
