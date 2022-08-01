import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/core/models/product_model.dart';
import 'package:store_app/ui/views/search_product_view.dart';

import '../widgets/widgets.dart';

class ProductDetailView extends StatelessWidget {
  Products? productModel;
  ProductDetailView({Key? key, this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 15,
            left: 10,
            right: 10,
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image.network(
                    productModel!.image.toString(),
                    width: double.infinity,
                    fit: BoxFit.fill,
                    height: 250,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.blue,
                            size: 30,
                          )),
                      const Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.star_border,
                            color: Colors.blue,
                            size: 30,
                          )),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                productModel?.name ?? ' ',
                style: GoogleFonts.abel(fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    productModel?.description ?? ' ',
                    style: GoogleFonts.abel(fontSize: 18),
                  ),
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$ ${productModel?.price.toString()}',
                        style: GoogleFonts.alatsi(
                            fontSize: 18, color: Colors.deepPurpleAccent),
                      ),
                      Text(
                        '\$ ${productModel?.oldPrice.toString()}',
                        style: GoogleFonts.alatsi(
                          fontSize: 15,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue, minimumSize: const Size(50, 50)),
                    child: Text(
                      'Add To Cart ',
                      style:
                          GoogleFonts.alatsi(fontSize: 15, color: Colors.black),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
