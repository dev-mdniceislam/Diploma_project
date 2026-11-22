import 'package:diploma_job/core/extension/l10n_extension.dart';
import 'package:diploma_job/core/gen/assets_gen.dart';
import 'package:diploma_job/core/responsive/responsive.dart';
import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/theme/theme_pellete.dart';
import 'package:diploma_job/core/widgets/app_logo.dart';
import 'package:diploma_job/core/widgets/custom_hover.dart';
import 'package:diploma_job/core/widgets/custom_image.dart';
import 'package:diploma_job/core/widgets/custom_text.dart';
import 'package:diploma_job/features/splash/data/model/profile_get_me_model.dart';
import 'package:diploma_job/features/splash/presentation/provider/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/router/app_router.dart';
import '../../../../home_screen/domain/entities/job_filter.dart';
import '../../../../home_screen/presentation/providers/home_providers.dart';

abstract class NavPaths {
  static const notice = '/notice';
  static const companies = '/companies';
  static const about = '/about';
  static const login = '/login';
}

class MainNavbar extends ConsumerWidget {
  const MainNavbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = Responsive.isDesktop(context);
    final hPad = Responsive.horizontalPadding(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(hPad, 12, hPad, 12),
      child: isDesktop ? const _DesktopBar() : const _MobileBar(),
    );
  }
}

/// Login অবস্থা অনুযায়ী right side-এর action গুলো।
///  - logged out: Login button
///  - student / unverified company: শুধু avatar
///  - verified company: Post circular button + avatar
List<Widget> _authActions(
  BuildContext context,
  AuthMiddlewareModel? profile, {
  required bool compact,
}) {
  final l10n = context.l10n;

  if (profile == null) {
    return [
      _GradientButton(
        label: l10n.loginAction,
        icon: Icons.login_rounded,
        compact: compact,
        onTap: () => context.go(NavPaths.login),
      ),
    ];
  }

  final canPost = profile.isCompany && profile.isVerified;

  return [
    if (canPost) ...[
      _GradientButton(
        label: l10n.postCircular,
        icon: Icons.add_circle_outline_rounded,
        compact: compact,
        onTap: () => context.go(AppRoutes.postCircular),
      ),
      SizedBox(width: compact ? 8 : 12),
    ],
    _ProfileAvatar(imagePath: profile.profile),
  ];
}

// ── Desktop ──────────────────────────────────────────────────────────────

class _DesktopBar extends ConsumerWidget {
  const _DesktopBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider).value;

    return Row(
      children: [
        const AppLogo(),
        const SizedBox(width: 14),
        const _VDivider(),
        const SizedBox(width: 10),
        const Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: _DesktopNav(),
          ),
        ),
        const _VDivider(),
        const SizedBox(width: 12),
        ..._authActions(context, profile, compact: false),
      ],
    );
  }
}

class _DesktopNav extends ConsumerWidget {
  const _DesktopNav();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final path = GoRouterState.of(context).uri.path;
    final type = ref.watch(jobFilterProvider.select((f) => f.type));
    final notifier = ref.read(jobFilterProvider.notifier);
    final onHome = path == AppRoutes.home;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _NavLink(
          icon: Icons.home_rounded,
          label: l10n.navHome,
          selected: onHome && type == JobTypeFilter.all,
          onTap: () {
            notifier.setType(JobTypeFilter.all);
            context.go(AppRoutes.home);
          },
        ),
        _NavLink(
          icon: Icons.article_outlined,
          label: l10n.navNotice,
          selected: path == NavPaths.notice,
          onTap: () => context.go(NavPaths.notice),
        ),
        _NavLink(
          icon: Icons.menu_book_outlined,
          label: l10n.navGuide,
          selected: path == AppRoutes.guide,
          onTap: () => context.go(AppRoutes.guide),
        ),
        _NavLink(
          icon: Icons.apartment_outlined,
          label: l10n.navCompanies,
          selected: path == NavPaths.companies,
          onTap: () => context.go(NavPaths.companies),
        ),
        _NavLink(
          icon: Icons.info_outline_rounded,
          label: l10n.navAbout,
          selected: path == NavPaths.about,
          onTap: () => context.go(NavPaths.about),
        ),
      ],
    );
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink({
    required this.icon,
    required this.label,
    required this.selected,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final scheme = Theme.of(context).colorScheme;

    final fg = widget.selected
        ? palette.brand
        : scheme.onSurface.withValues(alpha: 0.75);

    final showUnderline = widget.selected || _hovering;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(widget.icon, size: 17, color: fg),
                  const SizedBox(width: 6),
                  CustomText(
                    widget.label,
                    style: AppTextStyles.navLink.copyWith(
                      fontSize: 14,
                      color: fg,
                      fontWeight: widget.selected
                          ? FontWeight.w700
                          : FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: -8,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  width: showUnderline ? 22 : 0,
                  height: 3,
                  decoration: BoxDecoration(
                    color: palette.brand,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Mobile ───────────────────────────────────────────────────────────────

class _MobileBar extends ConsumerWidget {
  const _MobileBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider).value;

    return Row(
      children: [
        const Flexible(child: _Brand()),
        const Spacer(),
        ..._authActions(context, profile, compact: true),
        const SizedBox(width: 8),
        const _MenuButton(),
      ],
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: context.l10n.menu,
      child: CustomHover(
        cursor: SystemMouseCursors.click,
        color: scheme.surface,
        lift: 2,
        radius: 12,
        child: GestureDetector(
          onTap: () => Scaffold.of(context).openEndDrawer(),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: scheme.outline),
            ),
            child: Icon(
              Icons.menu_rounded,
              size: 22,
              color: scheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Shared pieces ────────────────────────────────────────────────────────

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => context.go(AppRoutes.home),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary700, AppColors.primary900],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.school_rounded,
                color: AppColors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    l10n.navBrandTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.titleLarge.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                      color: scheme.onSurface,
                    ),
                  ),
                  CustomText(
                    l10n.navBrandSubtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VDivider extends StatelessWidget {
  const _VDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.primary600.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  const _GradientButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.compact = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 14 : 20,
          vertical: compact ? 8 : 11,
        ),
        decoration: BoxDecoration(
          gradient: AppColors.loginGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.featured.withValues(alpha: 0.35),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: AppColors.white),
            const SizedBox(width: 6),
            CustomText(
              label,
              style: AppTextStyles.labelLarge.copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({this.imagePath});

  /// Cloudinary/network URL। না থাকলে default avatar।
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    final hasImage = imagePath != null && imagePath!.isNotEmpty;

    return Tooltip(
      message: context.l10n.navMyProfile,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () => context.go(AppRoutes.profile),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary600, width: 2),
              ),
              child: CustomImage(
                imagePath: hasImage ? imagePath! : Assets.icons.maleAvatar,
                width: 38,
                height: 38,
                borderRadius: BorderRadius.circular(100),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              right: -2,
              bottom: -2,
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: AppColors.accentGreen,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
