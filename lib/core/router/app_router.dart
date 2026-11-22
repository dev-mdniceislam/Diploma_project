import 'package:diploma_job/core/theme/app_text_style.dart';
import 'package:diploma_job/core/widgets/custom_text.dart';
import 'package:diploma_job/features/auth/login/presentation/providers/auth_state.dart';
import 'package:diploma_job/features/splash/presentation/page/splash_screen.dart';
import 'package:diploma_job/features/splash/presentation/provider/user_profile_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/auth_page.dart';
import '../../features/home_screen/presentation/page/home_page.dart';
import '../../features/job_details/presentation/screens/job_details_screen.dart';
import '../../features/profile/presentation/profile_entry_screen.dart';
import '../../features/web_shell/presentation/pages/app_shell.dart';

class AppRoutes {
  AppRoutes._();

  static const home = '/';
  static const splash = '/splash';
  static const postCircular = '/postCircular';
  static const saved = '/saved';
  static const guide = '/guide';
  static const auth = '/authentication';
  static const profile = '/profile';
  static const jobDetails = '/job/:id';
  static const myJobDetails = '/my-job/:id';

  static String detailsOf(String id) => '/job/$id';
  static String myDetailsOf(String id) => '/my-job/$id';
}

final rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.read(authStateProvider);
  final refresh = ValueNotifier<int>(0);
  ref.listen(userProfileProvider, (_, __) => refresh.value++);
  ref.onDispose(refresh.dispose);
  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    refreshListenable: refresh,
    redirect: (context, state) {
      final loc = state.matchedLocation;

      // Splash নিজের কাজ করবে
      if (loc == AppRoutes.splash) return null;

      final profileState = ref.read(userProfileProvider);

      // Fetch চলছে: এখনই কোনো সিদ্ধান্ত নয়
      if (profileState.isLoading) return null;

      final loggedIn = profileState.value != null;
      final onAuth = loc == AppRoutes.auth;

      if (loggedIn && onAuth) return AppRoutes.home;
      if (!loggedIn && !onAuth) return AppRoutes.auth;

      return null;
    },
    routes: [
      // Tab-based shell: home, profile, guide, post, saved
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(child: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: 'home',
                builder: (_, __) => const HomePage(),
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

      // Detail routes: AppShell-এর ভেতরে, কিন্তু কোনো branch নয়
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.jobDetails,
            name: 'jobDetails',
            builder: (_, state) =>
                JobDetailsScreen(circularId: state.pathParameters['id']!),
          ),
          GoRoute(
            path: AppRoutes.myJobDetails,
            name: 'myJobDetails',
            builder: (_, state) => JobDetailsScreen(
              circularId: state.pathParameters['id']!,
              isMe: true,
            ),
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
