import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hajat_mobile_app/src/featrues/brands/models/brand.dart';
import 'package:hajat_mobile_app/src/services/api/api_service.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';


part 'brands_state.dart';
part 'brands_cubit.freezed.dart';

class BrandsCubit extends Cubit<BrandsState> {
  final api = getIt<ApiService>();
  BrandsCubit() : super(const BrandsState.initial()) {
    getBrands();
  }

  void getBrands() async {
    emit(const BrandsState.loading());
    try {
      final response = await api.getBrands();
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        final brands =
            (response.data as List).map((e) => Brand.fromJson(e)).toList();
        emit(BrandsState.loaded(brands));
      } else {
        emit(BrandsState.error(response.statusMessage ?? "An error occurred"));
      }
    } on Exception catch (e) {
      emit(BrandsState.error(e.toString()));
    }
  }
}
