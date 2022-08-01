import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/core/view_models/products_view_models/products_cubit.dart';
import 'package:store_app/ui/views/home_view_page.dart';

import '../../widgets/widgets.dart';

class RegisterView extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProductsCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(
                10,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Register To Salla App ',
                        style: GoogleFonts.abel(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            buildTextField(
                              valid: (value) {
                                if (value!.isEmpty) {
                                  return 'no valid empty value';
                                }
                              },
                              controller: nameController,
                              hint: 'Enter your name ',
                              keyboard: TextInputType.name,
                            ),
                            const SizedBox(height: 20.0),
                            buildTextField(
                              valid: (value) {
                                if (value!.isEmpty) {
                                  return 'no valid empty value';
                                }
                              },
                              controller: phoneController,
                              hint: 'Enter your phone ',
                              keyboard: TextInputType.number,
                            ),
                            const SizedBox(height: 20.0),
                            buildTextField(
                              valid: (value) {
                                if (value!.isEmpty) {
                                  return 'no valid empty value';
                                }
                              },
                              controller: emailController,
                              hint: 'Enter your email ',
                              keyboard: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 20.0),
                            buildTextField(
                              obscure: cubit.obscure,
                              prefix: IconButton(
                                onPressed: () {
                                  cubit.changePasswordIcon();
                                },
                                icon: cubit.obscure == true
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                              ),
                              valid: (value) {
                                if (value!.isEmpty) {
                                  return 'no valid empty value';
                                }
                              },
                              controller: passwordController,
                              hint: 'Enter your password ',
                              keyboard: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ConditionalBuilder(
                              fallback: (context) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.blue,
                                  ),
                                );
                              },
                              condition: true,
                              builder: (context) {
                                return InkWell(
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      print('done');
                                      cubit.fatchUserRegister(
                                        email: emailController.text,
                                        name: nameController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                      );
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return HomePageView();
                                      }));
                                    }
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                          20,
                                        ),
                                        bottomRight: Radius.circular(
                                          20,
                                        ),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    child: Text(
                                      'Register',
                                      style: GoogleFonts.abel(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
