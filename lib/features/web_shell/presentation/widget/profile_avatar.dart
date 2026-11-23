import 'package:diploma_job/core/extension/l10n_extension.dart';
import 'package:diploma_job/core/gen/assets_gen.dart';
import 'package:diploma_job/core/router/app_router.dart';
import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/widgets/custom_image.dart';
import 'package:diploma_job/core/widgets/roated_gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, this.imagePath, this.ontap});

  /// Cloudinary/network URL। না থাকলে default avatar।
  final String? imagePath;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    final hasImage = imagePath != null && imagePath!.isNotEmpty;

    return Tooltip(
      message: context.l10n.navMyProfile,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap:
            ontap ??
            () {
              context.go(AppRoutes.profile);
            },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            RotatingGradientBorder(
              borderRadius: 100,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // border: Border.all(color: AppColors.primary600, width: 2),
                ),
                child: CustomImage(
                  imagePath: hasImage ? imagePath! : Assets.icons.maleAvatar,
                  width: 42,
                  height: 42,
                  borderRadius: BorderRadius.circular(100),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: -2,
              bottom: -2,
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: AppColors.accentGreen,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
