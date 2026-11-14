import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../../../core/gen/assets_gen.dart';
import '../../../../../core/utils/localized_format.dart';
import '../../../data/model/student_profile_model.dart';
import '../../../profile_core.dart';
import '../../widgets/profile_widgets.dart';
import 'student_actions.dart';

class StudentHeader extends ConsumerWidget {
  const StudentHeader(this.p, {this.applicationsCount = 0, super.key});

  final StudentFullProfileModel p;

  /// Comes from the applications list (it is not part of the profile JSON).
  final int applicationsCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = context.l10n;
    final palette = context.palette;
    final nocIssued = p.nocNumber.isNotEmpty;
    final roll = p.boardRoll.isEmpty
        ? ''
        : l.pfRoll(context.fmtDigits(p.boardRoll));
    final cgpa =
        '${context.fmtNumber(p.cgpaScale, decimals: 2)} / ${context.fmtNumber(p.cgpaScale, decimals: 2)}';

    return ProfileHeader(
      name: p.name,
      imageUrl: p.avatarUrl,
      fallbackAsset: Assets.icons.maleAvatar,
      coverUrl: p.coverImage,
      subtitle: p.department,
      badges: [
        if (p.isVerified)
          (
            label: l.pfStudentVerified,
            icon: Icons.verified_rounded,
            color: palette.brand,
          ),
      ],
      meta: [
        (
          icon: Icons.apartment_rounded,
          text: [p.institute, roll].where((e) => e.isNotEmpty).join(' • '),
        ),
      ],
      actions: [
        CustomButton(
          label: l.pfDownloadCv,
          icon: Icons.download_rounded,
          onPressed: () => openLink(context, p.cvUrl ?? ''),
        ),
        CustomButton(
          label: l.pfUpdateCv,
          icon: Icons.upload_file_rounded,
          variant: CustomButtonVariant.accent,
          onPressed: () => updateStudentCv(context, ref, p),
        ),
        CustomButton(
          label: l.pfEditProfile,
          icon: Icons.manage_accounts_rounded,
          variant: CustomButtonVariant.outline,
          onPressed: () => editStudentInfo(context, ref, p),
        ),
        IconButton.outlined(
          onPressed: () => copyProfileLink(context),
          icon: const Icon(Icons.share_outlined, size: 18),
        ),
      ],
      stats: [
        HeaderStat(
          label: l.pfStatCurrent,
          value: l.pfSemesterN(context.fmtDigits(p.semester)),
          color: palette.success,
        ),
        HeaderStat(label: l.pfStatCgpa, value: cgpa, color: palette.brand),
        HeaderStat(
          label: l.pfStatApplied,
          value: l.pfStatAppliedValue(context.fmtDigits(applicationsCount)),
          color: context.cs.onSurface,
        ),
        HeaderStat(
          label: l.pfStatNoc,
          color: nocIssued ? palette.success : AppColors.urgent,
          child: StatusPill(
            label: nocIssued ? l.pfNocIssued : l.pfNocPending,
            color: nocIssued ? palette.success : AppColors.urgent,
            icon: Icons.check_circle_rounded,
          ),
        ),
      ],
    );
  }
}
