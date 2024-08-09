abstract interface class IAuthRepository {
  Future<void> createUser(String username, String password);
  Future<Map<String, dynamic>?> getUser(String username);
}
