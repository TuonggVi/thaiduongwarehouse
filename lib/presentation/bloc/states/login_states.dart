// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {}

class LoginStateInitial extends LoginState {
  bool isUsernameErr;
  bool isPasswordErr;
  bool isShow;
  LoginStateInitial(this.isUsernameErr, this.isPasswordErr, this.isShow);
  @override
  List<Object> get props => [isUsernameErr, isPasswordErr, isShow];
}

class LoginStateFormatChecking extends LoginState {
  bool isUsernameErr;
  bool isPasswordErr;

  LoginStateFormatChecking(
    this.isPasswordErr,
    this.isUsernameErr,
  );
  @override
  List<Object> get props => [isUsernameErr, isPasswordErr];
}

class LoginStateToggleShow extends LoginState {
  bool isShow;
  LoginStateToggleShow(this.isShow);
  @override
  List<Object> get props => [isShow];
}

class LoginStateLoadingRequest extends LoginState {
  DateTime timestamp;
  LoginStateLoadingRequest(
    this.timestamp,
  );
  @override
  List<Object> get props => [timestamp];
}

class LoginStateLoginSuccessful extends LoginState {
  DateTime timestamp;
  // LoginData loginData;
  LoginStateLoginSuccessful(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class LoginStateLoginFailure extends LoginState {
  DateTime timestamp;
//  ErrorPackage errorPackage;
  LoginStateLoginFailure(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}
