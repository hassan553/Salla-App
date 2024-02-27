// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: avoid_print
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_app/models/category_model.dart';
import 'package:store_app/repository/home_repo.dart';
import '../../models/product_model.dart';
import '../../models/user_model.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  HomeRepo homeRepo;
  ProductsCubit(this.homeRepo) : super(ProductsInitial());
  static ProductsCubit get(context) => BlocProvider.of(context);

  //get all product from repositry;
  ProductModel productModel = ProductModel();

  void productsData() async {
    emit(GetProductLoadingState());
    final result = await homeRepo.getProductSData();
    result.fold(
      (l) => emit(GetProductErrorState(error: l.message)),
      (r) => emit(GetProductSuccessState(r)),
    );
  }

  //get all categories from repositry
  CategoriesModel categoriesModel = CategoriesModel();

  void categoriesData() async {
    emit(GetCategoriesLoadingState());
    final result = await homeRepo.getCategoriesData();
    result.fold(
      (l) => emit(GetCategoriesErrorState(error: l.message)),
      (r) => emit(GetCategoriesSuccessState(r)),
    );
  }

  List<Products> searchProducts = [];
  void searchForProduct(String? value) {
    try {
      searchProducts = productModel.data!.products!
          .where((element) =>
              element.name!.toLowerCase().startsWith(value!.toLowerCase()))
          .toList();

      emit(SearchSuccessState());
    } catch (error) {
      emit(SearchErrorState());
    }
  }
}
