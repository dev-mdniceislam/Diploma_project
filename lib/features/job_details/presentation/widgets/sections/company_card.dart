import 'package:flutter/material.dart';

import '../../../domain/entities/job_circular.dart';
import '../job_core.dart';
import '../job_ui.dart';

class CompanyCard extends StatelessWidget {
  const CompanyCard({super.key, required this.company});

  final Company company;

  @override
  Widget build(BuildContext context) {
    return JobCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomImage(
                imagePath: company.logoUrl,
                width: 56,
                height: 56,
                borderRadius: BorderRadius.circular(AppDimens.radiusMd - 2),
              ),
              const SizedBox(width: AppDimens.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      company.name,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: context.scheme.onSurface,
                      ),
                    ),
                    CustomText(
                      company.tagline,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: context.bodyColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.sm),
          CustomText(
            company.about,
            style: AppTextStyles.bodyMedium.copyWith(color: context.bodyColor),
          ),
        ],
      ),
    );
  }
}
