import 'package:hajat_mobile_app/models/product_model.dart';
import 'package:hajat_mobile_app/models/category_model.dart';
class HomeState {
  final List<Category> categories;
  final List<Product> products;
  final bool isLoading;
  final String? error;

  HomeState({
    this.categories = const [],
    this.products = const [],
    this.isLoading = false,
    this.error,
  });

  HomeState copyWith({
    List<Category>? categories,
    List<Product>? products,
    bool? isLoading,
    String? error,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
