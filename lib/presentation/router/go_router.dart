import 'package:ecommerce_app/presentation/screens/auth/create_user_screen.dart';
import 'package:ecommerce_app/presentation/screens/auth/login_screen.dart';
import 'package:ecommerce_app/presentation/screens/favorites/favorite_screen.dart';
import 'package:ecommerce_app/presentation/screens/home/home.dart';
import 'package:ecommerce_app/presentation/screens/products/products_screen.dart';
import 'package:ecommerce_app/presentation/screens/profile/profile_screen.dart';
import 'package:ecommerce_app/providers/notifiers/auth/auth_notifier.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');

final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final auth = ref.read(authStateProvider);
      final isAuthenticated = auth.isAuthenticated;
      final isLoggingIn = state.uri.pathSegments.contains('login');
      final isRegistering = state.uri.pathSegments.contains('register');

      if (isAuthenticated && (isLoggingIn || isRegistering)) {
        return '/a';
      }
      if (!isAuthenticated && !isLoggingIn && !isRegistering) {
        return '/login';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: LoginScreen(),
        ),
        routes: [
          GoRoute(
            name: 'register',
            path: 'register',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CreateUserScreen(),
            ),
          )
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorAKey,
            routes: [
              GoRoute(
                path: '/a',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: ProductsScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorBKey,
            routes: [
              GoRoute(
                path: '/b',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: FavoriteScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorCKey,
            routes: [
              GoRoute(
                path: '/c',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: ProfileScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  ),
);

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream stream) {
    stream.listen((event) {
      notifyListeners();
    });
  }
}
