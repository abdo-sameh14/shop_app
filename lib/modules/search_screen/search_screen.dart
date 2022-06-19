import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/home_screen/home_cubit.dart';
import 'package:news_app/modules/search_screen/search_cubit/search_cubit.dart';
import 'package:news_app/modules/search_screen/search_cubit/search_states.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/styles/colors.dart';

import '../../layout/home_screen/home_states.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var key = GlobalKey<FormState>();
          var cubit = SearchCubit.get(context);
          late List list = cubit.model?.data?.data ?? [];
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back), onPressed: () {
                  list.clear();
                  Navigator.pop(context);
              },
              ),
              centerTitle: true,
              title: const Text('Search'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: key,
                child: Column(
                  children: [
                    defaultTextFormField(
                      label: 'Search',
                      type: TextInputType.text,
                      controller: searchController,
                      validateReturn: 'Please add the name of the product you want to search for',
                      prefix: Icons.search,
                      onSubmitted: (String text){
                        list.clear();
                        if(key.currentState!.validate()) {
                          cubit.search(text);
                        }
                        // print(cubit.model?.data.toString());
                        // printFullText(cubit.model.data.toString());
                      }
                    ),
                    // const SizedBox(
                    //   height: 1,
                    // ),
                    if(state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    if(state is SearchSuccessState)
                      Expanded(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildSearchItem(cubit.model!.data!.data[index], context),
                          separatorBuilder: (context, index) => mySeparator(),
                          itemCount: cubit.model!.data!.data.length),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSearchItem(model, context){
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
                  // if (model!.discount > 0 && !isSearch!) Container(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   color: Colors.red.withOpacity(0.9),
                  //   child: const Text(
                  //     'DISCOUNT',
                  //     style: TextStyle(
                  //         fontSize: 12,
                  //         color: Colors.white
                  //     ),
                  //
                  //   ),
                  // ),
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
                  const Spacer(),
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
                      // if (model!.discount > 0 && !isSearch!) Text(
                      //   model.oldPrice.toString(),
                      //   style: const TextStyle(
                      //       decoration: TextDecoration.lineThrough,
                      //       color: Colors.grey,
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.w500
                      //   ),
                      // ),
                      const Spacer(),
                      CircleAvatar(
                        backgroundColor: cubit.favourites[model.id]! ? defaultColor : Colors.grey,
                        child: IconButton(onPressed: (){
                          setState((){
                            cubit.userFavourites(model.id);
                          });

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
}
