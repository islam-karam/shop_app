import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/shop_app_models/login_model.dart';
import 'package:shop_app/shared/network/end_pointes/end_pointes.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);



  LoginModel loginModel;
  void userRegister({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
  })
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data:
      {
        'name':name,
        'email':email,
        'password':password,
        'phone':phone,
      },
    ).then((value){
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error){
      print('غي غلط $error');
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix=  Icons.visibility;
  bool isPassword=true;

  // ignore: non_constant_identifier_names
  void ChangePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ?  Icons.visibility : Icons.visibility_off;
    emit(ShopChangePasswordRegisterState());
  }
}
