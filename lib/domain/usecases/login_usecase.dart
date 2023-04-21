import 'package:mobile_warehouse_thaiduong/domain/repositories/login_repository.dart';

class LoginUsecase {
  final LoginRepository _loginRepository;
  LoginUsecase(this._loginRepository);
   Future<String> fetchToken(String userName, String password) async {
    final token = _loginRepository.loginRequest(userName, password);
    return token;
  }
}