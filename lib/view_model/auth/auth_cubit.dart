// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_app/models/user_model.dart';

import 'package:store_app/repository/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepo authRepo;
  AuthCubit({required this.authRepo}) : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  UserModel userModel = UserModel();
   bool obscure = false;
  void changePasswordIcon() {
    obscure = !obscure;
    emit(ChangePasswordIcon());
  }
  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(AuthLoginLoadingState());
    final result = await authRepo.userLogin(email: email, password: password);
    result.fold(
      (l) => emit(AuthLoginErrorState(error: l.message)),
      (r) => emit(AuthLoginSuccessState(userModel: r)),
    );
  }

  void userRegister(
      {required String name,
      required String email,
      required String phone,
      required String password}) async {
    emit(AuthRegisterLoadingState());
    final result = await authRepo.userRegister(
        name: name, email: email, phone: phone, password: password);
    result.fold(
      (l) => emit(AuthRegisterErrorState(error: l.message)),
      (r) => emit(AuthRegisterSuccessState(userModel: r)),
    );
  }
}
