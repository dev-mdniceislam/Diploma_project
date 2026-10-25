import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/extension/l10n_extension.dart';
import '../../../../core/gen/assets_gen.dart';
import '../../../../core/widgets/custom_overlay_notification.dart';
import '../../domain/entities/job_circular.dart';
import '../providers/job_details_providers.dart';
import '../widgets/applied_banner.dart';
import '../widgets/dialogs/apply_dialog.dart';
import '../widgets/job_core.dart';
import '../widgets/job_hero_card.dart';
import '../widgets/job_ui.dart';
import '../widgets/sections/company_card.dart';
import '../widgets/sections/job_content_card.dart';
import '../widgets/sections/job_sidebar.dart';

/// Job / attachment circular details. Navbar & footer come from your shell.
class JobDetailsScreen extends ConsumerWidget {
  const JobDetailsScreen({super.key, required this.circularId});

  final String circularId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(jobDetailsProvider(circularId));

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => _ErrorView(
        message: error is AppException
            ? error.message
            : context.l10n.somethingWentWrong,
        onRetry: () => ref.invalidate(jobDetailsProvider(circularId)),
      ),
      data: (details) => _JobDetailsBody(details: details),
    );
  }
}

class _JobDetailsBody extends ConsumerWidget {
  const _JobDetailsBody({required this.details});

  final JobDetails details;

  Future<void> _toggleBookmark(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    try {
      final saved = await ref
          .read(jobActionsProvider)
          .toggleBookmark(details.circular.id, current: details.isBookmarked);
      CustomToast.showSuccess(
        message: saved ? l10n.bookmarkSaved : l10n.bookmarkRemoved,
      );
    } on AppException catch (e) {
      CustomToast.showError(message: e.message);
    }
  }

  Future<void> _share(BuildContext context) async {
    final message = context.l10n.circularLinkCopied;
    await Clipboard.setData(ClipboardData(text: Uri.base.toString()));
    CustomToast.showSuccess(message: message);
  }

  void _apply(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    if (details.isApplied) {
      CustomToast.showSuccess(message: l10n.alreadyApplied);
      return;
    }
    final applicant = ref.read(applicantProvider);
    if (applicant == null) {
      CustomToast.showError(message: l10n.somethingWentWrong);
      return;
    }
    final circular = details.circular;
    ApplyDialog.show(
      context,
      circular: circular,
      applicant: applicant,
      onSubmit: (draft) async {
        await ref.read(jobActionsProvider).apply(circular.id, draft);
        CustomToast.showSuccess(
          message: l10n.applicationSubmitted(circular.company.name),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = details.circular;
    const gap = SizedBox(height: AppDimens.md);

    final main = Column(
      children: [
        JobContentCard(circular: c),
        gap,
        CompanyCard(company: c.company),
      ],
    );
    final side = JobSidebar(
      circular: c,
      applied: details.isApplied,
      onApply: () => _apply(context, ref),
    );

    Widget stacked(BuildContext _) => Column(children: [main, gap, side]);

    return RefreshIndicator(
      onRefresh: () => ref.refresh(jobDetailsProvider(c.id).future),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ResponsiveContainer(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.horizontalPadding(context),
            vertical: AppDimens.md,
          ),
          child: Column(
            children: [
              if (details.application != null)
                AppliedBanner(application: details.application!),
              JobHeroCard(
                details: details,
                onApply: () => _apply(context, ref),
                onBookmark: () => _toggleBookmark(context, ref),
                onShare: () => _share(context),
              ),
              gap,
              ResponsiveBuilder(
                mobile: stacked,
                tablet: stacked,
                desktop: (_) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 7, child: main),
                    const SizedBox(width: AppDimens.md),
                    Expanded(flex: 3, child: side),
                  ],
                ),
              ),
              const SizedBox(height: AppDimens.lg),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.images.somethingWentWrong.image(height: 160),
            const SizedBox(height: AppDimens.md),
            CustomText(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLarge.copyWith(color: context.bodyColor),
            ),
            const SizedBox(height: AppDimens.md),
            CustomButton(
              label: context.l10n.retry,
              icon: Icons.refresh_rounded,
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
