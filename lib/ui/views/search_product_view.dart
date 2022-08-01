import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/core/view_models/products_view_models/products_cubit.dart';
import 'package:store_app/ui/views/product_detail_view.dart';

import '../../core/models/product_model.dart';
import '../widgets/widgets.dart';

class SearchProductView extends StatelessWidget {
  SearchProductView({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          drawer: buildDrawer(context),
          appBar: AppBar(
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SearchProductView();
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
            title: Text(
              'Salla App',
              style: GoogleFonts.abel(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildSearchTextField(context, (value) {
                  ProductsCubit.get(context).searForProduct(value);
                }),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ConditionalBuilder(
                    condition: searchController.text.isNotEmpty,
                    fallback: (context) =>
                        const Center(child: CircularProgressIndicator()),
                    builder: (context) => ListView.separated(
                      itemBuilder: (context, index) {
                        return buildProductItem(
                            ProductsCubit.get(context).searchProducts[index],context);
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount:
                          ProductsCubit.get(context).searchProducts.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildProductItem(Products model, context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetailView();
        }));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: NetworkImage(model.image.toString()),
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
                model.name.toString(),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.alatsi(fontSize: 18),
              ),
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  _buildSearchTextField(context, function) {
    return TextFormField(
      onChanged: (value) {
        function(value);
      },
      validator: (value) {
        if (value == null) {
          return 'not valid empty value';
        }
      },
      controller: searchController,
      decoration: InputDecoration(
        fillColor: Colors.white24,
        prefixIcon: const Icon(
          Icons.search,
        ),
        labelText: 'Search',
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.6,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
