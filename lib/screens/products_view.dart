import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/screens/widgets/custom_darwer.dart';
import '../../models/product_model.dart';
import '../view_model/home/products_cubit.dart';
import 'search_product_view.dart';

class AllProductsView extends StatelessWidget {
  const AllProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          drawer: const BuildDrawer(),
          appBar: AppBar(
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const SearchProductView();
                    }));
                  },
                  icon: const Icon(
                    Icons.search,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.person,
                  )),
            ],
            title: const Text(
              'Salla App',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          body: ConditionalBuilder(
            condition: ProductsCubit.get(context).productModel != null,
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
            builder: (context) => SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child:
                    buildCategories(ProductsCubit.get(context).productModel!),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCategories(ProductModel model) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      itemCount: model.data!.products!.length,
      itemBuilder: (context, index) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: NetworkImage(model.data!.products![index].image.toString()),
            fit: BoxFit.cover,
            height: 100,
            width: 100,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                model.data!.products![index].name.toString(),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.deepPurpleAccent,
          ),
        ],
      ),
    );
  }
}
