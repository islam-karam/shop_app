import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/shop_app_models/categories_model.dart';
import 'package:shop_app/models/shop_app_models/favorites_model_add_delete.dart';
import 'package:shop_app/models/shop_app_models/favorites_model_screen.dart';
import 'package:shop_app/models/shop_app_models/home_model.dart';
import 'package:shop_app/models/shop_app_models/login_model.dart';
import 'package:shop_app/modules/shop_app/categories/categories_screen.dart';
import 'package:shop_app/modules/shop_app/favorites/favorites_screen.dart';
import 'package:shop_app/modules/shop_app/products/products_screen.dart';
import 'package:shop_app/modules/shop_app/settings/settings_screen.dart';
import 'package:shop_app/shared/componantes/constants.dart';
import 'package:shop_app/shared/network/end_pointes/end_pointes.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });
      print(favorites);

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print('في غلط$error');
      emit(ShopErrorHomeDataState(error));
    });
  }

  CategoriesModel categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print('في غلط$error');
      emit(ShopErrorCategoriesState(error));
    });
  }

  FavoritesModelAddAndDelete favoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId];
    emit(ShopFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModelAddAndDelete.fromJson(value.data);
      print(value.data);

      if (!favoritesModel.status) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavorites();
      }

      emit(ShopSuccessFavoritesState(favoritesModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId];

      emit(ShopErrorFavoritesState(error));
    });
  }

  FavoritesModelScreen favoritesModelScreen;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModelScreen = FavoritesModelScreen.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print('في غلط$error');
      emit(ShopErrorGetFavoritesState());
    });
  }

  LoginModel loginModel;

  void getUserData() {
    emit(ShopLoadingGetUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel.data.name);
      emit(ShopSuccessGetUserDataState(loginModel));
    }).catchError((error) {
      print('في غلط$error');
      emit(ShopErrorGetUserDataState());
    });
  }

  void upDateUserData({
    @required String name,
    @required String email,
    @required String phone,
  }) {
    emit(ShopLoadingUpdateState());

    DioHelper.putData(url: UPDATE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel.data.name);
      emit(ShopSuccessUpdateState(loginModel));
    }).catchError((error) {
      print('في غلط$error');
      emit(ShopErrorUpdateState());
    });
  }
}
