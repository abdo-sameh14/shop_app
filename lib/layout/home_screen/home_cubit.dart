import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/categories_model/categories_model.dart';
import 'package:news_app/models/home_model/home_model.dart';
import 'package:news_app/modules/categories_screen/categories_screen.dart';
import 'package:news_app/modules/favourites_screen/favourites_screen.dart';
import 'package:news_app/modules/products_screen/product_screen.dart';
import 'package:news_app/modules/settings_screen/settings_screen.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/network/end_points.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import '../../layout/home_screen/home_states.dart';

class HomeScreenCubit extends Cubit<HomeScreenStates> {
  HomeScreenCubit() : super(HomeScreenInitialState());

  static HomeScreenCubit get(context) => BlocProvider.of(context);

  HomeModel? homeModel;

  void getHomeData(){
    emit(HomeScreenLoadingState());
    DioHelper.getData(url: HOME, lang: 'en', token: token).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);

      printFullText(homeModel!.data!.products[0]!.name.toString());
      printFullText(homeModel!.data!.banners[0]!.image.toString());


      emit(HomeScreenSuccessState(homeModel));
    }).catchError((error){
      print(error.toString());
      emit(HomeScreenErrorState(error.toString()));
    });
  }

  CategoryModel? categoryModel;

  void getCategoryData(){
    DioHelper.getData(url: CATEGORIES, lang: 'en').then((value)
    {
      categoryModel = CategoryModel.fromJson(value.data);


      emit(CategoryScreenSuccessState(categoryModel));
    }).catchError((error){
      print(error.toString());
      emit(CategoryScreenErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  void changeBotNavBar(int index){
    currentIndex = index;
    emit(HomeScreenChangeBotNavBar());
  }
  List<Widget> navBarScreens = [
    ProductScreen(),
    const CategoriesScreen(),
    const FavouritesScreen(),
    const SettingsScreen(),
  ];
  
}