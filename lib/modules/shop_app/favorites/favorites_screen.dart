import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit_for_shop_app/shop_cubit.dart';
import 'package:shop_app/models/shop_app_models/favorites_model_screen.dart';
import 'package:shop_app/shared/componantes/conponents.dart';
import 'package:shop_app/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is !ShopLoadingGetFavoritesState,
          builder:(context)=> ListView.separated(
            itemBuilder: (context, index) => buildFavoritesAndSearchItem(ShopCubit.get(context).favoritesModelScreen.data.data[index].product,context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount:ShopCubit.get(context).favoritesModelScreen.data.data.length,
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

}
