import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/category.dart';
import 'package:hajat_mobile_app/src/services/api/api_service.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';
part 'sub_categories_state.dart';
part 'sub_categories_cubit.freezed.dart';

class SubCategoriesCubit extends Cubit<SubCategoriesState> {
  final String id;
  SubCategoriesCubit(this.id) : super(const SubCategoriesState.initial()) {
    getSubCategories(id);
  }

  // get sub categories by id
  Future<void> getSubCategories(String id) async {
    emit(const SubCategoriesState.loading());
    try {
      var response = await getIt<ApiService>().getSubCategories(id);
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
      emit(SubCategoriesState.loaded(categories));
    } catch (e) {
      emit(SubCategoriesState.error(e.toString()));
    }
    
    
  }
}