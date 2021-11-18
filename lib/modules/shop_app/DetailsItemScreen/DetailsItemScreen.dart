// import 'package:conditional_builder/conditional_builder.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shop_app/layout/cubit_for_shop_app/shop_cubit.dart';
// import 'package:shop_app/models/shop_app_models/home_model.dart';
//
// class DetailsItemScreen extends StatelessWidget {
//
//
//   Widget buildSliverAppBar( Products products) {
//     return SliverAppBar(
//       expandedHeight: 600,
//       pinned: true,
//       stretch: true,
//       flexibleSpace: FlexibleSpaceBar(
//         title: Text(
//          products.name,
//           style: TextStyle(color: Colors.white),
//         ),
//         background: Hero(
//           tag: products.id,
//           child: Image.network(
//             products.image,
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ShopCubit(),
//       child: BlocConsumer<ShopCubit, ShopState>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           return ConditionalBuilder(
//             condition: ShopCubit.get(context).homeModel.data.products != null,
//             builder: (context) =>
//                 detailsItem(ShopCubit.get(context).homeModel,context),
//             fallback: (context) => Center(child: CircularProgressIndicator()),
//           );
//         },
//       ),
//     );
//   }
//   Widget detailsItem(HomeModel model,context)=>Scaffold(
//     appBar: AppBar(),
//     body: buildSliverAppBar( ),
//   );
// }
//
//
