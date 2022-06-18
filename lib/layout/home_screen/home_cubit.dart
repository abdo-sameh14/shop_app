import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/categories_model/categories_model.dart';
import 'package:news_app/models/favourites_model/favourites_model.dart';
import 'package:news_app/models/favourites_model/get_fav_model.dart';
import 'package:news_app/models/home_model/home_model.dart';
import 'package:news_app/models/login_model/login_model.dart';
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

  Map<int?, bool?> favourites = {};

  HomeModel? homeModel;

  void getHomeData(){
    emit(HomeScreenLoadingState());
    DioHelper.getData(url: home, lang: 'en', token: token).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);

      for (var element in homeModel!.data!.products) {
        favourites.addAll({
          element?.id: element?.inFavorites
        });
      }
      // printFullText(homeModel!.data!.products[0]!.name.toString());
      // printFullText(homeModel!.data!.banners[0]!.image.toString());

      print(favourites.toString());

      emit(HomeScreenSuccessState(homeModel));
    }).catchError((error){
      print(error.toString());
      emit(HomeScreenErrorState(error.toString()));
    });
  }

  ShopLoginModel?  profileDataModel;

  void getProfileData(){
    emit(GetProfileDataLoadingState());
    DioHelper.getData(url: profile, lang: 'en', token: token).then((value)
    {
      profileDataModel = ShopLoginModel.fromJson(value.data);
      emit(GetProfileDataSuccessState(profileDataModel));
    }).catchError((error){
      print(error.toString());
      emit(GetProfileDataErrorState(error.toString()));
    });
  }

  void updateProfileData({
    required String name,
    required String email,
    required String phone,

  }){
    emit(UpdateProfileDataLoadingState());
    DioHelper.putData(
        url: updateProfile,
        lang: 'en',
        token: token,
        data: {
          'name' : name,
          'email' : email,
          'phone' : phone,
        }).then((value)
    {
      profileDataModel = ShopLoginModel.fromJson(value.data);
      profileDataModel?.data?.name = name;
      profileDataModel?.data?.email = email;
      profileDataModel?.data?.phone = phone;
      emit(UpdateProfileDataSuccessState(profileDataModel));
    }).catchError((error){
      print(error.toString());
      emit(UpdateProfileDataErrorState(error.toString()));
    });
  }

  CategoryModel? categoryModel;

  void getCategoryData(){
    DioHelper.getData(url: categories, lang: 'en').then((value)
    {
      categoryModel = CategoryModel.fromJson(value.data);


      emit(CategoryScreenSuccessState(categoryModel));
    }).catchError((error){
      print(error.toString());
      emit(CategoryScreenErrorState(error.toString()));
    });
  }

  GetFavouriteModel? getFavouriteModel;

  void getFavData(){
    emit(GetFavouritesLoadingState());
    DioHelper.getData(
      url: favs,
      lang: 'en',
      token: token
    ).then((value)
    {
      getFavouriteModel = GetFavouriteModel.fromJson(value.data);
      emit(GetFavouritesSuccessState(getFavouriteModel));
    }).catchError((error){
      print(error.toString());
      emit(GetFavouritesErrorState(error.toString()));
    });
  }

  FavouritesModel? favouritesModel;

  void userFavourites(int? productId){
    favourites[productId] = !favourites[productId]!;
    emit(FavouriteScreenState(favouritesModel));
    
    DioHelper.postData(url: favs,
        data:
        {
          'product_id': productId,
        },
        token: token,
        lang: 'en'
    ).then((value) {
      // print(Authorization)
      favouritesModel = FavouritesModel.fromJson(value.data);
      // printFullText(favouritesModel!.status!.toString());
      if(!favouritesModel!.status!){
        favourites[productId] = !favourites[productId]!;
        emit(FavouriteScreenFalseState(favouritesModel));
      }else{
        getFavData();
        emit(FavouriteScreenSuccessState(favouritesModel));
      }

    }).catchError((error){
      favourites[productId] = !favourites[productId]!;
      print(error.toString());
      emit(FavouriteScreenErrorState(error.toString()));
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
    SettingsScreen(),
  ];
  
}