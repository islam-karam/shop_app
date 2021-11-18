import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit_for_shop_app/shop_cubit.dart';
import 'package:shop_app/models/shop_app_models/categories_model.dart';
import 'package:shop_app/shared/componantes/conponents.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) => buildCatItem(ShopCubit.get(context).categoriesModel.data.data[index],context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: ShopCubit.get(context).categoriesModel.data.data.length,
        );
      },
    );
  }

  Widget buildCatItem(DataModel dataModel,context) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(dataModel.image),
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 15,),
            Text(
              dataModel.name,
              style: TextStyle(
                color: AppCubit.get(context).isDark ? Colors.white : Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: AppCubit.get(context).isDark ? Colors.white : Colors.black,
            ),
          ],
        ),
      );
}
