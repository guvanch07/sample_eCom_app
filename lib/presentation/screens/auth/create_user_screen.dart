import 'package:ecommerce_app/presentation/screens/widgets/dismiss_ex_widget.dart';
import 'package:ecommerce_app/providers/notifiers/auth/auth_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
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
      appBar: AppBar(title: const Text('Register')),
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
                  return CupertinoButton.filled(
                    onPressed: isLoading
                        ? null
                        : () {
                            if (_formKey.currentState?.validate() ?? false) {
                              authStateAction.register(
                                nameController.text,
                                passwordController.text,
                              );
                            }
                          },
                    child: isLoading
                        ? const CircularProgressIndicator.adaptive()
                        : const Text('Register'),
                  );
                },
              ),
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
    } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return 'Username can only contain letters, numbers, and underscores';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    } else if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    } else if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }
}
