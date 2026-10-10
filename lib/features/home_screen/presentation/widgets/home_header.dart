import 'package:diploma_job/core/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extension/l10n_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/theme_pellete.dart';
import '../../../../core/widgets/app_container.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../domain/entities/job_filter.dart';
import '../providers/home_providers.dart';
import 'home_callbacks.dart';
import 'persona_switcher.dart';
import 'saved_button.dart';

/// Sticky top bar. Desktop: logo + nav pills + persona + CTA + saved.
/// Tablet/mobile: logo + saved + menu (opens the end drawer).
class HomeSliverHeader extends StatelessWidget {
  const HomeSliverHeader({super.key, required this.callbacks});

  final HomeCallbacks callbacks;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDesktop = Responsive.isDesktop(context);

    return SliverAppBar(
      pinned: true,
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: scheme.surface.withOpacity(0.96),
      shape: Border(bottom: BorderSide(color: scheme.outline)),
      flexibleSpace: SafeArea(
        bottom: false,
        child: AppContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(child: AppLogo()),
              if (isDesktop) ...[
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: _DesktopNav(callbacks: callbacks),
                  ),
                ),
                _DesktopActions(callbacks: callbacks),
              ] else
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SavedButton(onTap: callbacks.onOpenSaved),
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
  const _DesktopActions({required this.callbacks});

  final HomeCallbacks callbacks;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const PersonaSwitcher(),
        const SizedBox(width: 12),
        CustomButton(
          label: context.l10n!.postCircular,
          icon: Icons.add_circle_outline_rounded,
          variant: CustomButtonVariant.accent,
          buttonHeight: 42,
          onPressed: callbacks.onPostCircular,
        ),
        const SizedBox(width: 12),
        SavedButton(onTap: callbacks.onOpenSaved),
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
      message: context.l10n!.menu,
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
    );
  }
}

class _DesktopNav extends ConsumerWidget {
  const _DesktopNav({required this.callbacks});

  final HomeCallbacks callbacks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final type = ref.watch(jobFilterProvider.select((f) => f.type));
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
            selected: type == JobTypeFilter.all,
            onTap: () => notifier.setType(JobTypeFilter.all),
          ),
          _NavItem(
            icon: Icons.school_outlined,
            label: l10n.navAttachment,
            selected: type == JobTypeFilter.internship,
            onTap: () => notifier.setType(JobTypeFilter.internship),
          ),
          _NavItem(
            icon: Icons.menu_book_outlined,
            label: l10n.navGuide,
            selected: false,
            iconColor: context.palette.brand,
            onTap: callbacks.onOpenGuide,
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
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
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final brand = context.palette.brand;
    final fg = widget.selected
        ? brand
        : scheme.onSurface.withOpacity(_hover ? 1 : 0.7);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          decoration: BoxDecoration(
            color: widget.selected ? scheme.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: widget.selected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 16, color: widget.iconColor ?? fg),
              const SizedBox(width: 6),
              Text(
                widget.label,
                style: AppTextStyles.navLink.copyWith(
                  fontSize: 13.5,
                  color: fg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
