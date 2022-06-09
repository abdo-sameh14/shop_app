import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // list = NewsCubit.get(context).search;

    return BlocConsumer<NewsCubit, NewsAppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = NewsCubit.get(context);
        var list = cubit.search;
        TextEditingController searchController = TextEditingController();
        var formKey = GlobalKey<FormState>();
        return Form(
          key: formKey,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: (){
                  list.clear();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back,),
              ),
              title: const Text('Search',)
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultTextFormField(
                    label: 'Search',
                    type: TextInputType.text,
                    controller: searchController,
                    validateReturn: 'This field can\'t be empty!',
                    prefix: Icons.search,
                    // onChangeFunction: (value){
                    //   cubit.getSearch(value);
                    // },
                    onSubmitted: (value){
                      if(formKey.currentState!.validate()){
                        cubit.getSearch(value);
                      }
                      else {
                        return;
                      }
                    },
                  ),
                ),
                Expanded(child: buildArticles(list, isSearch: true))
              ],
            ),
          ),
        );
      },

    );
  }
}
