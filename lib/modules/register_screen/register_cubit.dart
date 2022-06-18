import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/login_model/login_model.dart';
import 'package:news_app/modules/register_screen/register_states.dart';
import 'package:news_app/shared/network/end_points.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import '../../models/login_model/login_model.dart';

class RegisterScreenCubit extends Cubit<RegisterScreenStates> {
  RegisterScreenCubit() : super(RegisterScreenInitialState());

  static RegisterScreenCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? registerModel;

  void userRegister({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
  }){
    emit(RegisterScreenLoadingState());
    DioHelper.postData(url: register, data: {
      'name' : '$firstName $lastName',
      'email' : email,
      'password' : password,
      'phone' : phone
    },
      lang: 'en'
    ).then((value) {
      print(value.data);
      registerModel = ShopLoginModel.fromJson(value.data);
      emit(RegisterScreenSuccessState(registerModel));
    }).catchError((error){
      print(error.toString());
      emit(RegisterScreenErrorState(error.toString()));
    });
  }


  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility(){
    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(RegisterScreenChangePasswordVisibility());
  }

  // bool onBoarding = true;

  // void submit(context){
  //   CacheHelper.setData(key: 'onBoarding', value: false).then((value) {
  //     print(value);
  //     onBoarding = value!;
  //     if (onBoarding = false){
  //       navigateAndReplaceTo(context, RegisterScreen());
  //     }
  //   });
  // }

}