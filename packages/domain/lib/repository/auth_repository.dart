abstract interface class IAuthRepository {
  Future<int?> createUser(String username, String password);
  Future<Map<String, dynamic>?> getUser(String username);
}
