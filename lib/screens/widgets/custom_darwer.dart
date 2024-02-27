import 'package:flutter/material.dart';
import 'package:store_app/core/functions/navigation.dart';
import 'package:store_app/screens/home_view_page.dart';
import 'package:store_app/screens/product_detail_view.dart';
import 'package:store_app/screens/products_view.dart';
import '../search_product_view.dart';
import 'custom_textField.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Salla App ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          buildListTitle(
            'Home Page',
            Icons.home,
            () {
              navigateTo(
                context,
                const HomePageView(),
              );
            },
          ),
          buildListTitle(
            'All Product ',
            Icons.production_quantity_limits,
            () {
              navigateTo(
                context,
                const AllProductsView(),
              );
            },
          ),
          buildListTitle(
            'Search For Product  ',
            Icons.search,
            () {
              navigateTo(
                context,
                const SearchProductView(),
              );
            },
          ),
          buildListTitle(
            'Product Detail  ',
            Icons.details,
            () {
              navigateTo(
                context,
                const ProductDetailView(),
              );
            },
          ),
        ],
      ),
    );
  }
}
