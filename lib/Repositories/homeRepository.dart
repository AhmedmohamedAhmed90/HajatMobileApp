import 'package:hajat_mobile_app/models/product_model.dart';
import 'package:hajat_mobile_app/models/category_model.dart';
import 'package:dio/dio.dart';

class HomeRepository {
  final Dio dio;

  HomeRepository({required this.dio});

  Future<List<Category>> getCategories() async {
    try {
      final response = await dio.get('/api/categories');
      return (response.data as List)
          .map((json) => Category.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Product>> getProducts() async {
    try {
      final response = await dio.get('/api/products');
      return (response.data as List)
          .map((json) => Product.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to load products');
    }
  }

 
}