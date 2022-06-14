import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/home_screen/home_cubit.dart';
import 'package:news_app/layout/home_screen/home_states.dart';
import 'package:news_app/models/categories_model/categories_model.dart';
import 'package:news_app/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenStates>(
      listener: (context, state){},
      builder: (context, state) {
        var cubit = HomeScreenCubit.get(context).categoryModel;
        return Scaffold(
            body: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => categoriesItemBuilder(cubit!.data!.data[index]!),
                separatorBuilder: (context, index) => mySeparator(),
                itemCount: cubit!.data!.data.length)
        );
      },
    );
  }

  Widget categoriesItemBuilder(CategoryDataList model){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children:  [
          Image(image:
          NetworkImage(
            model.image,
          ),
            height: 100,
            width: 100,
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              model.name.toUpperCase(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // const Spacer(),
          const Icon(Icons.arrow_forward_ios_rounded)
        ],
      ),
    );
  }
}
