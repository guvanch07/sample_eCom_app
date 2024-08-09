class AuthState {
  final bool isAuthenticated;
  final String? username;
  final bool isLoading;
  final String? error;

  const AuthState(
      {required this.isAuthenticated,
      this.username,
      this.isLoading = false,
      this.error});

  AuthState copyWith({
    bool? isAuthenticated,
    String? username,
    bool? isLoading,
    String? error,
  }) =>
      AuthState(
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
        username: username ?? this.username,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
      );

  @override
  String toString() {
    return 'AuthState(isAuthenticated: $isAuthenticated, username: $username, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(covariant AuthState other) {
    if (identical(this, other)) return true;

    return other.isAuthenticated == isAuthenticated &&
        other.username == username &&
        other.isLoading == isLoading &&
        other.error == error;
  }

  @override
  int get hashCode {
    return isAuthenticated.hashCode ^
        username.hashCode ^
        isLoading.hashCode ^
        error.hashCode;
  }
}
