import 'package:flutter/material.dart';

import '../../../../core/extension/l10n_extension.dart';
import '../../../../core/widgets/custom_overlay_notification.dart';
import '../../domain/entities/job_circular.dart';
import 'job_core.dart';
import 'job_ui.dart';

/// Shown at the top once the student has applied.
class AppliedBanner extends StatelessWidget {
  const AppliedBanner({super.key, required this.application});

  final MyApplication application;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final p = context.palette;

    final text = Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: p.success, shape: BoxShape.circle),
          child: const Icon(Icons.check_rounded, size: 18, color: Colors.white),
        ),
        const SizedBox(width: AppDimens.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                l10n.appliedBannerTitle,
                style: AppTextStyles.titleMedium.copyWith(color: p.success),
              ),
              CustomText(
                l10n.appliedBannerSubtitle(
                  context.fmtDate(application.appliedAt),
                  context.reviewStatusLabel(application.status),
                ),
                style: AppTextStyles.bodySmall.copyWith(color: p.success),
              ),
            ],
          ),
        ),
      ],
    );

    final button = CustomButton(
      label: l10n.applicationDetails,
      variant: CustomButtonVariant.accent,
      buttonHeight: 38,
      onPressed: () => CustomToast.showSuccess(
        message: application.message ?? l10n.noMessage,
      ),
    );

    return Container(
      padding: const EdgeInsets.all(AppDimens.md),
      margin: const EdgeInsets.only(bottom: AppDimens.md),
      decoration: BoxDecoration(
        color: p.successBg,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: p.success.withValues(alpha: 0.35)),
      ),
      child: Responsive.isMobile(context)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text,
                const SizedBox(height: AppDimens.sm),
                button,
              ],
            )
          : Row(
              children: [
                Expanded(child: text),
                const SizedBox(width: AppDimens.md),
                button,
              ],
            ),
    );
  }
}
