import 'package:news_app/models/search_model/search_model.dart';

abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {
  SearchModel? model;

  SearchSuccessState(this.model);
}

class SearchErrorState extends SearchStates {

  String error;
  SearchErrorState(this.error);
}