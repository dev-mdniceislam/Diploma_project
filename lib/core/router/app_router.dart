import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/widgets/custom_text.dart';
import 'package:diploma_job/features/splash/presentation/page/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/auth_page.dart';
import '../../features/company_profile/profile_loader.dart';
import '../../features/edit_student_profile/presentation/page/overView_details_edit.dart';
import '../../features/home_screen/presentation/page/home_page.dart';
import '../../features/job_details/presentation/screens/job_details_screen.dart';
import '../../features/profile/presentation/profile_entry_screen.dart';
import '../../features/web_shell/presentation/pages/app_shell.dart';

class AppRoutes {
  AppRoutes._();

  static const home = '/';
  static const about = '/about';
  static const splash = '/splash';
  static const academic = '/academic';
  static const postCircular = '/postCircular';
  static const saved = '/saved';
  static const guide = '/guide';
  static const auth = '/authentication';
  static const profile = '/profile';
  static const studentProfileEdit = '/studentProfileEdit';
  static const jobDetails = '/job/:id';
  static String detailsOf(String id) => '/job/$id';
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    errorBuilder: (context, state) => AppShell(
      child: Center(
        child: CustomText(
          "Something went wrong",
          style: AppTextStyles.bodyLarge,
        ),
      ),
    ),
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(child: navigationShell);
        },
        branches: [
          // 0: Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: 'home',
                builder: (_, __) => const HomePage(),
                routes: [
                  GoRoute(
                    path: AppRoutes.jobDetails,
                    name: 'jobDetails',
                    builder: (_, state) => JobDetailsScreen(
                      circularId: state.pathParameters['id']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                name: 'profile',
                builder: (_, __) => const ProfileEntryScreen(),
              ),
            ],
          ),

          // 1: Profile (student বা company, role অনুযায়ী)
          // StatefulShellBranch(
          //   routes: [
          //     GoRoute(
          //       path: AppRoutes.profile,
          //       name: 'profile',
          //       builder: (_, __) => const ProfileLoader(),
          //     ),
          //     GoRoute(
          //       path: AppRoutes.studentProfileEdit,
          //       name: 'studentProfileEdit',
          //       builder: (_, __) => const StudentProfileEditScreen(),
          //     ),
          //   ],
          // ),

          // 2: Guide
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.guide,
                name: 'guide',
                builder: (_, __) => Center(
                  child: CustomText(
                    "Guideline & NOC",
                    style: AppTextStyles.bodyLarge,
                  ),
                ),
              ),
            ],
          ),

          // 3: Post circular
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.postCircular,
                name: 'postCircular',
                builder: (_, __) => Center(
                  child: CustomText(
                    "Post Circular",
                    style: AppTextStyles.bodyLarge,
                  ),
                ),
              ),
            ],
          ),

          // 4: Saved
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.saved,
                name: 'saved',
                builder: (_, __) => Center(
                  child: CustomText(
                    "Saved Circulars",
                    style: AppTextStyles.bodyLarge,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.auth,
        name: 'auth',
        builder: (_, __) => const AuthPage(),
      ),
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (_, __) => const SplashScreen(),
      ),
    ],
  );
});
