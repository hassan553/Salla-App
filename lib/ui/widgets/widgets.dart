import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/ui/views/home_view_page.dart';
import 'package:store_app/ui/views/product_detail_view.dart';
import 'package:store_app/ui/views/products_view.dart';
import 'package:store_app/ui/views/search_product_view.dart';
Widget buildTextField({
  var controller,
  var keyboard,
  var hint,
  var valid,
  var prefix,
  var obscure = false,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboard,
    obscureText: obscure,
    validator: valid,
    decoration: InputDecoration(
      hintText: hint,
      suffixIcon: prefix,
      hintStyle: const TextStyle(color: Colors.black),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            20,
          ),
          bottomRight: Radius.circular(
            20,
          ),
        ),
      ),
    ),
  );
}
Widget buildDrawer(context) {
  return Drawer(
   
    child: ListView(
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.blue,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Salla App ',
                style: GoogleFonts.abel(
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
              HomePageView(),
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
              SearchProductView(),
            );
          },
        ),
        buildListTitle(
          'Product Detail  ',
          Icons.details,
          () {
            navigateTo(
              context,
              ProductDetailView(),
            );
          },
        ),
      ],
    ),
  );
}

void navigateTo(context, screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return screen;
  }));
}

Widget buildListTitle(
  String title,
  IconData iconData,
  dynamic function,
) {
  return ListTile(
    onTap: function,
    title: Text(
      title,
      softWrap: true,
      style: GoogleFonts.abel(
        letterSpacing: 2,
        fontSize: 15,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    leading: Icon(
      iconData,
      color: Colors.blue,
    ),
  );
}
