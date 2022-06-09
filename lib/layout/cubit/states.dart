abstract class NewsAppStates {}

class NewsAppInitialState extends NewsAppStates {}

class NewsAppBotNavState extends NewsAppStates {}

class NewsGetBusinessLoadingState extends NewsAppStates {}

class NewsGetBusinessSuccessState extends NewsAppStates {}

class NewsGetBusinessErrorState extends NewsAppStates {

  String error;
  NewsGetBusinessErrorState(this.error);
}

class NewsGetSportsLoadingState extends NewsAppStates {}

class NewsGetSportsSuccessState extends NewsAppStates {}

class NewsGetSportsErrorState extends NewsAppStates {

  String error;
  NewsGetSportsErrorState(this.error);
}

class NewsGetScienceLoadingState extends NewsAppStates {}

class NewsGetScienceSuccessState extends NewsAppStates {}

class NewsGetScienceErrorState extends NewsAppStates {

  String error;
  NewsGetScienceErrorState(this.error);
}

class NewsGetSearchLoadingState extends NewsAppStates {}

class NewsGetSearchSuccessState extends NewsAppStates {}

class NewsGetSearchErrorState extends NewsAppStates {

  String error;
  NewsGetSearchErrorState(this.error);
}

class NewsChangeThemeModeState extends NewsAppStates {}




