import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cahehelper.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitiaState());

  static AppCubit get(context) =>BlocProvider.of(context);


  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    @ required bool isShow ,
    @ required IconData icon,
  })
  {
    isBottomSheetShown=isShow;
    fabIcon=icon;
    emit(AppChangeBottomSheetState());
  }

  bool isDark =false;

  void isLightOrDark({bool fromShared}){
    if(fromShared != null)
      isDark = fromShared;
    else
      isDark =! isDark;

    CacheHelper.saveData(key: 'isDark', value: isDark).then((value){
      emit(AppChangeModeState());

    });
  }

}