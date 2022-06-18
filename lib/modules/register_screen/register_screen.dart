import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/layout/home_screen/home_%20screen.dart';
import 'package:news_app/layout/home_screen/home_cubit.dart';
import 'package:news_app/layout/layout_screen.dart';
import 'package:news_app/modules/Register_screen/Register_cubit.dart';
import 'package:news_app/modules/register_screen/register_states.dart';
import 'package:news_app/modules/register_screen/register_screen.dart';
import 'package:news_app/modules/register_screen/register_states.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/network/local/chache%20_helper.dart';

class RegisterScreen extends StatelessWidget {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterScreenCubit, RegisterScreenStates>(
        listener: (context, state) {
          if (state is RegisterScreenSuccessState) {
            if (state.registerModel!.status!) {
              CacheHelper.setData(
                      key: 'token', value: state.registerModel!.data!.token)
                  .then((value) {
                token = state.registerModel!.data!.token;
                HomeScreenCubit.get(context).currentIndex = 0;
                HomeScreenCubit.get(context).getProfileData();
                navigateAndReplaceTo(context, const HomeScreen());
              });

              showToast(
                  msg: state.registerModel?.message,
                  state: ToastStates.success);
            } else {
              // print(state.registerModel?.message);
              showToast(
                  msg: state.registerModel?.message, state: ToastStates.error);
            }
          }
        },
        builder: (context, state) {
          var key = GlobalKey<FormState>();
          var cubit = RegisterScreenCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: key,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900]),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Register now to see our hot offers',
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: defaultTextFormField(
                                label: 'First Name',
                                type: TextInputType.name,
                                controller: firstNameController,
                                validateReturn: 'Please enter your name',
                                prefix: Icons.person,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: defaultTextFormField(
                                label: 'Last Name',
                                type: TextInputType.name,
                                controller: lastNameController,
                                validateReturn: 'Please enter your name',
                                prefix: Icons.person,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                          label: 'Email Address',
                          type: TextInputType.emailAddress,
                          controller: emailController,
                          validateReturn: 'Please enter your mail address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                            isPassword: cubit.isPassword,
                            label: 'Password',
                            type: TextInputType.visiblePassword,
                            controller: passwordController,
                            validateReturn: 'Password is too short!',
                            prefix: Icons.lock_outline,
                            suffix: cubit.suffix,
                            suffixButtonFunction: () {
                              cubit.changePasswordVisibility();
                            }),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                          label: 'Phone',
                          type: TextInputType.phone,
                          controller: phoneController,
                          validateReturn: 'Please enter your phone number',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterScreenLoadingState,
                          builder: (BuildContext context) {
                            return defaultButton(
                                function: () {
                                  if (key.currentState!.validate()) {
                                    cubit.userRegister(
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text
                                    );
                                  }
                                },
                                text: 'Register');
                          },
                          fallback: (BuildContext context) {
                            return const Center(
                                child: CircularProgressIndicator());
                          },
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
