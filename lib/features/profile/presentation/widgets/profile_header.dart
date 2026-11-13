import 'package:flutter/material.dart';

import '../../profile_core.dart';
import 'profile_theme_x.dart';
import 'responsive_wrap.dart';
import 'status_pill.dart';
import 'stat_tile.dart';

class HeaderStat {
  const HeaderStat({required this.label, this.value, this.child, this.icon, this.color});

  final String label;
  final String? value;
  final Widget? child; // replaces `value` (e.g. a status pill)
  final IconData? icon; // icon => "dashboard" tile, no icon => centered tile
  final Color? color;
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.fallbackAsset,
    this.coverUrl = '',
    this.subtitle = '',
    this.badges = const [],
    this.meta = const [],
    this.actions = const [],
    this.stats = const [],
  });

  final String name, imageUrl, fallbackAsset, coverUrl, subtitle;
  final List<({String label, IconData icon, Color color})> badges;
  final List<({IconData icon, String text})> meta;
  final List<Widget> actions;
  final List<HeaderStat> stats;

  @override
  Widget build(BuildContext context) {
    final cs = context.cs, tt = context.tt;
    final mobile = Responsive.isMobile(context);
    final coverH = mobile ? 150.0 : 230.0;
    final avatar = mobile ? 104.0 : 136.0;
    final pad = mobile ? 16.0 : 28.0;
    final cross = mobile ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final wrapAlign = mobile ? WrapAlignment.center : WrapAlignment.start;

    final details = Column(
      crossAxisAlignment: cross,
      spacing: 6,
      children: [
        Wrap(
          alignment: wrapAlign,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 6,
          children: [
            CustomText(
              name,
              style: tt.headlineLarge!.responsive(context).copyWith(color: cs.onSurface),
            ),
            for (final b in badges) StatusPill(label: b.label, icon: b.icon, color: b.color),
          ],
        ),
        if (subtitle.isNotEmpty)
          CustomText(
            subtitle,
            textAlign: mobile ? TextAlign.center : TextAlign.start,
            style: tt.titleMedium!.copyWith(fontSize: 14, color: context.palette.brand),
          ),
        if (meta.isNotEmpty)
          Wrap(
            alignment: wrapAlign,
            spacing: 14,
            runSpacing: 4,
            children: [
              for (final m in meta)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 4,
                  children: [
                    Icon(m.icon, size: 14, color: AppColors.textMuted),
                    Flexible(child: CustomText(m.text, style: tt.bodySmall)),
                  ],
                ),
            ],
          ),
      ],
    );

    final actionWrap = Wrap(
      alignment: mobile ? WrapAlignment.center : WrapAlignment.end,
      spacing: 10,
      runSpacing: 10,
      children: actions,
    );

    final avatarBox = Container(
      width: avatar,
      height: avatar,
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: cs.surface, width: 4),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: .15), blurRadius: 16, offset: const Offset(0, 6)),
        ],
      ),
      child: CustomImage(
        imagePath: imageUrl.isEmpty ? fallbackAsset : imageUrl,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd + 4),
        errorWidget: Image.asset(fallbackAsset, fit: BoxFit.cover),
      ),
    );

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg + 4),
        border: Border.all(color: cs.outline),
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: coverH,
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        const DecoratedBox(decoration: BoxDecoration(gradient: AppColors.heroGradient)),
                        if (coverUrl.isNotEmpty)
                          Opacity(opacity: .3, child: CustomImage(imagePath: coverUrl)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(pad, 16, pad, 0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: avatar / 2 + 8),
                      child: mobile
                          ? Column(
                              spacing: 14,
                              children: [
                                SizedBox(height: avatar / 2),
                                details,
                                if (actions.isNotEmpty) actionWrap,
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: avatar + 20),
                                Expanded(flex: 3, child: details),
                                if (actions.isNotEmpty) Expanded(flex: 2, child: actionWrap),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: coverH - avatar / 2,
                left: pad,
                right: mobile ? pad : null,
                child: mobile ? Center(child: avatarBox) : avatarBox,
              ),
            ],
          ),
          if (stats.isNotEmpty)
            Padding(
              padding: EdgeInsets.fromLTRB(pad, 20, pad, pad),
              child: Column(
                spacing: 16,
                children: [
                  const Divider(height: 1),
                  ResponsiveWrap(
                    mobile: 2,
                    tablet: 4,
                    desktop: 4,
                    gap: 12,
                    children: [for (final s in stats) StatTile(s)],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
