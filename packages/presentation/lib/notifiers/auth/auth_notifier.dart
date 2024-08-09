import 'package:domain/repository/auth_repository.dart';
import 'package:riverpod/riverpod.dart';

import '../../providers.dart';
import 'auth_state.dart';

final authStateProvider =
    StateNotifierProvider.autoDispose<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(
    ref.watch<IAuthRepository>(authProvider),
  ),
);

class AuthNotifier extends StateNotifier<AuthState> {
  final IAuthRepository _authRepository;

  AuthNotifier(this._authRepository)
      : super(const AuthState(isAuthenticated: false));

  Future<void> login(String username, String password) async {
    state = state.copyWith(isLoading: true);
    final user = await _authRepository.getUser(username);

    if (user != null && user['password'] == password) {
      state = state.copyWith(
        isAuthenticated: true,
        username: username,
        isLoading: false,
      );
    } else {
      state = state.copyWith(
        isAuthenticated: false,
        error: 'Invalid username or password',
        isLoading: false,
      );
    }
  }

  Future<void> register(String username, String password) async {
    state = state.copyWith(isLoading: true);
    final created = await _authRepository.createUser(username, password);
    if (created != null) {
      state = state.copyWith(
        isAuthenticated: true,
        username: username,
        isLoading: false,
      );
    } else {
      state = state.copyWith(
        isAuthenticated: false,
        isLoading: false,
      );
    }
  }

  void logout() {
    state = state.copyWith(isLoading: true);
    state = const AuthState(isAuthenticated: false, isLoading: false);
  }

  bool get isAuthenticated => state.isAuthenticated;
}
