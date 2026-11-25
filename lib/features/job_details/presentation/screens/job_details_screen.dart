import 'package:diploma_job/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_dimens.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/extension/l10n_extension.dart';
import '../../../../core/gen/assets_gen.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/responsive/responsive_builder.dart';
import '../../../../core/responsive/responsive_container.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_overlay_notification.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../domain/entities/job_circular.dart';
import '../providers/job_details_providers.dart';
import '../widgets/dialogs/apply_dialog.dart';
import '../widgets/job_hero_card.dart';
import '../widgets/job_ui.dart';
import '../widgets/sections/company_card.dart';
import '../widgets/sections/job_content_card.dart';
import '../widgets/sections/job_sidebar.dart';

/// Job / attachment circular details. Navbar & footer come from your shell.
class JobDetailsScreen extends ConsumerWidget {
  const JobDetailsScreen({
    super.key,
    required this.circularId,
    this.isMe = false,
  });

  final String circularId;
  final bool isMe;

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
      data: (details) {
        return _JobDetailsBody(details: details);
      },
    );
  }
}

class _JobDetailsBody extends ConsumerWidget {
  const _JobDetailsBody({required this.details});

  final JobAttachmentModel details;

  Future<void> _toggleBookmark(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    try {
      final saved = await ref
          .read(jobUserStateProvider.notifier)
          .toggleBookmark(details.id);

      if (!context.mounted) return;
      CustomToast.showSuccess(
        message: saved ? l10n.bookmarkSaved : l10n.bookmarkRemoved,
      );
    } on AppException catch (e) {
      if (!context.mounted) return;
      CustomToast.showError(message: e.message);
    }
  }

  Future<void> _share(BuildContext context) async {
    final message = context.l10n.circularLinkCopied;
    final link = Uri.base
        .replace(path: AppRoutes.detailsOf(details.id), query: '')
        .toString();

    await Clipboard.setData(ClipboardData(text: link));
    if (!context.mounted) return;
    CustomToast.showSuccess(message: message);
  }

  void _apply(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final userState = ref.read(jobUserStateProvider).value;

    if (userState?.isApplied(details.id) ?? false) {
      CustomToast.showSuccess(message: l10n.alreadyApplied);
      return;
    }
    if (!details.isApplicationOpen) {
      CustomToast.showError(message: l10n.applicationClosed);
      return;
    }

    final applicant = ref.read(applicantProvider);
    if (applicant == null) {
      CustomToast.showError(message: l10n.somethingWentWrong);
      return;
    }

    final circular = details;
    ApplyDialog.show(
      context,
      circular: circular,
      applicant: applicant,
      onSubmit: (draft) async {
        await ref
            .read(jobUserStateProvider.notifier)
            .submitApplication(circular.id, draft);

        if (!context.mounted) return;
        CustomToast.showSuccess(
          message: l10n.applicationSubmitted(circular.postedBy.companyName),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = details;
    const gap = SizedBox(height: AppDimens.md);

    final userState = ref.watch(jobUserStateProvider).value;
    final isApplied = userState?.isApplied(c.id) ?? false;
    final main = Column(
      children: [
        JobContentCard(circular: c),
        gap,
        CompanyCard(
          company: Company(
            name: c.postedBy.companyName,
            logoUrl: c.postedBy.profileUrl,
            tagline: c.postedBy.industryCategory,
            about: c.postedBy.about,
          ),
        ),
      ],
    );

    final side = JobSidebar(
      circular: c,
      applied: isApplied,
      onApply: () => _apply(context, ref),
    );

    Widget stacked(BuildContext _) => Column(children: [main, gap, side]);

    return Scaffold(
      body: RefreshIndicator(
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
