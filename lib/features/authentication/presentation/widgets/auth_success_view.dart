import 'package:diploma_job/core/extension/l10n_extension.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/theme/orbit_palette.dart';
import 'package:diploma_job/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/auth_user.dart';
import '../providers/auth_providers.dart';
import 'ping_dot.dart';

class AuthSuccessView extends ConsumerStatefulWidget {
  const AuthSuccessView({super.key});

  @override
  ConsumerState<AuthSuccessView> createState() => _AuthSuccessViewState();
}

class _AuthSuccessViewState extends ConsumerState<AuthSuccessView> {
  bool _continuing = false;

  @override
  void initState() {
    super.initState();
    // Card kichhukkhon dekhabe, tarpor home-e jabe
    Future<void>.delayed(const Duration(milliseconds: 1500), _continue);
  }

  Future<void> _continue() async {
    if (_continuing || !mounted) return;
    _continuing = true;
    await ref.read(authNotifierProvider.notifier).finishRegistration();
    if (mounted) _continuing = false;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final p = OrbitPalette.of(context);
    final user = ref.watch(authNotifierProvider.select((s) => s.user));
    final firstName = (user?.name ?? '').trim().split(' ').first;
    final isCompany = user?.role == UserRole.company;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox.square(
          dimension: 80,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              PingDot(
                size: 80,
                solid: false,
                color: p.emerald.withValues(alpha: 0.25),
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: p.successGradient,
                  boxShadow: [
                    BoxShadow(
                      color: p.emerald.withValues(alpha: 0.25),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: p.indigo.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(99),
            border: Border.all(color: p.indigo.withValues(alpha: 0.3)),
          ),
          child: Text(
            l10n.orbitSynchronized,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w700,
              color: p.indigo,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          l10n.welcomeAboard(firstName),
          textAlign: TextAlign.center,
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: p.ink,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.successDesc,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium.copyWith(color: p.muted),
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: p.canvas,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: p.line),
          ),
          child: Column(
            children: [
              _PreviewRow(
                label: l10n.activeOrbitProfile,
                value: isCompany ? l10n.roleCompanyTag : l10n.roleStudentTag,
                valueColor: p.indigo,
              ),
              const SizedBox(height: 12),
              _PreviewRow(
                label: l10n.nextRecommendedStep,
                value: l10n.nextStepValue,
                valueColor: p.amber,
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: Container(
                  height: 6,
                  color: p.line,
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    alignment: Alignment.centerLeft,
                    child: DecoratedBox(
                      decoration: BoxDecoration(gradient: p.brandGradient),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        CustomButton(
          label: l10n.returnToAuth,
          fullWidth: true,
          buttonHeight: 44,
          borderRadius: 12,
          gradient: p.brandGradient,
          onPressed: _continue,
        ),
      ],
    );
  }
}

class _PreviewRow extends StatelessWidget {
  const _PreviewRow({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    final p = OrbitPalette.of(context);
    return Row(
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w500,
            color: p.muted,
          ),
        ),
        const Spacer(),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w700,
              color: valueColor,
            ),
          ),
        ),
      ],
    );
  }
}
