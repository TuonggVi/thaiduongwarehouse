import 'package:mobile_warehouse_thaiduong/datasource/service/login_service.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginService loginService;
  LoginRepositoryImpl(this.loginService);

  @override
  Future<String> loginRequest(String userName, String password) {
    final loginStatus = loginService.login(userName, password);
    return loginStatus;
  }
}
