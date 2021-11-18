part of 'shop_cubit.dart';

@immutable
abstract class ShopState {}

class ShopInitial extends ShopState {}

class ShopChangeBottomNavState extends ShopState{}

class ShopLoadingHomeDataState extends ShopState{}
class ShopSuccessHomeDataState extends ShopState{}
class ShopErrorHomeDataState extends ShopState{
  final error;
  ShopErrorHomeDataState(this.error);
}

class ShopSuccessCategoriesState extends ShopState{}
class ShopErrorCategoriesState extends ShopState{
  final error;
  ShopErrorCategoriesState(this.error);}

class ShopFavoritesState extends ShopState{}
class ShopSuccessFavoritesState extends ShopState{
  final FavoritesModelAddAndDelete model;

  ShopSuccessFavoritesState(this.model);
}
class ShopErrorFavoritesState extends ShopState{
  final error;
  ShopErrorFavoritesState(this.error);}

class ShopLoadingGetFavoritesState extends ShopState{}
class ShopSuccessGetFavoritesState extends ShopState{}
class ShopErrorGetFavoritesState extends ShopState{}

class ShopLoadingGetUserDataState extends ShopState{}
class ShopSuccessGetUserDataState extends ShopState{
  final LoginModel loginModel;

  ShopSuccessGetUserDataState(this.loginModel);
}
class ShopErrorGetUserDataState extends ShopState{}

class ShopLoadingUpdateState extends ShopState{}
class ShopSuccessUpdateState extends ShopState{
  final LoginModel loginModel;

  ShopSuccessUpdateState(this.loginModel);
}
class ShopErrorUpdateState extends ShopState{}

