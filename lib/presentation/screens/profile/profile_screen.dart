import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Name', style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 24),
        CupertinoButton.filled(
          child: const Text('Log out'),
          onPressed: () {},
        )
      ],
    );
  }
}
