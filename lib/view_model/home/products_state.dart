// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'products_cubit.dart';

@immutable
abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

//get all products states
class GetProductLoadingState extends ProductsState {}

class GetProductSuccessState extends ProductsState {
  final ProductModel productModel;

  GetProductSuccessState(this.productModel);
}

class GetProductErrorState extends ProductsState {
  final String error;
  GetProductErrorState({required this.error});
}

//get all Categories states
class GetCategoriesLoadingState extends ProductsState {}

class GetCategoriesSuccessState extends ProductsState {
  final CategoriesModel categoriesModel;

  GetCategoriesSuccessState(this.categoriesModel);
}

class GetCategoriesErrorState extends ProductsState {
  final String error;
  GetCategoriesErrorState({required this.error});
}

//Search  states
class SearchSuccessState extends ProductsState {}

class SearchErrorState extends ProductsState {}

//user login
class LoginLoadingState extends ProductsState {}

class LoginErrorState extends ProductsState {}

class LoginSuccessfullyState extends ProductsState {
  UserModel data;
  LoginSuccessfullyState({required this.data});
}

class ChangePasswordIcon extends ProductsState {}

//user register
class RegisterLoadingState extends ProductsState {}

class RegisterErrorState extends ProductsState {}

class RegisterSuccesfullyState extends ProductsState {}
