import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit_for_shop_app/shop_cubit.dart';
import 'package:shop_app/modules/shop_app/login/loginscreen.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/network/local/cahehelper.dart';
import 'package:shop_app/shared/styles/colors.dart';

Widget defaultButton({
  double width = double.infinity,
  double height = 40,
  double radius = 10.0,
  Color background = Colors.blue,
  bool isUpperCase = true,
  @required Function function,
  @required String text,
}) =>
    Container(
      height: height,
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
    );

Widget defaultFormFiled({
  @required TextEditingController controller,
  @required TextInputType type,
  @required Function validate,
  Function onSubmit,
  Function onChange,
  Function onTap,
  @required String label,
  @required IconData prefixIcon,
  IconData suffixIcon,
  bool isPassword = false,
  Function suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      cursorColor: Colors.grey,
      style: TextStyle(
        color: Colors.grey,
      ),
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
        suffixIcon: IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffixIcon,
          ),
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

Widget defaultTextButton({
  @required Function function,
  @required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
      ),
    );


void showToast({
  @required String msg,
  @required Color color,
})=> Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0);

void singOut(context)=> CacheHelper.removeData(key: 'token').then((value) {
  if (value) {
    navigateAndFinish(context, LogInScreen());
  }
});

Widget buildFavoritesAndSearchItem(model ,context,{bool isOldPrice})=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            if (model.discount != 0&& isOldPrice)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(fontSize: 10.0, color: Colors.white),
                ),
              ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppCubit.get(context).isDark ? Colors.white : Colors.black,
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Spacer(),
              Row(
                children: [

                  Text(
                    '${model.price.round()}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if (  model.discount!= 0 && isOldPrice)
                    Text(
                      '${model.oldPrice.round()}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    icon: CircleAvatar(
                      backgroundColor: ShopCubit.get(context).favorites[model.id] ? defaultColor:Colors.grey,
                      radius: 16,
                      child: Icon(
                        Icons.favorite_outline,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      ShopCubit.get(context).changeFavorites(model.id);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
