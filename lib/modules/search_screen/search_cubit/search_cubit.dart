import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/home_screen/home_cubit.dart';
import 'package:news_app/models/search_model/search_model.dart';
import 'package:news_app/modules/search_screen/search_cubit/search_states.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import '../../../shared/network/end_points.dart';

class SearchCubit extends Cubit<SearchStates>{

  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text){
    emit(SearchLoadingState());
    DioHelper.postData(
      url: searchProduct,
      data: {
        'text' : text
      },
      token: token,
      lang: 'en'
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      print('name is: ${model!.data!.data[0]?.name!}');
      emit(SearchSuccessState(model));
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState(error.toString()));
    });

  }

}
