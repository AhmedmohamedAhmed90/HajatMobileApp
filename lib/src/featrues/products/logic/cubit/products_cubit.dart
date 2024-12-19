import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hajat_mobile_app/src/featrues/products/models/product.dart';
import 'package:hajat_mobile_app/src/services/api/api_service.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';

part 'products_state.dart';
part 'products_cubit.freezed.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(
    this.categoryId,
    this.brandId,
    {this.query,}
  ) : super(const ProductsState.initial()) {
    loadProducts(categoryId, brandId, query);
  }
  
  final int? categoryId;
  final int? brandId;
  final String? query;

  void loadProducts(int? categoryId, int? brandId, String? q) async {
    try {
      emit(const ProductsState.loading());
      final response = await getIt<ApiService>().getProducts(categoryId, brandId, q);
      
      if (response.statusCode == null || 
          response.statusCode! < 200 || 
          response.statusCode! >= 300) {
        throw Exception(response.statusMessage ?? 'Unknown error occurred');
      }

      if (response.data == null) {
        throw Exception('No data received from server');
      }

      final List<Product> products = (response.data as List).map((productData) {
        try {
          return Product.fromJson(Map<String, dynamic>.from(productData));
        } catch (e) {
          print('Error parsing product: $e');
          rethrow;
        }
      }).toList();

      emit(ProductsState.loaded(products));
    } catch (e) {
      print('Error loading products: $e');
      emit(ProductsState.error(e.toString()));
    }
  }
}