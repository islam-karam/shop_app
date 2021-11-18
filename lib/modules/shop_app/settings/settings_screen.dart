import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit_for_shop_app/shop_cubit.dart';
import 'package:shop_app/shared/componantes/conponents.dart';

class SettingsScreen extends StatelessWidget {

  var formKey= GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).loginModel;

        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).loginModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateState)
                  LinearProgressIndicator(),
                  SizedBox(height: 20,),
                  defaultFormFiled(
                    controller: nameController,
                    type: TextInputType.text,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Name Must Not Be Empty ';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefixIcon: Icons.person,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormFiled(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Email Address Must Not Be Empty ';
                      }
                      return null;
                    },
                    label: 'emailAddress',
                    prefixIcon: Icons.email_outlined,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormFiled(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Phone Must Not Be Empty ';
                      }
                      return null;
                    },
                    label: 'Phone',
                    prefixIcon: Icons.phone,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      function: () {
                        if(formKey.currentState.validate()){
                          ShopCubit.get(context).upDateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                      text: 'Update'),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    background: Colors.red,
                      function: () {
                        singOut(context);
                      },
                      text: 'Logout'),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
