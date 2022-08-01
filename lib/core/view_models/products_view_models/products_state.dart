part of 'products_cubit.dart';

@immutable
abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

//get all products states
class GetProductLoadingState extends ProductsState {}

class GetProductSuccessState extends ProductsState {}

class GetProductErrorState extends ProductsState {}

//get all Categories states
class GetCategoriesLoadingState extends ProductsState {}

class GetCategoriesSuccessState extends ProductsState {}

class GetCategoriesErrorState extends ProductsState {}

//Search  states
class SearchSuccessState extends ProductsState {}

class SearchErrorState extends ProductsState {}

//user login
class LoginLoadingState extends ProductsState {}

class LoginErrorState extends ProductsState {}

class LoginSuccesfullyState extends ProductsState {
  UserModel data;
  LoginSuccesfullyState({required this.data});
}
class ChangePasswordIcon extends ProductsState {}
//user register
class RegisterLoadingState extends ProductsState {}

class RegisterErrorState extends ProductsState {}

class RegisterSuccesfullyState extends ProductsState {}


