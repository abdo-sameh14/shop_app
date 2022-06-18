import 'package:news_app/models/login_model/login_model.dart';

abstract class RegisterScreenStates {}

class RegisterScreenInitialState extends RegisterScreenStates {}

class RegisterScreenLoadingState extends RegisterScreenStates {}

class RegisterScreenSuccessState extends RegisterScreenStates {

  final ShopLoginModel? registerModel;


  RegisterScreenSuccessState(this.registerModel);}

class RegisterScreenErrorState extends RegisterScreenStates {

  String error;
  RegisterScreenErrorState(this.error);
}

class RegisterScreenChangePasswordVisibility extends RegisterScreenStates{}