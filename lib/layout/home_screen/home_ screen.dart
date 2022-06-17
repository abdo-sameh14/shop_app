import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/home_screen/home_cubit.dart';
import 'package:news_app/layout/home_screen/home_states.dart';
import 'package:news_app/modules/search_screen/search_screen.dart';
import 'package:news_app/modules/login_screen/login_screen.dart';
import 'package:news_app/modules/onBoarding_screen/onBoarding_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/network/local/chache%20_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenStates>(
      listener: (context, state){},
      builder: (context, state){
        var cubit = HomeScreenCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Salla'.toUpperCase(),
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
              ),
            ),
            actions: [
              IconButton(
                onPressed: (){
                  navigateTo(context, OnBoardingScreen());
                },
                icon: const Icon(Icons.info_outline_rounded),
              ),
              IconButton(
                onPressed: (){
                  navigateTo(context, const SearchScreen());
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBotNavBar(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  label: 'Categories'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favourites'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings'
              ),
            ],
          ),
          body: cubit.navBarScreens[cubit.currentIndex],
        );
      },
    );
  }
}
