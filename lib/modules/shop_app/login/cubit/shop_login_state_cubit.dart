import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/shop_app_models/login_model.dart';
import 'package:shop_app/shared/network/end_pointes/end_pointes.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
part 'shop_login_state_state.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() : super(ShopLoginStateInitial());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  LoginModel loginModel;
  void userLogin({
    @required String email,
    @required String password,
  })
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data:
      {
        'email':email,
        'password':password,
      },
    ).then((value){
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel.status);
      print(loginModel.data.token);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error){
      print('غي غلط $error');
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix=  Icons.visibility;
  bool isPassword=true;

  // ignore: non_constant_identifier_names
  void ChangePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ?  Icons.visibility : Icons.visibility_off;
    emit(ShopChangePasswordState());
  }
}
