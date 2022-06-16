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
                  child: buildFavItem(cubit![index]!.product!, context)),
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


Widget buildFavItem(Product model, context){
  var cubit = HomeScreenCubit.get(context);
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: SizedBox(
      height: 120,
      // width: double.infinity,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.end,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 120,
            height: 120,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                    image: NetworkImage(
                      model.image!,
                    ),
                    // fit: BoxFit.cover,
                    // width: double.infinity,
                    // height: 200,
                    // width: 120,
                  ),
                if (model.discount! > 0) Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.red.withOpacity(0.9),
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white
                    ),

                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      height: 1.3,
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      model.price.toString(),
                      style: const TextStyle(
                        color: defaultColor,
                        fontSize: 14,
                        // fontWeight: FontWeight.w500
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (1 > 0) Text(
                      model.oldPrice.toString(),
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    const Spacer(),
                    CircleAvatar(
                      backgroundColor: cubit.favourites[model.id]! ? defaultColor : Colors.grey,
                      child: IconButton(onPressed: (){
                        cubit.userFavourites(model.id);
                        // print(model.id);
                        // print(model.inFavorites);
                      },
                        iconSize: 18,
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          // size: 20,
                        ),
                        // padding: EdgeInsets.all(0),
                      ),
                    )

                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    ),
  );
}