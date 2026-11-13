import 'package:flutter/material.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/utils/localized_format.dart';
import '../../../../../core/widgets/custom_overlay_notification.dart';
import '../../../data/profile_models.dart';
import '../../../profile_core.dart';
import '../../widgets/profile_widgets.dart';

class MouTab extends StatelessWidget {
  const MouTab(this.p, {super.key});

  final CompanyProfile p;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final tt = context.tt;

    return Column(
      spacing: AppDimens.md - 4,
      children: [
        SectionHeader(
          title: l.pfPartnersTitle,
          subtitle: l.pfPartnersSub,
          trailing: TextButton(
            onPressed: () => CustomToast.showSuccess(message: l.pfComingSoon),
            child: Text(l.pfAddMou),
          ),
        ),
        ResponsiveWrap(
          mobile: 1,
          tablet: 2,
          desktop: 3,
          children: [
            for (final m in p.partners)
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      StatusPill(
                        label: l.pfMouVerified,
                        color: context.palette.success,
                        icon: Icons.verified_rounded,
                      ),
                      CustomText(
                        m.name,
                        style: tt.titleMedium!.copyWith(
                          color: context.cs.onSurface,
                        ),
                      ),
                      CustomText(
                        l.pfAnnualQuota(context.fmtDigits(m.quota)),
                        style: tt.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
