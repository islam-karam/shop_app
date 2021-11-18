part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class ShopRegisterLoadingState extends RegisterState {}

class ShopRegisterSuccessState extends RegisterState
{
  final LoginModel loginModel;

  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorState extends RegisterState {
  final String error;

  ShopRegisterErrorState(this.error);
}

// One State For Password
class ShopChangePasswordRegisterState extends RegisterState {}