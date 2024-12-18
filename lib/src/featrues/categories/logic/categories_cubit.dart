import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hajat_mobile_app/src/featrues/categories/models/category.dart';
import 'package:hajat_mobile_app/src/services/api/api_service.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';


part 'categories_state.dart';
part 'categories_cubit.freezed.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(const CategoriesState.initial()) {
    loadCategories();
  }

  void loadCategories() async {
    try {
      emit(const CategoriesState.loading());
      var response = await getIt<ApiService>().getCategories();
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {

      } else {
       
        throw Exception(response.statusMessage);
      }
      List<Category> categories = [];
      for (var category in response.data) {
        var _category = Category.fromJson(category);
        categories.add(_category);
      }
      emit(CategoriesState.loaded(categories));
    } catch (e) {
    
      emit( CategoriesState.error( e.toString() ) );
    }
  }
}
