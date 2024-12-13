import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hajat_mobile_app/Repositories/homeRepository.dart';
import 'package:hajat_mobile_app/modules/HomeScreen/cubit/home_states.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;

  HomeCubit({required this.repository}) : super(HomeState());

  Future<void> loadHomeData() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final categories = await repository.getCategories();
      final products = await repository.getProducts();
      

      emit(state.copyWith(
        categories: categories,
        products: products,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }
}