import 'dart:ui' as ui;

import 'package:diploma_job/core/constants/app_dimens.dart';
import 'package:diploma_job/core/theme/orbit_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_providers.dart';
import 'auth_form_view.dart';
import 'auth_forgot_view.dart';
import 'auth_success_view.dart';

/// Frosted porcelain card — HTML `.frosted-panel` + top gradient strip।
class AuthCard extends ConsumerWidget {
  const AuthCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = OrbitPalette.of(context);
    final view = ref.watch(authNotifierProvider.select((s) => s.view));
    final isLarge = MediaQuery.sizeOf(context).width >= AppDimens.mobileMax;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: p.ink.withValues(alpha: 0.08),
            blurRadius: 50,
            spreadRadius: -12,
            offset: const Offset(0, 24),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.86),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: p.glassBorder),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 3,
                  decoration: BoxDecoration(gradient: p.brandGradient),
                ),
                Padding(
                  padding: EdgeInsets.all(isLarge ? 36 : 24),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    switchInCurve: Curves.easeOut,
                    child: KeyedSubtree(
                      key: ValueKey(view),
                      child: _viewFor(view),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _viewFor(AuthView view) => switch (view) {
    AuthView.form => const AuthFormView(),
    AuthView.forgotPassword => const AuthForgotView(),
    AuthView.success => const AuthSuccessView(),
  };
}
