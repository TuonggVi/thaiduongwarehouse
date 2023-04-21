abstract class LoginRepository {
  Future<String> loginRequest(String userName, String password);
}