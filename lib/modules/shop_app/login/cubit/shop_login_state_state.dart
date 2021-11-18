part of 'shop_login_state_cubit.dart';

@immutable
abstract class ShopLoginState {}
//initial State
class ShopLoginStateInitial extends ShopLoginState {}
// 3 States For Login Screen
class ShopLoginLoadingState extends ShopLoginState {}

class ShopLoginSuccessState extends ShopLoginState
{
  final LoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginState {
  final String error;

  ShopLoginErrorState(this.error);
}

// One State For Password
class ShopChangePasswordState extends ShopLoginState {}
