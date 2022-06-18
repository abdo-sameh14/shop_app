import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/home_screen/home_cubit.dart';
import 'package:news_app/layout/home_screen/home_states.dart';
import 'package:news_app/shared/styles/colors.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../login_screen/login_screen.dart';


class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeScreenCubit.get(context).profileDataModel!;
        nameController.text = cubit.data!.name!;
        emailController.text = cubit.data!.email!;
        phoneController.text = cubit.data!.phone!;
        List<ListTile> userData = [
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(nameController.text),
            subtitle: const Text('Name'),
            style: ListTileStyle.drawer,

          ),
        ];
        return ConditionalBuilder(
          condition: cubit != null ,
          builder: (context) => Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        leading: const Icon(Icons.account_circle_rounded,
                        size: 35,),
                        textColor: defaultColor,
                        title: const Text(
                          'User Info',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20
                          ),
                        ),
                        children: [
                          mySeparator(),
                          ListTile(
                            leading: const Icon(
                              Icons.abc_outlined,
                              color: defaultColor,
                              size: 26,
                            ),
                            title: Text(
                              nameController.text,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18
                              ),
                            ),
                            subtitle: const Text('Name',
                              style: TextStyle(
                                  color: defaultColor
                              ),
                            ),
                          ),
                          mySeparator(),
                          ListTile(

                            leading: const Icon(
                              Icons.email_outlined,
                              color: defaultColor,
                              size: 26,
                            ),
                            title: Text(
                            emailController.text,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18
                              ),
                            ),
                            subtitle: const Text('Email',
                              style: TextStyle(
                                  color: defaultColor
                              ),
                            ),
                          ),
                          mySeparator(),
                          ListTile(
                            leading: const Icon(
                              Icons.phone,
                              color: defaultColor,
                              size: 26,
                            ),
                            title: Text(
                              phoneController.text,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18
                              ),
                            ),
                            subtitle: const Text('Phone',
                              style: TextStyle(
                                  color: defaultColor
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(function: ()
                  {
                    signOut(context, loginScreen: LoginScreen());
                  },
                    text: 'logout'.toUpperCase(),
                    backgroundColor: Colors.red,

                  ),
                ]
                  // Column(
                  //   children: [
                  //
                  //     defaultButton(function: (){
                  //       signOut(context, loginScreen: LoginScreen());
                  //     }, text: 'logout'.toUpperCase())
                  //   ],
                  // ),
                // ,
              ),
            ),
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}

// defaultTextFormField(
// label: 'Name',
// type: TextInputType.name,
// controller: nameController,
// validateReturn: 'Name Can\'t be empty!',
// prefix: Icons.person),
// const SizedBox(
// height: 20,
// ),
// defaultTextFormField(
// label: 'Email',
// type: TextInputType.emailAddress,
// controller: emailController,
// validateReturn: 'Email Can\'t be empty!',
// prefix: Icons.email_outlined),
// const SizedBox(
// height: 20,
// ),
// defaultTextFormField(
// label: 'Phone',
// type: TextInputType.phone,
// controller: phoneController,
// validateReturn: 'Phone Can\'t be empty!',
// prefix: Icons.phone),
// const SizedBox(
// height: 20,
// ),
