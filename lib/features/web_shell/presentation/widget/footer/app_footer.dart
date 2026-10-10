import 'package:diploma_job/core/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/widgets/app_container.dart';
import 'package:diploma_job/core/widgets/app_logo.dart';
import 'package:diploma_job/core/widgets/custom_text.dart';
import 'package:diploma_job/core/widgets/responsive_grid.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../home_screen/domain/entities/job.dart';
import '../../../../home_screen/domain/entities/job_filter.dart';
import '../../../../home_screen/presentation/providers/home_providers.dart';
import '../../../../home_screen/presentation/widgets/job_localizations.dart';

class AppFooter extends ConsumerWidget {
  const AppFooter({super.key});

  static final _btebUri = Uri.parse('https://bteb.gov.bd');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final filter = ref.read(jobFilterProvider.notifier);

    final bottomTexts = [
      CustomText(l10n.footerCopyright, style: _muted(context)),
      CustomText(l10n.footerTagline, style: _muted(context)),
    ];

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.navy900,
        border: Border(top: BorderSide(color: AppColors.navy800)),
      ),
      child: AppContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: Column(
            children: [
              ResponsiveGrid(
                mobileColumns: 1,
                tabletColumns: 2,
                desktopColumns: 4,
                spacing: 32,
                children: [
                  _FooterColumn(
                    titleWidget: const AppLogo(compact: true),
                    children: [
                      CustomText(l10n.footerAbout, style: _muted(context)),
                    ],
                  ),
                  _FooterColumn(
                    title: l10n.footerPopularTech,
                    children: [
                      for (final tech in JobTech.values.take(4))
                        _FooterLink(
                          label: tech.label(l10n),
                          onTap: () {
                            filter.setTech(tech);
                            context.go(AppRoutes.home);
                          },
                        ),
                    ],
                  ),
                  _FooterColumn(
                    title: l10n.footerImportantLinks,
                    children: [
                      _FooterLink(
                        label: l10n.navAttachment,
                        onTap: () {
                          filter.setType(JobTypeFilter.internship);
                          context.go(AppRoutes.home);
                        },
                      ),
                      _FooterLink(
                        label: l10n.footerNocGuide,
                        onTap: () => context.go(AppRoutes.guide),
                      ),
                      _FooterLink(
                        label: l10n.footerPostCircular,
                        onTap: () => context.go(AppRoutes.postCircular),
                      ),
                      _FooterLink(
                        label: l10n.footerBteb,
                        onTap: () => launchUrl(
                          _btebUri,
                          mode: LaunchMode.externalApplication,
                        ),
                      ),
                    ],
                  ),
                  _FooterColumn(
                    title: l10n.footerContact,
                    children: [
                      CustomText(
                        l10n.footerContactHint,
                        style: _muted(context),
                      ),
                      const SizedBox(height: 8),
                      CustomText(
                        'support@diplomajobhub.bd',
                        style: _muted(context).copyWith(
                          color: AppColors.primary400,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Swap for font_awesome_flutter icons if you want the
                      // exact brand glyphs (LinkedIn has no Material icon).
                      const Row(
                        children: [
                          _SocialIcon(Icons.facebook),
                          SizedBox(width: 12),
                          _SocialIcon(Icons.public_rounded),
                          SizedBox(width: 12),
                          _SocialIcon(Icons.mail_outline_rounded),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Divider(color: AppColors.navy800, height: 1),
              const SizedBox(height: 20),
              Responsive.isMobile(context)
                  ? Column(
                      children: [
                        bottomTexts[0],
                        const SizedBox(height: 8),
                        bottomTexts[1],
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: bottomTexts,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  static TextStyle _muted(BuildContext context) =>
      AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted);
}

class _FooterColumn extends StatelessWidget {
  const _FooterColumn({this.title, this.titleWidget, required this.children})
    : assert(title != null || titleWidget != null);

  final String? title;
  final Widget? titleWidget;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget ??
            CustomText(
              title!,
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.white,
                fontSize: 14,
              ),
            ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }
}

class _FooterLink extends StatefulWidget {
  const _FooterLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: AppTextStyles.bodySmall.copyWith(
              color: _hover ? AppColors.white : AppColors.textMuted,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  const _SocialIcon(this.icon);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.navy800,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 16, color: AppColors.textOnDarkMuted),
    );
  }
}
