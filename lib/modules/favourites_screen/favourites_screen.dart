import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/favourites_model/get_fav_model.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/styles/colors.dart';

import '../../layout/home_screen/home_cubit.dart';
import '../../layout/home_screen/home_states.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenStates>(
      listener: (context, state) {
        if(state is FavouriteScreenFalseState){
          showToast(msg: state.favouritesModel?.message, state: ToastStates.error);
        }
        if(state is FavouriteScreenErrorState){
          showToast(msg: state.error.toString(), state: ToastStates.error);
        }
        if(state is FavouriteScreenSuccessState)
        {
          showToast(msg: state.favouritesModel?.message, state: ToastStates.success);
        }
      },
      builder: (context, state) {
        var cubit = HomeScreenCubit.get(context).getFavouriteModel?.data?.data;
        return ConditionalBuilder(
            condition: state is! GetFavouritesLoadingState,
            builder: (context) {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Container(
                  color: Colors.white,
                  child: buildProductItem(cubit![index]!.product!, context)),
                  separatorBuilder: (context, index) => mySeparator(),
                  itemCount: cubit!.length);
            },
            fallback: (context) {
              return const Center(child: CircularProgressIndicator());
            });
      },
    );
  }
}


