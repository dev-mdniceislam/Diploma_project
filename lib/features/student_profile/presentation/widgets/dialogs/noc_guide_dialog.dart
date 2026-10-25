import 'package:flutter/material.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../domain/entities/student_profile.dart';
import '../profile_core.dart';
import '../profile_ui.dart';

class NocGuideDialog extends StatelessWidget {
  const NocGuideDialog({super.key, required this.profile});

  final StudentProfile profile;

  static Future<void> show(BuildContext context, StudentProfile profile) =>
      showDialog<void>(
        context: context,
        builder: (_) => NocGuideDialog(profile: profile),
      );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final p = context.palette;

    return AppDialog(
      title: l10n.nocGuideTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            l10n.nocGuideBody,
            style: AppTextStyles.bodyMedium.copyWith(color: context.bodyColor),
          ),
          const SizedBox(height: AppDimens.sm),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppDimens.sm + 2),
            decoration: BoxDecoration(
              color: p.successBg,
              borderRadius: BorderRadius.circular(AppDimens.radiusMd - 2),
            ),
            child: CustomText(
              l10n.nocVerifiedActive(context.fmtDigits(profile.nocNumber)),
              style: AppTextStyles.bodySmall.copyWith(
                color: p.success,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
