import 'package:news_app/layout/home_screen/home_%20screen.dart';
import 'package:news_app/layout/home_screen/home_states.dart';
import 'package:news_app/modules/Login_screen/Login_cubit.dart';
import 'package:news_app/layout/home_screen/home_cubit.dart';
import 'package:news_app/modules/login_screen/login_screen.dart';
import 'package:news_app/modules/onBoarding_screen/onBoarding_screen.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/layout/layout_screen.dart';
import 'package:news_app/shared/network/local/chache%20_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import 'shared/styles/bloc_observer.dart';

void main(context) async {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      // final prefs = await SharedPreferences.getInstance();
      // show = prefs.getBool('INTRODUCTION') ?? true;
      DioHelper.init();
      await CacheHelper.init();
      final bool? isDark = CacheHelper?.getBool(key: 'isDark');
      bool? onBoarding = CacheHelper?.getData(key: 'onBoarding') ?? false;
      token = CacheHelper?.getData(key: 'token');

      final Widget widget;
      if(onBoarding!){
        if(token != null){
          widget = const HomeScreen();
        }else{
          widget = LoginScreen();
        }
      }else{
        widget = OnBoardingScreen();
      }
      print('onBoarding = $onBoarding');
      runApp(MyApp(
        isDark: isDark,
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;
  MyApp({this.isDark, this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => HomeScreenCubit()..getHomeData()..getCategoryData(),
        ),
        BlocProvider(
          create: (BuildContext context) => LoginScreenCubit()
        ),
      ],
      child: BlocConsumer<HomeScreenCubit, HomeScreenStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          // bool darkModeOn = ShopCubit.get(context).darkMode;
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.light,
              home: startWidget
              // onBoarding! ? LoginScreen() : OnBoardingScreen()
              //     if(onBoarding = null || onBoarding = true){
              //     return OnBoardingScreen();
              // }
              // else{
              //   return LoginnScreen();
              // }
              // onBoarding! ? OnBoardingScreen() : LoginScreen()
              // const ShopLayoutScreen(),
              );
        },
      ),
    );
  }
}
