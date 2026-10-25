import 'package:diploma_job/core/responsive/responsive.dart';
import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/theme/theme_pellete.dart';
import 'package:diploma_job/core/widgets/app_container.dart';
import 'package:diploma_job/core/widgets/app_logo.dart';
import 'package:diploma_job/core/widgets/custom_button.dart';
import 'package:diploma_job/core/widgets/custom_hover.dart';
import 'package:diploma_job/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../home_screen/domain/entities/job_filter.dart';
import '../../../../home_screen/presentation/providers/home_providers.dart';
import '../../../../home_screen/presentation/widgets/persona_switcher.dart';
import '../../../../home_screen/presentation/widgets/saved_button.dart';

class MainNavbar extends StatelessWidget {
  const MainNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      height: 80,
      width: double.infinity,
      color: Theme.of(context).colorScheme.surface,
      child: AppContainer(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: GestureDetector(
                  onTap: () => context.go(AppRoutes.home),
                  child: const MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: AppLogo(),
                  ),
                ),
              ),
              if (isDesktop) ...[
                const Flexible(
                  child: FittedBox(fit: BoxFit.scaleDown, child: _DesktopNav()),
                ),
                const _DesktopActions(),
              ] else
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // SavedButton(onTap: () => context.go(AppRoutes.saved)),
                    _profileImageButton(context),
                    const SizedBox(width: 8),
                    const _MenuButton(),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DesktopActions extends StatelessWidget {
  const _DesktopActions();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const PersonaSwitcher(),
        const SizedBox(width: 12),
        CustomButton(
          label: context.l10n.postCircular,
          icon: Icons.add_circle_outline_rounded,
          variant: CustomButtonVariant.accent,
          buttonHeight: 42,
          onPressed: () => context.go(AppRoutes.postCircular),
        ),
        const SizedBox(width: 12),
        //SavedButton(onTap: () => context.go(AppRoutes.saved)),
        _profileImageButton(context),
      ],
    );
  }
}

InkWell _profileImageButton(BuildContext context) {
  return InkWell(
    onTap: () {
      context.go(AppRoutes.studentProfile);
    },
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: BoxBorder.all(color: AppColors.primary, width: 2),
          ),
          child: CustomImage(
            imagePath: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOJ4IZbkwwyJD4dq7MObC7x1gpYN0xVkTOV_X9T9ZCMQ&s=10",
            borderRadius: BorderRadius.circular(3),
            height: 35,
            width: 35,
          ),
        ),
        Positioned(
          bottom: -2,
          left: -2,
          child: CircleAvatar(
            radius: 7,
            backgroundColor: AppColors.accentGreen,
          ),
        ),
      ],
    ),
  );
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
              color: scheme.onSurface.withOpacity(0.8),
            ),
          ),
        ),
      ),
    );
  }
}

class _DesktopNav extends ConsumerWidget {
  const _DesktopNav();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final type = ref.watch(jobFilterProvider.select((f) => f.type));
    final path = GoRouterState.of(context).uri.path;
    final onHome = path == AppRoutes.home;
    final notifier = ref.read(jobFilterProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: context.isDark
            ? AppColors.darkSurfaceSecondary
            : AppColors.surfaceSecondary.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _NavItem(
            icon: Icons.grid_view_rounded,
            label: l10n.navHome,
            selected: onHome && type == JobTypeFilter.all,
            onTap: () {
              notifier.setType(JobTypeFilter.all);
              context.go(AppRoutes.home);
            },
          ),
          _NavItem(
            icon: Icons.school_outlined,
            label: l10n.navAttachment,
            selected: onHome && type == JobTypeFilter.internship,
            onTap: () {
              notifier.setType(JobTypeFilter.internship);
              context.go(AppRoutes.home);
            },
          ),
          _NavItem(
            icon: Icons.menu_book_outlined,
            label: l10n.navGuide,
            selected: path == AppRoutes.guide,
            iconColor: context.palette.brand,
            onTap: () => context.go(AppRoutes.guide),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.iconColor,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fg = selected
        ? context.palette.brand
        : scheme.onSurface.withOpacity(0.75);

    return CustomHover(
      cursor: SystemMouseCursors.click,
      // selected হলে সাদা pill, না হলে transparent
      color: selected ? scheme.surface : Colors.transparent,
      lift: 2,
      radius: 8,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: iconColor ?? fg),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTextStyles.navLink.copyWith(
                  fontSize: 13.5,
                  color: fg,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
