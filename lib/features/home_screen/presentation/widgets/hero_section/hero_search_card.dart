import 'package:diploma_job/core/extension/l10n_extension.dart';
import 'package:diploma_job/core/responsive/responsive.dart';
import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/widgets/custom_Textfield.dart';
import 'package:diploma_job/core/widgets/custom_button.dart';
import 'package:diploma_job/features/home_screen/presentation/providers/home_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// White search card: keyword field | search button.
class HeroSearchCard extends ConsumerWidget {
  const HeroSearchCard({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final notifier = ref.read(jobFilterProvider.notifier);

    final searchField = CustomTextField(
      controller: controller,
      hintText: l10n.searchHint,
      preIcon: const Icon(Icons.search_rounded, color: AppColors.textMuted),
      fillColor: AppColors.background,
      borderRadius: 12,
      onchanged: notifier.setQuery,
      onSubmitted: (_) => FocusScope.of(context).unfocus(),
    );

    final searchButton = CustomButton(
      label: l10n.filterAction,
      icon: Icons.search_rounded,
      fullWidth: true,
      buttonHeight: 48,
      onPressed: () => FocusScope.of(context).unfocus(),
    );

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 50,
            offset: const Offset(0, 25),
          ),
        ],
      ),
      child: Responsive.isMobile(context)
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8,
        children: [searchField, searchButton],
      )
          : Row(
        spacing: 8,
        children: [
          Expanded(flex: 7, child: searchField),
          Expanded(flex: 3, child: searchButton),
        ],
      ),
    );
  }
}