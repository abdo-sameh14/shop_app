import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/settings_screen/settings_screen.dart';
import 'package:news_app/shared/network/local/chache%20_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopAppStates> {
  ShopCubit() : super(ShopAppInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screen = [
    // const BusinessScreen(),
    // const SportsScreen(),
    // const ScienceScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> botNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business'
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    // const BottomNavigationBarItem(
    //   icon: Icon(Icons.settings),
    //   label: 'Settings',
    // ),
  ];

  void changeBotNavBarIndex(index){
    currentIndex = index;
    if (index == 1){
      getSports();
    }
    if (index == 2){
      getScience();
    }
    emit(ShopAppBotNavState());
  }

  List business = [];

  void getBusiness(){
    emit(ShopGetBusinessLoadingState());

    if (business.isEmpty){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'business',
            'apiKey':'ab4556f7a2b24bfd8da4080aef8a74d8',
          }).then((value) {
        business = value.data['articles'];
        emit(ShopGetBusinessSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(ShopGetBusinessErrorState(error.toString()));
      });
    }
    else {
      emit(ShopGetBusinessSuccessState());
    }
  }

  List sports = [];

  void getSports(){
    emit(ShopGetSportsLoadingState());

    if(sports.isEmpty){DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apiKey':'ab4556f7a2b24bfd8da4080aef8a74d8',
        }).then((value) {
      sports = value.data['articles'];
      emit(ShopGetSportsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopGetSportsErrorState(error.toString()));
    },
    );
    }
    else{emit(ShopGetSportsSuccessState());}

  }

  List science = [];

  void getScience(){
    emit(ShopGetScienceLoadingState());
    if(science.isEmpty){DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apiKey':'ab4556f7a2b24bfd8da4080aef8a74d8',
        }).then((value) {
      science = value.data['articles'];
      emit(ShopGetScienceSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopGetScienceErrorState(error.toString()));
    });}
    else{emit(ShopGetScienceSuccessState());}
  }

  bool darkMode = false;

  void toggleDarkMode({bool? fromShared}){
    if(fromShared != null){
      darkMode = fromShared;
      emit(ShopChangeThemeModeState());
    }
    else {
      darkMode = !darkMode;
      CacheHelper?.setBool(key: 'isDark', value: darkMode);
      emit(ShopChangeThemeModeState());
    }

  }

  List search = [];

  void getSearch(String value){
    search = [];
    emit(ShopGetSearchLoadingState());

    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':value,
          'apiKey':'ab4556f7a2b24bfd8da4080aef8a74d8',
        }).then((value) {
      search = value.data['articles'];
      emit(ShopGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetSearchErrorState(error.toString()));
    });
  }
}