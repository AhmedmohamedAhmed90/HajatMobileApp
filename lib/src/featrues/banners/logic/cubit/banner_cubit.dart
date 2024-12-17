import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hajat_mobile_app/src/featrues/banners/models/banner.dart';
import 'package:hajat_mobile_app/src/services/api/api_service.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';


part 'banner_state.dart';
part 'banner_cubit.freezed.dart';

class BannersCubit extends Cubit<BannersState> {
  final api = getIt<ApiService>();
  BannersCubit() : super(const BannersState.initial()) {
    getBanners();
  }

  void getBanners() async {
    emit(const BannersState.loading());
    try {
      final response = await api.getBanners();
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        final banners =
            (response.data as List).map((e) => Banner.fromJson(e)).toList();
        emit(BannersState.loaded(banners));
      } else {
        emit(BannersState.error(response.statusMessage ?? "An error occurred"));
      }
    } on Exception catch (e) {
      emit(BannersState.error(e.toString()));
    }
  }
}
