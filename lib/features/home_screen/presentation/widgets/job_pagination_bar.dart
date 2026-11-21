import 'package:diploma_job/core/responsive/responsive.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_pellete.dart';
import '../../domain/entities/job.dart';

/// HTML hub-এর pagination design অনুযায়ী:
/// বাম দিকে summary, ডান দিকে পূর্ববর্তী / পেজ নম্বর / পরবর্তী।
class JobPaginationBar extends StatelessWidget {
  const JobPaginationBar({
    super.key,
    required this.pagination,
    required this.visibleCount,
    required this.onPageSelected,
    this.isBusy = false,
  });

  final JobPagination pagination;

  /// এই পেজে ফিল্টারের পরে যতগুলো card দেখানো হচ্ছে।
  final int visibleCount;
  final bool isBusy;
  final ValueChanged<int> onPageSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final page = pagination.page;
    final totalPages = pagination.totalPages < 1 ? 1 : pagination.totalPages;
    final start = (page - 1) * pagination.limit + 1;
    final end = visibleCount == 0 ? 0 : start + visibleCount - 1;
    final isMobile = Responsive.isMobile(context);

    final summary = Text.rich(
      TextSpan(
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
        ),
        children: [
          const TextSpan(text: 'মোট '),
          TextSpan(
            text: _bn(pagination.total),
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
          const TextSpan(text: ' টি সার্কুলারের মধ্যে '),
          TextSpan(
            text: '${_bn(start)} - ${_bn(end)}',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: context.palette.brand,
            ),
          ),
          const TextSpan(text: ' টি দেখানো হচ্ছে '),
          TextSpan(
            text: '(পৃষ্ঠা ${_bn(page)}/${_bn(totalPages)})',
            style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
          ),
        ],
      ),
      textAlign: isMobile ? TextAlign.center : TextAlign.start,
    );

    final controls = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _NavButton(
            label: 'পূর্ববর্তী',
            icon: Icons.chevron_left_rounded,
            leading: true,
            enabled: page > 1 && !isBusy,
            onTap: () => onPageSelected(page - 1),
          ),
          const SizedBox(width: 8),
          for (final item in _pageItems(page, totalPages)) ...[
            if (item == null)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Text('…', style: TextStyle(color: AppColors.textMuted)),
              )
            else
              _PageButton(
                number: item,
                active: item == page,
                enabled: !isBusy,
                onTap: () => onPageSelected(item),
              ),
            const SizedBox(width: 6),
          ],
          const SizedBox(width: 2),
          _NavButton(
            label: 'পরবর্তী',
            icon: Icons.chevron_right_rounded,
            leading: false,
            enabled: pagination.hasNextPage && !isBusy,
            onTap: () => onPageSelected(page + 1),
          ),
        ],
      ),
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outline),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: isMobile
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                summary,
                const SizedBox(height: 12),
                Center(child: controls),
              ],
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: summary),
                const SizedBox(width: 16),
                controls,
              ],
            ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.label,
    required this.icon,
    required this.leading,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool leading;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final iconWidget = Icon(
      icon,
      size: 16,
      color: enabled ? AppColors.textSecondary : AppColors.textMuted,
    );
    final text = Text(
      label,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: enabled ? scheme.onSurface : AppColors.textMuted,
      ),
    );
    final children = leading
        ? <Widget>[iconWidget, const SizedBox(width: 4), text]
        : <Widget>[text, const SizedBox(width: 4), iconWidget];

    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: Material(
        color: scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: scheme.outline),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: enabled ? onTap : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            child: Row(mainAxisSize: MainAxisSize.min, children: children),
          ),
        ),
      ),
    );
  }
}

class _PageButton extends StatelessWidget {
  const _PageButton({
    required this.number,
    required this.active,
    required this.enabled,
    required this.onTap,
  });

  final int number;
  final bool active;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final brand = context.palette.brand;

    return Material(
      color: active ? brand : scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: active ? brand : scheme.outline),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: enabled && !active ? onTap : null,
        child: SizedBox(
          width: 32,
          height: 32,
          child: Center(
            child: Text(
              _bn(number),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: active ? AppColors.white : scheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// null মানে ellipsis (…)। পেজ বেশি হলে আশেপাশের কয়েকটি দেখায়।
List<int?> _pageItems(int current, int total) {
  if (total <= 7) return [for (var i = 1; i <= total; i++) i];

  final pages = <int>{
    1,
    total,
    current - 1,
    current,
    current + 1,
  }.where((p) => p >= 1 && p <= total).toList()..sort();

  final out = <int?>[];
  for (var i = 0; i < pages.length; i++) {
    if (i > 0 && pages[i] - pages[i - 1] > 1) out.add(null);
    out.add(pages[i]);
  }
  return out;
}

const _bnDigits = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];

String _bn(int value) => value.toString().split('').map((c) {
  final d = int.tryParse(c);
  return d == null ? c : _bnDigits[d];
}).join();
