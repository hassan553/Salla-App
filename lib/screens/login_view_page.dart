import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:store_app/core/functions/navigation.dart';
import 'package:store_app/screens/home_view_page.dart';
import 'package:store_app/screens/register_view_page.dart';
import 'package:store_app/view_model/auth/auth_cubit.dart';
import 'package:store_app/view_model/home/products_cubit.dart';
import 'widgets/custom_textField.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state is AuthLoginSuccessState) {
        if (state.userModel.status == true) {
          Fluttertoast.showToast(
              msg: state.userModel.message.toString(),
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          navigateOff(context, const HomePageView());
        } else if (state is AuthLoginErrorState) {
          Fluttertoast.showToast(
              msg: state.userModel.message.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    }, builder: (context, state) {
      var cubit = AuthCubit.get(context);
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * .05),
                    const Text(
                      'Login now to connect to all our offers ',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .05),
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
                              controller: emailController,
                              hint: 'Enter your email ',
                              keyboard: TextInputType.emailAddress,
                              prefix: null),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .03),
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
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .03),
                          ConditionalBuilder(
                            fallback: (context) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.blue));
                            },
                            condition: state is! LoginLoadingState,
                            builder: (context) {
                              return InkWell(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
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
                              height: MediaQuery.of(context).size.height * .01),
                          Row(
                            children: [
                              const Text(
                                'if you don\'t have account ?',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Expanded(
                                child: TextButton(
                                  onPressed: () =>
                                      navigateTo(context, const RegisterView()),
                                  child: const Text('Register now',
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis),
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
