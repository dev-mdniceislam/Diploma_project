import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extension/l10n_extension.dart';
import '../../profile_core.dart';
import 'profile_theme_x.dart';

class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({
    super.key,
    required this.value,
    required this.data,
    required this.onRetry,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return value.when(
      loading: () => const SizedBox(
        height: 320,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => SizedBox(
        height: 320,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: AppDimens.sm,
              children: [
                const Icon(
                  Icons.cloud_off_rounded,
                  size: 40,
                  color: AppColors.textMuted,
                ),
                CustomText(
                  '$e',
                  textAlign: TextAlign.center,
                  style: context.tt.bodyMedium,
                ),
                CustomButton(label: context.l10n.pfRetry, onPressed: onRetry),
              ],
            ),
          ),
        ),
      ),
      data: data,
    );
  }
}
