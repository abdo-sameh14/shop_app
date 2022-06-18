import 'package:news_app/models/categories_model/categories_model.dart';
import 'package:news_app/models/favourites_model/favourites_model.dart';
import 'package:news_app/models/favourites_model/get_fav_model.dart';
import 'package:news_app/models/home_model/home_model.dart';
import 'package:news_app/models/login_model/login_model.dart';

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

class FavouriteScreenSuccessState extends HomeScreenStates {

  final FavouritesModel? favouritesModel;


  FavouriteScreenSuccessState (this.favouritesModel);
}

class FavouriteScreenState extends HomeScreenStates {

  final FavouritesModel? favouritesModel;


  FavouriteScreenState (this.favouritesModel);
}

class FavouriteScreenFalseState extends HomeScreenStates {

  final FavouritesModel? favouritesModel;


  FavouriteScreenFalseState (this.favouritesModel);
}

class FavouriteScreenErrorState extends HomeScreenStates {

  String error;
  FavouriteScreenErrorState(this.error);
}

class GetFavouritesLoadingState extends HomeScreenStates {

}

class GetFavouritesSuccessState extends HomeScreenStates {

  final GetFavouriteModel? getFavouriteModel;


  GetFavouritesSuccessState (this.getFavouriteModel);
}

class GetFavouritesErrorState extends HomeScreenStates {

  String error;
  GetFavouritesErrorState(this.error);
}

class GetProfileDataLoadingState extends HomeScreenStates {

}

class GetProfileDataSuccessState extends HomeScreenStates {

  final ShopLoginModel? profileData;


  GetProfileDataSuccessState (this.profileData);
}

class GetProfileDataErrorState extends HomeScreenStates {

  String error;
  GetProfileDataErrorState(this.error);
}

class UpdateProfileDataLoadingState extends HomeScreenStates {

}

class UpdateProfileDataSuccessState extends HomeScreenStates {

  final ShopLoginModel? profileData;


  UpdateProfileDataSuccessState (this.profileData);
}

class UpdateProfileDataErrorState extends HomeScreenStates {

  String error;
  UpdateProfileDataErrorState(this.error);
}

class HomeScreenChangeBotNavBar extends HomeScreenStates{}