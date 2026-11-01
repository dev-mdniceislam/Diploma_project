import 'package:diploma_job/core/constants/app_constants.dart';
import 'package:diploma_job/core/gen/assets_gen.dart';
import 'package:diploma_job/core/theme/app_colors.dart';
import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/utils/authentication_middleware.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    final results = await Future.wait([
      AuthMiddleware().middleWare(),
      Future.delayed(const Duration(milliseconds: 1500)),
    ]);

    final bool isLoggedIn = results.first as bool;

    if (!mounted) return;
    context.go(isLoggedIn ? AppRoutes.home : AppRoutes.auth);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Assets.images.appLogo.image(
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              CustomText(
                AppConstants.appName,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.primary,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              const SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
