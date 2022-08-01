// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_app/core/models/category_model.dart';

import '../../models/product_model.dart';
import '../../models/user_model.dart';
import '../../services/api.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  static ProductsCubit get(context) => BlocProvider.of(context);

  //get all product from repositry;
  ProductModel? productModel;
  Future fatchProductsData() async {
    emit(GetProductLoadingState());
    try {
      var data = await API().getProductSData();

      productModel = ProductModel.fromJson(data);

      emit(GetProductSuccessState());
    } catch (error) {
      print(error);
      emit(GetProductErrorState());
    }
  }

  //get all Categories from repositry;
  late CategoriesModel categoriesModel;
  Future fatchCategoriesData() async {
    emit(GetCategoriesLoadingState());
    try {
      var data = await API().getCategoriesData();

      categoriesModel = CategoriesModel.fromJson(data);

      emit(GetCategoriesSuccessState());
    } catch (error) {
      print(error);
      emit(GetCategoriesErrorState());
    }
  }

  List<Products> searchProducts = [];
  void searForProduct(String? value) {
    try {
      searchProducts = productModel!.data!.products!
          .where((element) =>
              element.name!.toLowerCase().startsWith(value!.toLowerCase()))
          .toList();
      print('SearchSuccessState');
      emit(SearchSuccessState());
    } catch (error) {
      emit(SearchErrorState());
    }
  }

  bool obscure = false;
  void changePasswordIcon() {
    obscure = !obscure;
    emit(ChangePasswordIcon());
  }

  dynamic userModel;
  void fetchUserLogin({
    var email,
    var password,
  }) {
    emit(LoginLoadingState());
    API()
        .userLogin(
      email: email,
      password: password,
    )
        .then((value) {
      userModel = UserModel.fromJson(value);
      emit(LoginSuccesfullyState(data: userModel));
    }).catchError((onError) {
      emit(LoginErrorState());
    });
  }

  Future fatchUserRegister({
    var name,
    var phone,
    var password,
    var email,
  }) async {
    emit(RegisterLoadingState());
    API()
        .userRegister(
      email: email,
      password: password,
      phone: phone,
      name: name,
    )
        .catchError((onError) {
      print(onError.toString());
      emit(RegisterErrorState());
    }).then((value) {
      userModel = UserModel.fromJson(value);
      emit(RegisterSuccesfullyState());
    });
  }
}
