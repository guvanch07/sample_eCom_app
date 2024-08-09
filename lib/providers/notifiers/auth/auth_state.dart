class AuthState {
  final bool isAuthenticated;
  final String? username;
  final bool isLoading;

  const AuthState({
    required this.isAuthenticated,
    this.username,
    this.isLoading = false,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    String? username,
    bool? isLoading,
  }) =>
      AuthState(
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
        username: username ?? this.username,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  bool operator ==(covariant AuthState other) {
    if (identical(this, other)) return true;

    return other.isAuthenticated == isAuthenticated &&
        other.username == username &&
        other.isLoading == isLoading;
  }

  @override
  int get hashCode =>
      isAuthenticated.hashCode ^ username.hashCode ^ isLoading.hashCode;

  @override
  String toString() =>
      'AuthState(isAuthenticated: $isAuthenticated, username: $username, isLoading: $isLoading)';
}
