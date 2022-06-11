import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/onBoarding_screen/onBoarding_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = ShopCubit.get(context).science;

        return AnimatedSplashScreen(
          splash: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset('assets/images/app-logo.png',
                  scale: 8,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Akhbarak',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(.87)
                  ),
                ),
                // SizedBox(
                //   height: 100,
                // ),
                const Spacer(),
                Image.asset('assets/images/logo.png',
                  width: 55,
                  height: 55,
                ),
              ],
            ),
          ),
          nextScreen:  OnBoardingScreen(),
          backgroundColor: const Color(0xff212121),
          // darkModeOn ? const Color(0xff212121) : Colors.white.withOpacity(.87),
          animationDuration: const Duration(seconds: 1),
          // splashTransition: SplashTransition.,
          // centered: true,
          pageTransitionType: PageTransitionType.fade,
          duration: 2000,
          splashIconSize: double.infinity,
        );
      },
    );
  }
}
