import 'package:news_app/models/categories_model/categories_model.dart';
import 'package:news_app/models/home_model/home_model.dart';

abstract class HomeScreenStates {}

class HomeScreenInitialState extends HomeScreenStates {}

class HomeScreenLoadingState extends HomeScreenStates {}

class HomeScreenSuccessState extends HomeScreenStates {

  final HomeModel? homeDataModel;


  HomeScreenSuccessState(this.homeDataModel);}

class HomeScreenErrorState extends HomeScreenStates {

  String error;
  HomeScreenErrorState(this.error);
}

class CategoryScreenSuccessState extends HomeScreenStates {

  final CategoryModel? categoryModel;


  CategoryScreenSuccessState(this.categoryModel);}

class CategoryScreenErrorState extends HomeScreenStates {

  String error;
  CategoryScreenErrorState(this.error);
}

class HomeScreenChangeBotNavBar extends HomeScreenStates{}