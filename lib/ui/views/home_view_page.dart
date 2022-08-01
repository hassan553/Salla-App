import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/core/models/product_model.dart';
import 'package:store_app/core/view_models/products_view_models/products_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/ui/views/product_detail_view.dart';
import 'package:store_app/ui/views/products_view.dart';
import 'package:store_app/ui/views/search_product_view.dart';
import 'package:store_app/ui/widgets/widgets.dart';
import '../../core/models/category_model.dart';

class HomePageView extends StatelessWidget {
  HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProductsCubit.get(context);
        Size size = MediaQuery.of(context).size;
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
          backgroundColor: Colors.white,
          body: ConditionalBuilder(
            condition: cubit.productModel != null,
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
            builder: (context) => ListView(
              children: [
                const SizedBox(
                  height: 3,
                ),
                builderCarouselSlider(model: cubit.productModel!),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Categories',
                        style: GoogleFonts.alatsi(fontSize: 20),
                      ),
                      SizedBox(
                        height: size.height * .02,
                      ),
                      buildCategoriesItem(model: cubit.categoriesModel),
                      SizedBox(
                        height: size.height * .05,
                      ),
                      Row(
                        children: [
                          Text(
                            'Best Sall',
                            style: GoogleFonts.alatsi(fontSize: 25),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                buildGridView(
                  model: cubit.productModel!,
                  context: context,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildGridView({required ProductModel model, context}) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 1,
      crossAxisSpacing: 1,
      childAspectRatio: 1 / 1.3,
      children: List.generate(
        model.data!.products!.length,
        (index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProductDetailView(
                  productModel: model.data!.products![index],
                );
              }));
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Image(
                          height: 150,
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              model.data!.products![index].image.toString()),
                        ),
                        buildDiscount(model, index),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.data!.products![index].name.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${model.data!.products![index].price}\$',
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      model.data!.products![index].price !=
                              model.data!.products![index].oldPrice
                          ? Text(
                              model.data!.products![index].oldPrice.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                              ))
                          : const Text(' '),
                      const Spacer(),
                      Expanded(
                        child: IconButton(
                          color: const Color.fromARGB(255, 117, 72, 4),
                          icon: const CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildDiscount(ProductModel model, int index) {
    return model.data!.products![index].price !=
            model.data!.products![index].oldPrice
        ? Container(
            color: Colors.red,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 3,
            ),
            child: const Text(
              'DISCOUNT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.0,
              ),
            ),
          )
        : const Text('');
  }

  Widget buildCategoriesItem({required CategoriesModel model}) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 100,
            width: 100,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image(
                  height: 100,
                  width: 100,
                  image:
                      NetworkImage(model.data!.data![index].image.toString()),
                ),
                Container(
                  width: double.infinity,
                  height: 25,
                  color: Colors.black.withOpacity(0.7),
                  child: Text(
                    model.data!.data![index].name.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 8,
          );
        },
        itemCount: model.data!.data!.length,
      ),
    );
  }

  Widget builderCarouselSlider({required ProductModel model}) {
    return CarouselSlider(
      items: model.data!.banners!.map((e) {
        return Image.network(
          '${e.image}',
          fit: BoxFit.cover,
          width: double.infinity,
        );
      }).toList(),
      options: CarouselOptions(
        height: 200,
        viewportFraction: 1.0,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 900),
        autoPlayCurve: Curves.easeInOut,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
