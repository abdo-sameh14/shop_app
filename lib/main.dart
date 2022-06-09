import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:news_app/moduels/onBoarding_screen/onBoarding_screen.dart';
import 'package:news_app/shared/styles/themes.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/layout/layout_screen.dart';
import 'package:news_app/shared/network/local/chache%20_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import 'shared/styles/bloc_observer.dart';

void main() async {
  BlocOverrides.runZoned(
        () async {
      WidgetsFlutterBinding.ensureInitialized();
      // final prefs = await SharedPreferences.getInstance();
      // show = prefs.getBool('INTRODUCTION') ?? true;
          DioHelper.init();
          await CacheHelper.init();
          final bool? isDark = CacheHelper?.getBool(key: 'isDark');
          runApp(MyApp(isDark));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {

  final bool? isDark;
  const MyApp(this.isDark, {Key? key}) : super(key: key);


   // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..getBusiness()..toggleDarkMode(
        fromShared: isDark
      ),
      child: BlocConsumer<ShopCubit, ShopAppStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
          bool darkModeOn = ShopCubit.get(context).darkMode;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: onBoardingScreen()
            // const ShopLayoutScreen(),
          );
        },
      ),
    );
  }
}

