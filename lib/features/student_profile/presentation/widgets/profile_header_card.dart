import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extension/l10n_extension.dart';
import '../../../../core/gen/assets_gen.dart';
import '../../../../core/widgets/custom_overlay_notification.dart';
import '../../domain/entities/student_profile.dart';
import '../../../../core/utils/open_link.dart';
import 'dialogs/cv_link_dialog.dart';
import 'dialogs/edit_profile_dialog.dart';
import 'dialogs/noc_guide_dialog.dart';
import 'profile_core.dart';
import 'profile_ui.dart';

/// Cover + avatar + identity + actions + quick metrics.
class ProfileHeaderCard extends ConsumerWidget {
  const ProfileHeaderCard({super.key, required this.profile});

  final StudentProfile profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wide = Responsive.isDesktop(context);
    final avatarSize = Responsive.value<double>(
      context,
      mobile: 112,
      tablet: 128,
      desktop: 144,
    );
    final coverHeight = Responsive.value<double>(
      context,
      mobile: 168,
      tablet: 208,
      desktop: 248,
    );
    final pad = wide ? AppDimens.lg : AppDimens.md;

    final avatar = _AvatarSlot(
      size: avatarSize,
      url: profile.avatarUrl,
      onEdit: () => EditProfileDialog.show(context),
    );
    final info = _Identity(profile: profile, centered: !wide);
    final actions = _Actions(profile: profile, alignEnd: wide);

    return Container(
      decoration: BoxDecoration(
        color: context.scheme.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: context.scheme.outline),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppDimens.radiusLg - 1),
            ),
            child: _Cover(height: coverHeight),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(pad, 0, pad, pad),
            child: Column(
              children: [
                if (wide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      avatar,
                      const SizedBox(width: AppDimens.md),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: AppDimens.sm),
                          child: info,
                        ),
                      ),
                      const SizedBox(width: AppDimens.md),
                      Padding(
                        padding: const EdgeInsets.only(top: AppDimens.sm),
                        child: actions,
                      ),
                    ],
                  )
                else ...[
                  avatar,
                  const SizedBox(height: AppDimens.sm),
                  info,
                  const SizedBox(height: AppDimens.md),
                  actions,
                ],
                const SizedBox(height: AppDimens.md),
                Divider(height: 1, color: context.scheme.outline),
                const SizedBox(height: AppDimens.md),
                _MetricStrip(profile: profile),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Cover extends StatelessWidget {
  const _Cover({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: const BoxDecoration(gradient: AppColors.heroGradient),
      child: Stack(
        children: [
          Positioned(
            right: -40,
            bottom: -40,
            child: _Glow(color: AppColors.accentGreen.withValues(alpha: 0.22)),
          ),
          Positioned(
            left: -40,
            top: -40,
            child: _Glow(color: AppColors.primary500.withValues(alpha: 0.22)),
          ),
          Positioned(
            top: AppDimens.sm,
            right: AppDimens.sm,
            child: Material(
              color: Colors.black.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
              child: InkWell(
                borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                onTap: () =>
                    CustomToast.showSuccess(message: context.l10n.comingSoon),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.sm,
                    vertical: AppDimens.xs + 2,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.photo_camera_outlined,
                        size: 15,
                        color: Colors.white,
                      ),
                      if (!Responsive.isMobile(context)) ...[
                        const SizedBox(width: 6),
                        CustomText(
                          context.l10n.changeCover,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    width: 220,
    height: 220,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}

/// Takes half the avatar's height in layout and lets the top half
/// overlap the cover (so the lower half — incl. the edit button — stays
/// tappable).
class _AvatarSlot extends StatelessWidget {
  const _AvatarSlot({
    required this.size,
    required this.url,
    required this.onEdit,
  });

  final double size;
  final String url;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size / 2,
      child: OverflowBox(
        alignment: Alignment.bottomCenter,
        minHeight: size,
        maxHeight: size,
        minWidth: size,
        maxWidth: size,
        child: Stack(
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: context.scheme.surface,
                borderRadius: BorderRadius.circular(AppDimens.radiusLg),
                border: Border.all(color: context.scheme.surface, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: CustomImage(
                imagePath: url.isEmpty ? Assets.icons.maleAvatar : url,
                width: size,
                height: size,
                borderRadius: BorderRadius.circular(AppDimens.radiusLg - 4),
              ),
            ),
            Positioned(
              right: 6,
              bottom: 6,
              child: Material(
                color: context.scheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd - 2),
                  side: BorderSide(color: context.scheme.surface, width: 2),
                ),
                child: InkWell(
                  onTap: onEdit,
                  child: Padding(
                    padding: const EdgeInsets.all(7),
                    child: Icon(
                      Icons.edit_rounded,
                      size: 15,
                      color: context.scheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Identity extends StatelessWidget {
  const _Identity({required this.profile, required this.centered});

  final StudentProfile profile;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final align = centered
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    final textAlign = centered ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment: align,
      children: [
        Wrap(
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: AppDimens.sm,
          runSpacing: AppDimens.xs,
          children: [
            CustomText(
              profile.name,
              textAlign: textAlign,
              style: AppTextStyles.headlineLarge
                  .responsive(context)
                  .copyWith(
                    color: context.scheme.onSurface,
                    fontWeight: FontWeight.w800,
                  ),
            ),
            if (profile.isVerified)
              StatusBadge(
                label: l10n.verifiedStudent,
                icon: Icons.verified_rounded,
                foreground: context.palette.brand,
                background: context.palette.pillBg,
              ),
          ],
        ),
        const SizedBox(height: AppDimens.xs),
        _IconLine(
          icon: Icons.laptop_mac_rounded,
          text: profile.department,
          color: context.palette.brand,
          centered: centered,
          style: AppTextStyles.bodyMedium.copyWith(
            color: context.palette.brand,
            fontWeight: FontWeight.w600,
          ),
        ),
        _IconLine(
          icon: Icons.apartment_rounded,
          text: l10n.instituteRoll(
            profile.institute,
            context.fmtDigits(profile.boardRoll),
          ),
          color: AppColors.textMuted,
          centered: centered,
          style: AppTextStyles.bodySmall.copyWith(color: context.bodyColor),
        ),
      ],
    );
  }
}

class _IconLine extends StatelessWidget {
  const _IconLine({
    required this.icon,
    required this.text,
    required this.color,
    required this.centered,
    required this.style,
  });

  final IconData icon;
  final String text;
  final Color color;
  final bool centered;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
        mainAxisAlignment: centered
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          Icon(icon, size: 15, color: color),
          const SizedBox(width: 6),
          Flexible(
            child: CustomText(
              text,
              style: style,
              textAlign: centered ? TextAlign.center : TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({required this.profile, required this.alignEnd});

  final StudentProfile profile;
  final bool alignEnd;

  Future<void> _copyLink(BuildContext context) async {
    final message = context.l10n.linkCopied;
    await Clipboard.setData(ClipboardData(text: Uri.base.toString()));
    CustomToast.showSuccess(message: message);
  }

  void _downloadCv(BuildContext context) {
    final url = profile.cvUrl;
    if (url == null || url.isEmpty) {
      CustomToast.showError(message: context.l10n.cvNotUploaded);
      return;
    }
    openLink(context, url, context.l10n.linkOpenFailed);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Wrap(
      alignment: alignEnd ? WrapAlignment.end : WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: AppDimens.sm,
      runSpacing: AppDimens.sm,
      children: [
        CustomButton(
          label: l10n.downloadResume,
          icon: Icons.download_rounded,
          onPressed: () => _downloadCv(context),
        ),
        CustomButton(
          label: l10n.editProfile,
          icon: Icons.manage_accounts_outlined,
          variant: CustomButtonVariant.outline,
          onPressed: () => EditProfileDialog.show(context),
        ),
        IconButton.outlined(
          tooltip: l10n.updateCv,
          onPressed: () => CvLinkDialog.show(context),
          icon: const Icon(Icons.upload_file_outlined, size: 18),
        ),
        IconButton.outlined(
          tooltip: l10n.nocGuide,
          onPressed: () => NocGuideDialog.show(context, profile),
          icon: const Icon(Icons.menu_book_outlined, size: 18),
        ),
        IconButton.outlined(
          tooltip: l10n.copyPublicLink,
          onPressed: () => _copyLink(context),
          icon: const Icon(Icons.share_outlined, size: 18),
        ),
      ],
    );
  }
}

class _MetricStrip extends StatelessWidget {
  const _MetricStrip({required this.profile});

  final StudentProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final p = context.palette;

    final (nocLabel, nocFg, nocBg, nocIcon) = switch (profile.nocStatus) {
      NocStatus.issued => (
        l10n.nocIssued,
        p.success,
        p.successBg,
        Icons.check_circle_outline_rounded,
      ),
      NocStatus.pending => (
        l10n.nocPending,
        AppColors.amber,
        AppColors.amber.withValues(alpha: 0.15),
        Icons.schedule_rounded,
      ),
      NocStatus.rejected => (
        l10n.nocRejected,
        p.danger,
        p.dangerBg,
        Icons.cancel_outlined,
      ),
    };

    final cgpa =
        '${context.fmtNumber(profile.cgpa, decimals: 2)} / ${context.fmtNumber(profile.cgpaScale, decimals: 2)}';

    return ResponsiveGrid(
      mobileColumns: 2,
      tabletColumns: 4,
      desktopColumns: 4,
      spacing: AppDimens.sm,
      children: [
        _Metric(
          label: l10n.metricCurrentStatus,
          child: _MetricText(
            l10n.metricStatusValue(context.semesterName(profile.semester)),
            color: p.success,
          ),
        ),
        _Metric(
          label: l10n.metricCgpa,
          child: _MetricText(cgpa, color: p.brand),
        ),
        _Metric(
          label: l10n.metricApplied,
          child: _MetricText(
            l10n.circularsCount(profile.applications.length),
            color: context.scheme.onSurface,
          ),
        ),
        _Metric(
          label: l10n.metricNoc,
          child: StatusBadge(
            label: nocLabel,
            icon: nocIcon,
            foreground: nocFg,
            background: nocBg,
          ),
        ),
      ],
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.sm),
      decoration: BoxDecoration(
        color: context.mutedSurface,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: context.scheme.outline),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w700,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: AppDimens.xs),
          child,
        ],
      ),
    );
  }
}

class _MetricText extends StatelessWidget {
  const _MetricText(this.text, {required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) => CustomText(
    text,
    textAlign: TextAlign.center,
    style: AppTextStyles.bodyMedium.copyWith(
      color: color,
      fontWeight: FontWeight.w700,
    ),
  );
}
