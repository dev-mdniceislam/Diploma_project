import 'package:diploma_job/core/responsive/responsive_container.dart';
import 'package:diploma_job/core/widgets/animated_reveal.dart';
import 'package:diploma_job/features/profile/data/model/company_profile_model.dart';
import 'package:diploma_job/shared/shimmer/profile/profile_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../profile_core.dart';
import '../../providers/company_profile_provider.dart';
import '../widgets/profile_widgets.dart';
import 'widgets/company_header.dart';
import 'widgets/company_tabs.dart';

class CompanyProfileScreen extends ConsumerWidget {
  const CompanyProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: AsyncValueView<CompanyProfileModel>(
        loadingBuilder: (_) => ProfileShimmerPage(),
        value: ref.watch(companyProfileProvider),
        onRetry: () => ref.invalidate(companyProfileProvider),
        data: (p) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: AppDimens.md),
          child: ResponsiveContainer(
            padding: EdgeInsets.symmetric(horizontal: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: AppDimens.md,
              children: [CompanyHeader(p), CompanyTabs(p)],
            ),
          ),
        ),
      ),
    );
  }
}
