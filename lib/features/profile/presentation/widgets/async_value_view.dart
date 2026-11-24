import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/extension/l10n_extension.dart';
import '../../profile_core.dart';
import 'profile_theme_x.dart';

class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({
    super.key,
    required this.value,
    required this.data,
    required this.onRetry,
    this.loadingBuilder,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final VoidCallback onRetry;

  /// Loading-এর সময় কী দেখাবে (যেমন skeleton)। না দিলে spinner।
  final WidgetBuilder? loadingBuilder;

  /// Raw error (HTML, stack, long JSON) কখনও UI-তে দেখাবে না।
  String _message(Object e) {
    if (e is AppException && e.message.isNotEmpty) return e.message;
    return 'কিছু একটা সমস্যা হয়েছে। আবার চেষ্টা করুন।';
  }

  @override
  Widget build(BuildContext context) {
    return value.when(
      loading: () =>
      loadingBuilder?.call(context) ??
          const Padding(
            padding: EdgeInsets.all(AppDimens.md),
            child: Center(child: CircularProgressIndicator()),
          ),
      error: (e, _) {
        log("==========================================Errror $e");
        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimens.md),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: AppDimens.sm,
              children: [
                const Icon(
                  Icons.cloud_off_rounded,
                  size: 40,
                  color: AppColors.textMuted,
                ),
                CustomText(
                  _message(e),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: context.tt.bodyMedium,
                ),
                CustomButton(label: context.l10n.pfRetry, onPressed: onRetry),
              ],
            ),
          ),
        );
      },
      data: data,
    );
  }
}