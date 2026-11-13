import 'package:flutter/material.dart';

import '../../../../../core/utils/localized_format.dart';
import '../../../data/model/student_profile_model.dart';
import '../../../data/profile_models.dart';
import '../../../profile_core.dart';
import '../../widgets/profile_widgets.dart';

class SkillBar extends StatelessWidget {
  const SkillBar(this.skill, this.color, {super.key});

  final SkillModel skill;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    return Column(
      spacing: 6,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomText(
                skill.name,
                style: tt.bodySmall!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: context.cs.onSurface,
                ),
              ),
            ),
            CustomText(
              context.fmtPercent(skill.percent),
              style: tt.bodySmall!.copyWith(
                fontWeight: FontWeight.w700,
                color: context.palette.brand,
              ),
            ),
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: skill.percent / 100),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOutCubic,
            builder: (_, v, _) => LinearProgressIndicator(
              value: v,
              minHeight: 8,
              color: color,
              backgroundColor: context.cs.onSurface.withValues(alpha: .08),
            ),
          ),
        ),
      ],
    );
  }
}
