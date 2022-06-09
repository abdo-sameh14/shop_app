abstract class ShopAppStates {}

class ShopAppInitialState extends ShopAppStates {}

class ShopAppBotNavState extends ShopAppStates {}

class ShopGetBusinessLoadingState extends ShopAppStates {}

class ShopGetBusinessSuccessState extends ShopAppStates {}

class ShopGetBusinessErrorState extends ShopAppStates {

  String error;
  ShopGetBusinessErrorState(this.error);
}

class ShopGetSportsLoadingState extends ShopAppStates {}

class ShopGetSportsSuccessState extends ShopAppStates {}

class ShopGetSportsErrorState extends ShopAppStates {

  String error;
  ShopGetSportsErrorState(this.error);
}

class ShopGetScienceLoadingState extends ShopAppStates {}

class ShopGetScienceSuccessState extends ShopAppStates {}

class ShopGetScienceErrorState extends ShopAppStates {

  String error;
  ShopGetScienceErrorState(this.error);
}

class ShopGetSearchLoadingState extends ShopAppStates {}

class ShopGetSearchSuccessState extends ShopAppStates {}

class ShopGetSearchErrorState extends ShopAppStates {

  String error;
  ShopGetSearchErrorState(this.error);
}

class ShopChangeThemeModeState extends ShopAppStates {}




