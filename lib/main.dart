import 'package:ecommerce_app/presentation/router/go_router.dart';
import 'package:ecommerce_app/providers/notifiers/auth/auth_notifier.dart';
import 'package:ecommerce_app/providers/notifiers/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

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
