import 'package:news_app/models/login_model/login_model.dart';

abstract class LoginScreenStates {}

class LoginScreenInitialState extends LoginScreenStates {}

class LoginScreenLoadingState extends LoginScreenStates {}

class LoginScreenSuccessState extends LoginScreenStates {

  final ShopLoginModel? loginModel;


  LoginScreenSuccessState(this.loginModel);}

class LoginScreenErrorState extends LoginScreenStates {

  String error;
  LoginScreenErrorState(this.error);
}

class LoginScreenChangePasswordVisibility extends LoginScreenStates{}