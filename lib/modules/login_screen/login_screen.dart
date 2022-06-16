import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/layout/home_screen/home_%20screen.dart';
import 'package:news_app/layout/layout_screen.dart';
import 'package:news_app/modules/Login_screen/Login_cubit.dart';
import 'package:news_app/modules/login_screen/login_states.dart';
import 'package:news_app/modules/register_screen/register_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/network/local/chache%20_helper.dart';

class LoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginScreenCubit(),
      child: BlocConsumer<LoginScreenCubit, LoginScreenStates>(
        listener: (context, state) {
          if(state is LoginScreenSuccessState){
            if(state.loginModel!.status!){
              CacheHelper.setData(key: 'token', value: state.loginModel!.data!.token).then((value)
              => navigateAndReplaceTo(context, const HomeScreen()));

              showToast(msg: state.loginModel?.message, state: ToastStates.success);
            }
            else{
              print(state.loginModel?.message);
              showToast(msg: state.loginModel?.message, state: ToastStates.error);
            }

          }

        },
        builder: (context, state) {
          var key = GlobalKey<FormState>();
          var cubit = LoginScreenCubit.get(context);
          return Scaffold(
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
                          'Login',
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900]
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Login now to see our hot offers',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey
                          ),
                        ),
                        const SizedBox(
                          height: 25,
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
                          suffixButtonFunction: (){cubit.changePasswordVisibility();}
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginScreenLoadingState,
                          builder: (BuildContext context) {return defaultButton(
                              function: (){
                                if(key.currentState!.validate()){
                                  cubit.userLogin(email: emailController.text, password: passwordController.text);
                                }
                              },
                              text: 'Login');},
                          fallback: (BuildContext context) {return const Center(child: CircularProgressIndicator());},
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                color: Colors.grey
                              ),

                            ),
                            TextButton(
                              onPressed: (){
                                navigateTo(context, const RegisterScreen());
                              },
                              child: const Text(
                                'Register Now',
                                style: TextStyle(
                                  color: Colors.blue
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
