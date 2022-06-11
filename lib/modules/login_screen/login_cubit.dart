import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/login_model/login_model.dart';
import 'package:news_app/modules/login_screen/login_screen.dart';
import 'package:news_app/modules/login_screen/login_states.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/network/end_points.dart';
import 'package:news_app/shared/network/local/chache%20_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class LoginScreenCubit extends Cubit<LoginScreenStates> {
  LoginScreenCubit() : super(LoginScreenInitialState());

  static LoginScreenCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password
}){
    emit(LoginScreenLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email' : email,
      'password' : password
    },
      // lang: 'en'
    ).then((value) {
      // print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(LoginScreenSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(LoginScreenErrorState(error.toString()));
    });
  }


  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility(){
    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(LoginScreenChangePasswordVisibility());
  }

  // bool onBoarding = true;

  // void submit(context){
  //   CacheHelper.setData(key: 'onBoarding', value: false).then((value) {
  //     print(value);
  //     onBoarding = value!;
  //     if (onBoarding = false){
  //       navigateAndReplaceTo(context, LoginScreen());
  //     }
  //   });
  // }

}