import 'package:diploma_job/core/extension/l10n_extension.dart';
import 'package:diploma_job/core/gen/assets_gen.dart';
import 'package:diploma_job/core/providers/locale_provider.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/theme/orbit_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../domain/entities/auth_user.dart';
import '../providers/auth_providers.dart';

// ─── Mode tabs ─────────────────────────────────────────────────

class AuthModeTabs extends StatelessWidget {
  const AuthModeTabs({super.key, required this.mode, required this.onChanged});

  final AuthMode mode;
  final ValueChanged<AuthMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final p = OrbitPalette.of(context);
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: p.line.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: p.line),
      ),
      child: Row(
        children: [
          _Tab(
            label: l10n.tabSignIn,
            selected: mode == AuthMode.login,
            onTap: () => onChanged(AuthMode.login),
          ),
          _Tab(
            label: l10n.tabSignUp,
            selected: mode == AuthMode.signup,
            onTap: () => onChanged(AuthMode.signup),
          ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = OrbitPalette.of(context);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: p.ink.withValues(alpha: 0.06),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                color: selected ? p.indigo : p.muted,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Role selector ─────────────────────────────────────────────

class RoleSelector extends StatelessWidget {
  const RoleSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final UserRole selected;
  final ValueChanged<UserRole> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final p = OrbitPalette.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.roleLabel.toUpperCase(),
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
            color: p.muted,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _RoleCard(
                title: l10n.roleStudentTitle,
                subtitle: l10n.roleStudentSub,
                icon: Icons.school_rounded,
                accent: p.indigo,
                selected: selected == UserRole.student,
                onTap: () => onChanged(UserRole.student),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _RoleCard(
                title: l10n.roleCompanyTitle,
                subtitle: l10n.roleCompanySub,
                icon: Icons.business_center_rounded,
                accent: p.cyan,
                selected: selected == UserRole.company,
                onTap: () => onChanged(UserRole.company),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = OrbitPalette.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? accent.withValues(alpha: 0.06) : p.canvas,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? accent : p.line,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: selected ? accent : accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 16,
                color: selected ? Colors.white : accent,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.w700,
                      color: p.ink,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 10,
                      color: p.muted,
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

// ─── Social buttons ────────────────────────────────────────────

typedef _Provider = ({String name, String asset});

class SocialAuthRow extends StatelessWidget {
  const SocialAuthRow({super.key, required this.onTap});

  final ValueChanged<String> onTap;

  List<_Provider> get _providers => [
    (name: 'Google', asset: Assets.icons.google),
    (name: 'LinkedIn', asset: Assets.icons.linkedin),
    (name: 'GitHub', asset: Assets.icons.github),
  ];

  @override
  Widget build(BuildContext context) => Row(
    children: [
      for (var i = 0; i < _providers.length; i++) ...[
        if (i > 0) const SizedBox(width: 10),
        Expanded(
          child: _SocialButton(
            provider: _providers[i],
            onTap: () => onTap(_providers[i].name),
          ),
        ),
      ],
    ],
  );
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.provider, required this.onTap});

  final _Provider provider;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = OrbitPalette.of(context);
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: p.line),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(provider.asset, width: 17, height: 17),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  provider.name,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: p.inkSoft,
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

// ─── Divider ───────────────────────────────────────────────────

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final p = OrbitPalette.of(context);
    return Row(
      children: [
        Expanded(child: Divider(color: p.line)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            l10n.orContinueWithEmail.toUpperCase(),
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
              color: p.faint,
            ),
          ),
        ),
        Expanded(child: Divider(color: p.line)),
      ],
    );
  }
}

// ─── Password strength meter ───────────────────────────────────

class PasswordStrengthMeter extends StatelessWidget {
  const PasswordStrengthMeter({super.key, required this.score});

  final int score; // 0..4

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final p = OrbitPalette.of(context);
    final labels = [
      l10n.strengthEmpty,
      l10n.strengthWeak,
      l10n.strengthFair,
      l10n.strengthGood,
      l10n.strengthStrong,
    ];
    final colors = [p.faint, p.rose, p.amber, p.cyan, p.emerald];
    final active = colors[score];

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: p.canvas,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: p.line),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.passwordStrength,
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 11,
                  color: p.muted,
                ),
              ),
              Text(
                labels[score],
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: score == 0 ? p.muted : active,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              for (var i = 0; i < 4; i++) ...[
                if (i > 0) const SizedBox(width: 6),
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 6,
                    decoration: BoxDecoration(
                      color: i < score ? active : p.line,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Checkbox row ──────────────────────────────────────────────

class AgreementCheckbox extends StatelessWidget {
  const AgreementCheckbox({
    super.key,
    required this.value,
    required this.label,
    required this.onChanged,
  });

  final bool value;
  final String label;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final p = OrbitPalette.of(context);
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Checkbox(
              value: value,
              activeColor: p.indigo,
              visualDensity: VisualDensity.compact,
              onChanged: (v) => onChanged(v ?? false),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w500,
                color: p.inkSoft,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Legal link ────────────────────────────────────────────────

class LegalLink extends StatelessWidget {
  const LegalLink({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = OrbitPalette.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(
          fontWeight: FontWeight.w600,
          color: p.inkSoft,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

// ─── Language switcher (EN / বাংলা) ────────────────────────────

class LanguageSwitcher extends ConsumerWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = OrbitPalette.of(context);
    final isBn = ref.watch(localeProvider).languageCode == 'bn';
    final notifier = ref.read(localeProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: p.line),
        boxShadow: [
          BoxShadow(
            color: p.ink.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LangChip(
            label: 'EN',
            selected: !isBn,
            onTap: () => notifier.setLocale(const Locale('en')),
          ),
          _LangChip(
            label: 'বাংলা',
            selected: isBn,
            onTap: () => notifier.setLocale(const Locale('bn')),
          ),
        ],
      ),
    );
  }
}

class _LangChip extends StatelessWidget {
  const _LangChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = OrbitPalette.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: selected ? p.indigo : Colors.transparent,
          borderRadius: BorderRadius.circular(99),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: selected ? Colors.white : p.muted,
          ),
        ),
      ),
    );
  }
}
