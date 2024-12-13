import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../models/product_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  final List<Product> _products = []; // In-memory list of products

  // Display all products
  List<Product> get products => List.unmodifiable(_products);

  // Add a new product
  void addProduct(Product product) {
    _products.add(product);
    emit(ProductUpdated(_products));
  }

  // Edit an existing product
  void editProduct(int id, Product updatedProduct) {
    final index = _products.indexWhere((product) => product.id == id);
    if (index != -1) {
      _products[index] = updatedProduct;
      emit(ProductUpdated(_products));
    }
  }

  // Delete a product
  void deleteProduct(int id) {
    _products.removeWhere((product) => product.id == id);
    emit(ProductUpdated(_products));
  }
}
