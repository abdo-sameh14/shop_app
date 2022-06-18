import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/home_screen/home_cubit.dart';
import 'package:news_app/layout/home_screen/home_states.dart';
import 'package:news_app/shared/styles/colors.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../login_screen/login_screen.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeScreenCubit.get(context);
        var key = GlobalKey<FormState>();
        nameController.text = cubit.profileDataModel!.data!.name!;
        emailController.text = cubit.profileDataModel!.data!.email!;
        phoneController.text = cubit.profileDataModel!.data!.phone!;
        return ConditionalBuilder(
          condition: cubit.profileDataModel != null,
          builder: (context) => Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Edit Profile'),
            ),
            body: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: key,
                    child: Column(
                        children: [
                          if(state is UpdateProfileDataLoadingState)
                            const LinearProgressIndicator(),
                          const SizedBox(
                            height: 20,
                          ),
                              defaultTextFormField(
                              label: 'Name',
                              type: TextInputType.name,
                              controller: nameController,
                              validateReturn: 'Name Can\'t be empty!',
                              prefix: Icons.person),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultTextFormField(
                              label: 'Email',
                              type: TextInputType.emailAddress,
                              controller: emailController,
                              validateReturn: 'Email Can\'t be empty!',
                              prefix: Icons.email_outlined),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultTextFormField(
                              label: 'Phone',
                              type: TextInputType.phone,
                              controller: phoneController,
                              validateReturn: 'Phone Can\'t be empty!',
                              prefix: Icons.phone),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultButton(function: ()
                          {
                            if(key.currentState!.validate()){
                            cubit.updateProfileData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text
                            );}
                            // print(nameController.text);
                          },
                            text: 'Save'.toUpperCase(),
                            backgroundColor: defaultColor,
                          ),
                        ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
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
