import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/shop_app_models/search_for_products_model.dart';
import 'package:shop_app/shared/componantes/constants.dart';
import 'package:shop_app/shared/network/end_pointes/end_pointes.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context)=>BlocProvider.of(context);

  SearchModel model;

  void search(String text)
  {
    emit(SearchLoading());

    DioHelper.postData(
        url: SEARCH,
        data:
        {
          'text':text,
        },
      token: token,
    ).then((value) {
      model=SearchModel.fromJson(value.data);
      emit(SearchSuccess());
    }).catchError((error){
      print(error.toString());
      emit(SearchError());
    });
  }
}
