import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/notifiers/auth/auth_notifier.dart';

import '../../widgets/dismiss_ex_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  static const _decorationInput = InputDecoration(
    filled: true,
    contentPadding: EdgeInsets.all(16),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(24.0).copyWith(top: 70),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                validator: validateUsername,
                decoration: _decorationInput.copyWith(
                  label: const Text('Username'),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                validator: validatePassword,
                decoration: _decorationInput.copyWith(
                  label: const Text('Password'),
                ),
              ),
              const SizedBox(height: 20),
              Consumer(
                builder: (context, ref, _) {
                  final isLoading = ref.watch(authStateProvider).isLoading;
                  final authStateAction = ref.read(authStateProvider.notifier);
                  ref.listen(
                      authStateProvider.select((value) => value.error),
                      (_, error) =>
                          error != null ? _showSnack(context, error) : null);

                  return CupertinoButton.filled(
                    onPressed: isLoading
                        ? null
                        : () {
                            if (_formKey.currentState?.validate() ?? false) {
                              authStateAction.login(
                                nameController.text,
                                passwordController.text,
                              );
                            }
                          },
                    child: isLoading
                        ? const CircularProgressIndicator.adaptive()
                        : const Text('Login'),
                  );
                },
              ),
              const SizedBox(height: 20),
              Text('Not registerd yet?',
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () => context.pushNamed('register'),
                child: const Text('Register'),
              )
            ],
          ),
        ),
      ),
    ).dismissKeyboardWidget();
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username cannot be empty';
    } else if (value.length < 4) {
      return 'Username must be at least 4 characters long';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  void _showSnack(BuildContext context, String text) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
        ),
      );
}
