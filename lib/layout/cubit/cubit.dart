import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/moduels/business_screen/business_screen.dart';
import 'package:news_app/moduels/science_screen/science_screen.dart';
import 'package:news_app/moduels/settings_screen/settings_screen.dart';
import 'package:news_app/moduels/sports_screen/sports.dart';
import 'package:news_app/shared/network/local/chache%20_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsAppStates> {
  NewsCubit() : super(NewsAppInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screen = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
    const SettingsScreen(),
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
    emit(NewsAppBotNavState());
  }

  List business = [];

  void getBusiness(){
    emit(NewsGetBusinessLoadingState());

    if (business.isEmpty){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'business',
            'apiKey':'ab4556f7a2b24bfd8da4080aef8a74d8',
          }).then((value) {
        business = value.data['articles'];
        emit(NewsGetBusinessSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    }
    else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  List sports = [];

  void getSports(){
    emit(NewsGetSportsLoadingState());

    if(sports.isEmpty){DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apiKey':'ab4556f7a2b24bfd8da4080aef8a74d8',
        }).then((value) {
      sports = value.data['articles'];
      emit(NewsGetSportsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    },
    );
    }
    else{emit(NewsGetSportsSuccessState());}

  }

  List science = [];

  void getScience(){
    emit(NewsGetScienceLoadingState());
    if(science.isEmpty){DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apiKey':'ab4556f7a2b24bfd8da4080aef8a74d8',
        }).then((value) {
      science = value.data['articles'];
      emit(NewsGetScienceSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });}
    else{emit(NewsGetScienceSuccessState());}
  }

  bool darkMode = false;

  void toggleDarkMode({bool? fromShared}){
    if(fromShared != null){
      darkMode = fromShared;
      emit(NewsChangeThemeModeState());
    }
    else {
      darkMode = !darkMode;
      CacheHelper?.setBool(key: 'isDark', value: darkMode);
      emit(NewsChangeThemeModeState());
    }

  }

  List search = [];

  void getSearch(String value){
    search = [];
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':value,
          'apiKey':'ab4556f7a2b24bfd8da4080aef8a74d8',
        }).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}