import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/core/view_models/products_view_models/products_cubit.dart';
import 'package:store_app/ui/views/auth/login_view_page.dart';
import 'package:store_app/ui/views/auth/register_view_page.dart';
import 'package:store_app/ui/views/home_view_page.dart';
import 'package:store_app/ui/views/product_detail_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ProductsCubit()
              ..fatchProductsData()
              ..fatchCategoriesData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RegisterView(),
      ),
    );
  }
}
