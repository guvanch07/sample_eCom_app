import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presentation/notifiers/auth/auth_notifier.dart';
import 'package:presentation/notifiers/auth/auth_state.dart';
import 'package:ui/router/go_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => const ProviderScope(child: _App());
}

class _App extends ConsumerWidget {
  const _App();

  @override
  Widget build(BuildContext context, ref) {
    final router = ref.watch(routerProvider);
    ref.listen<AuthState>(authStateProvider, (previous, next) {
      if (previous?.isAuthenticated != next.isAuthenticated) {
        ref.read(routerProvider).refresh();
      }
    });
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
    );
  }
}
