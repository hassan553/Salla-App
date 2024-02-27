import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store_app/core/functions/navigation.dart';
import '../view_model/auth/auth_cubit.dart';
import 'home_view_page.dart';
import 'widgets/custom_textField.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthRegisterSuccessState) {
          Fluttertoast.showToast(
              msg: state.userModel.message.toString(),
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          navigateOff(context, const HomePageView());
        } else if (state is AuthRegisterErrorState) {
          Fluttertoast.showToast(
              msg: state.error.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Register To Salla App ',
                        style: TextStyle(
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
                            BuildTextField(
                              valid: (value) {
                                if (value!.isEmpty) {
                                  return 'no valid empty value';
                                }
                              },
                              controller: nameController,
                              hint: 'Enter your name ',
                              keyboard: TextInputType.name,
                              prefix: null,
                            ),
                            const SizedBox(height: 20.0),
                            BuildTextField(
                              valid: (value) {
                                if (value!.isEmpty) {
                                  return 'no valid empty value';
                                }
                              },
                              controller: phoneController,
                              hint: 'Enter your phone ',
                              keyboard: TextInputType.number,
                              prefix: null,
                            ),
                            const SizedBox(height: 20.0),
                            BuildTextField(
                              valid: (value) {
                                if (value!.isEmpty) {
                                  return 'no valid empty value';
                                }
                              },
                              controller: emailController,
                              hint: 'Enter your email ',
                              keyboard: TextInputType.emailAddress,
                              prefix: null,
                            ),
                            const SizedBox(height: 20.0),
                            BuildTextField(
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
                            const SizedBox(height: 20),
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
                                      cubit.userRegister(
                                        email: emailController.text,
                                        name: nameController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                      );
                                    }
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: const Text(
                                      'Register',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
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
