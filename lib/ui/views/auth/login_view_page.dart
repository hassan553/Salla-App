import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/core/view_models/products_view_models/products_cubit.dart';
import 'package:store_app/ui/views/home_view_page.dart';

import '../../widgets/widgets.dart';

class LoginView extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
        listener: (context, state) {
      if (state is LoginSuccesfullyState) {
        if (state.data.status!) {
          Fluttertoast.showToast(
            msg: state.data.message!.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          Fluttertoast.showToast(
            msg: state.data.message!.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      }
    }, builder: (context, state) {
      var cubit = ProductsCubit.get(context);
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(
              10,
            ),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
                    Text(
                      'Login now to connect to all our offers ',
                      style: GoogleFonts.alata(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
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
                            controller: emailController,
                            hint: 'Enter your email ',
                            keyboard: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .03,
                          ),
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .03,
                          ),
                          ConditionalBuilder(
                            fallback: (context) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                              );
                            },
                            condition: state is! LoginLoadingState,
                            builder: (context) {
                              return InkWell(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.fetchUserLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );

                                    print('done');
                                  }
                                  if (state is LoginSuccesfullyState) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return HomePageView();
                                        },
                                      ),
                                    );
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
                                    'Login',
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .01,
                          ),
                          Row(
                            children: [
                              Text(
                                'if you don\'t have account ?',
                                style: GoogleFonts.abel(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Expanded(
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Register now',
                                    style: GoogleFonts.abel(
                                      fontSize: 17,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
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
    });
  }
}
