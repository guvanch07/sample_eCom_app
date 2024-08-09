import 'package:ecommerce_app/providers/notifiers/auth/auth_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final userName = ref.watch(
      authStateProvider.select((value) => value.username),
    );
    final isloading = ref.watch(
      authStateProvider.select((value) => value.isLoading),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          userName ?? 'Username',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 24),
        CupertinoButton.filled(
          onPressed: isloading
              ? null
              : () => ref.read(authStateProvider.notifier).logout(),
          child: isloading
              ? const CircularProgressIndicator.adaptive()
              : const Text('Log out'),
        )
      ],
    );
  }
}
