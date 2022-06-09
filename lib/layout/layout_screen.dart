import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/moduels/search_screen/search_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsLayoutScreen extends StatelessWidget {
  const NewsLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: const Text('News App'),
              actions: [
                IconButton(
                  onPressed: (){
                    navigateTo(context, const SearchScreen());
                  },
                  icon: const Icon(Icons.search),
                ),
                IconButton(
                  onPressed: (){
                    cubit.toggleDarkMode();
                  },
                  icon: const Icon(Icons.brightness_4_outlined),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBotNavBarIndex(index);
              },
              items: cubit.botNavBarItems,
            ),
          body: cubit.screen[cubit.currentIndex],
          );
      },
    );
  }
}
