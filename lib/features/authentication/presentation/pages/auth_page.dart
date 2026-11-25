import 'package:diploma_job/core/constants/app_dimens.dart';
import 'package:diploma_job/core/extension/l10n_extension.dart';
import 'package:diploma_job/core/responsive/responsive.dart';
import 'package:diploma_job/core/responsive/responsive_container.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/theme/orbit_palette.dart';
import 'package:flutter/material.dart';

import '../widgets/auth_card.dart';
import '../widgets/auth_widgets.dart';
import '../widgets/brand_header.dart';
import '../widgets/gradient_text.dart';
import '../widgets/orbit_background.dart';
import '../widgets/orbit_showcase.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = Responsive.isDesktop(context);

    return Scaffold(
      backgroundColor: OrbitPalette.of(context).canvas,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: isWide
                  ? const _WideLayout()
                  : const Column(
                      children: [
                        ShowcaseBackground(child: _ShowcaseContent()),
                        _FormContent(),
                      ],
                    ),
            ),
          ),
          const Positioned.fill(child: DaylightMotes()),
        ],
      ),
    );
  }
}

class _WideLayout extends StatelessWidget {
  const _WideLayout();

  // Row er flex 70 : 48 — background ta left er 70 / 118 ongsho niyeche
  static const _leftFraction = 70 / 118;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background: poro scroll content er height jure thakbe
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: _leftFraction,
              heightFactor: 1,
              child: const ShowcaseBackground(child: SizedBox.expand()),
            ),
          ),
        ),
        // Content: ei Row er height sob theke boro child er height anushare thake
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 70, child: _ShowcaseContent()),
            Expanded(flex: 48, child: _FormContent()),
          ],
        ),
      ],
    );
  }
}

// class _Scrollable extends StatelessWidget {
//   const _Scrollable({required this.child});
//
//   final Widget child;
//
//   @override
//   Widget build(BuildContext context) => LayoutBuilder(
//     builder: (context, constraints) => SingleChildScrollView(
//       child: ConstrainedBox(
//         constraints: BoxConstraints(minHeight: constraints.maxHeight),
//         child: child,
//       ),
//     ),
//   );
// }

// ─── LEFT: showcase ─────────────────────────────────────────────

class _ShowcaseContent extends StatelessWidget {
  const _ShowcaseContent();

  @override
  Widget build(BuildContext context) {
    final isLarge = MediaQuery.sizeOf(context).width >= AppDimens.mobileMax;
    final isWide = Responsive.isDesktop(context);
    final l10n = context.l10n;
    final p = OrbitPalette.of(context);

    return Padding(
      padding: EdgeInsets.all(isWide ? 48 : (isLarge ? 40 : 24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const BrandHeader(),
          const SizedBox(height: 32),
          const OrbitShowcase(),
          const SizedBox(height: 24),
          _Headline(isLarge: isLarge),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              l10n.leftSubcopy,
              style: AppTextStyles.bodyLarge.copyWith(
                fontSize: isLarge ? 16 : 14,
                color: p.inkSoft,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const _StatsRow(),
        ],
      ),
    );
  }
}

class _Headline extends StatelessWidget {
  const _Headline({required this.isLarge});

  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final p = OrbitPalette.of(context);
    final style = AppTextStyles.displayMedium.copyWith(
      fontSize: isLarge ? 34 : 26,
      fontWeight: FontWeight.w800,
      color: p.ink,
      height: 1.15,
      letterSpacing: -0.5,
    );

    return Text.rich(
      TextSpan(
        style: style,
        children: [
          TextSpan(text: '${l10n.leftHeadlinePrefix} '),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: GradientText(
              l10n.leftHeadlineHighlight,
              style: style,
              gradient: p.brandGradient,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final p = OrbitPalette.of(context);

    return Container(
      constraints: const BoxConstraints(maxWidth: 512),
      padding: const EdgeInsets.only(top: 24),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: p.line)),
      ),
      child: Row(
        children: [
          _Stat(value: '1,480+', label: l10n.statActiveRoles, color: p.ink),
          _Stat(
            value: '340+',
            label: l10n.statPartnerCompanies,
            color: p.indigo,
          ),
          _Stat(value: '85+', label: l10n.statAttachmentTracks, color: p.cyan),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label, required this.color});

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w500,
            color: OrbitPalette.of(context).muted,
          ),
        ),
      ],
    ),
  );
}

// ─── RIGHT: form ────────────────────────────────────────────────

class _FormContent extends StatelessWidget {
  const _FormContent();

  @override
  Widget build(BuildContext context) {
    final isLarge = MediaQuery.sizeOf(context).width >= AppDimens.mobileMax;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isLarge ? 40 : 24),
      child: const ResponsiveContainer(
        maxWidth: 530,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _TopBar(),
            SizedBox(height: 16),
            AuthCard(),
            SizedBox(height: 24),
            _Footer(),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final p = OrbitPalette.of(context);
    return Row(
      children: [
        Icon(Icons.wb_sunny_rounded, size: 14, color: p.amber),
        const SizedBox(width: 6),
        Text(
          l10n.daylightEdition,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            color: p.muted,
          ),
        ),
        const Spacer(),
        const LanguageSwitcher(),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final p = OrbitPalette.of(context);
    final muted = AppTextStyles.bodySmall.copyWith(color: p.muted);

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(l10n.footerProtected, style: muted),
        const SizedBox(width: 4),
        LegalLink(label: l10n.termsLabel, onTap: () {}), // TODO: legal page
        Text(' & ', style: muted),
        LegalLink(label: l10n.privacyLabel, onTap: () {}), // TODO: legal page
      ],
    );
  }
}
