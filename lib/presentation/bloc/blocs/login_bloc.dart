import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/login_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/login_events.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/login_states.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginUsecase loginUsecase;
  LoginBloc(this.loginUsecase) : super(LoginStateInitial(false, false, true)) {
    {
      on((LoginEventChecking event, emit) => LoginStateFormatChecking(
          event.passWord.length < Constants.minLengthPassWord,
          event.userName.length < Constants.minLengthUserName));
      on((LoginEventToggleShow event, emit) =>
          emit(LoginStateToggleShow(!event.isShow)));
      on<LoginEventFetchToken>((event, emit) async {
        emit(LoginStateLoadingRequest(DateTime.now()));
        try {
          final request =
              await loginUsecase.fetchToken(event.userName, event.password);
          if (request != 'error') {
            emit(LoginStateLoginSuccessful(DateTime.now()));
          } else {
            emit(LoginStateLoginFailure(DateTime.now()));
          }
        } catch (e) {
          emit(LoginStateLoginFailure(DateTime.now()));
        }
      });
    }
  }
}
