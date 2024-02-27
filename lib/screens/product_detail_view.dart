import 'package:flutter/material.dart';
import 'package:store_app/screens/widgets/custom_darwer.dart';

import '../../models/product_model.dart';
import 'search_product_view.dart';

class ProductDetailView extends StatelessWidget {
  final Products? productModel;
  const ProductDetailView({Key? key, this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const BuildDrawer(),
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                style: const TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    productModel?.description ?? ' ',
                    style: const TextStyle(fontSize: 18),
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
                        style: const TextStyle(
                            fontSize: 18, color: Colors.deepPurpleAccent),
                      ),
                      Text(
                        '\$ ${productModel?.oldPrice.toString()}',
                        style: const TextStyle(
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
                        backgroundColor: Colors.blue,
                        minimumSize: const Size(50, 50)),
                    child: const Text(
                      'Add To Cart ',
                      style: TextStyle(fontSize: 15, color: Colors.black),
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
