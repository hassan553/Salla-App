import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/core/services/service_locator.dart';
import 'package:store_app/screens/home_view_page.dart';
import 'view_model/auth/auth_cubit.dart';
import 'view_model/home/products_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) =>locator<AuthCubit>()),
        BlocProvider(
            create: (context) => locator<ProductsCubit>()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '',
        home: HomePageView(),
      ),
    );
  }
}
