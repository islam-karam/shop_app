import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit_for_shop_app/shop_cubit.dart';
import 'package:shop_app/layout/home_layout/home/home.dart';
import 'package:shop_app/modules/shop_app/login/loginscreen.dart';
import 'package:shop_app/shared/componantes/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cahehelper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes/themes.dart';
import 'bloc_observer.dart';
import 'modules/shop_app/DetailsItemScreen/DetailsItemScreen.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
   token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null)
      widget = HomeLayoutPage();
    else
      widget = LogInScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(startWidget: widget,isDark: isDark,));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  final bool isDark;


  MyApp({this.startWidget,this.isDark});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..isLightOrDark(
            fromShared: isDark,
          ),
        ),
        BlocProvider(
          create: (context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
