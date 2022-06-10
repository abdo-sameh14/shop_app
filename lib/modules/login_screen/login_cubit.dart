import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/login_screen/login_states.dart';
import 'package:news_app/shared/network/end_points.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class LoginScreenCubit extends Cubit<LoginScreenStates> {
  LoginScreenCubit() : super(LoginScreenInitialState());

  static LoginScreenCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password
}){
    emit(LoginScreenLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email' : email,
      'password' : password
    },
      lang: 'en'
    ).then((value) {
      print(value.data);
      emit(LoginScreenSuccessState());
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

}