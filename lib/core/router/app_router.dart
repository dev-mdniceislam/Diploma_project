import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/auth_page.dart';
import '../../features/home_screen/presentation/page/home_page.dart';
import '../../features/job_details/presentation/screens/job_details_screen.dart';
import '../../features/student_profile/presentation/screens/student_profile_screen.dart';
import '../../features/web_shell/presentation/pages/app_shell.dart';

class AppRoutes {
  AppRoutes._();

  static const home = '/';
  static const about = '/about';
  static const academic = '/academic';
  static const postCircular = '/postCircular';
  static const saved = '/saved';
  static const guide = '/guide';
  static const auth = '/authentication';
  static const studentProfile = '/studentProfile';
  static const jobDetails = '/job/:id';
  static String detailsOf(String id) => '/job/$id';
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
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
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: 'home',
                builder: (_, __) => const HomePage(),
                routes: [
                  GoRoute(
                    path: AppRoutes.jobDetails, // '/job/:id'
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
                path: AppRoutes.studentProfile,
                name: 'studentProfile',
                builder: (_, __) => const StudentProfileScreen(),
              ),
            ],
          ),

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
    ],
  );
});
