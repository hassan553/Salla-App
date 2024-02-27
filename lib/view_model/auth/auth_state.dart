// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class ChangePasswordIcon extends AuthState {}

class AuthLoginErrorState extends AuthState {
  final String error;
  AuthLoginErrorState({required this.error});
}

class AuthLoginLoadingState extends AuthState {}

class AuthLoginSuccessState extends AuthState {
  final UserModel userModel;
  AuthLoginSuccessState({required this.userModel});
}

class AuthRegisterErrorState extends AuthState {
  final String error;
  AuthRegisterErrorState({required this.error});
}

class AuthRegisterLoadingState extends AuthState {}

class AuthRegisterSuccessState extends AuthState {
  final UserModel userModel;

  AuthRegisterSuccessState({required this.userModel});
}
