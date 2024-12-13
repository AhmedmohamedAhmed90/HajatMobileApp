part of 'product_cubit.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductUpdated extends ProductState {
  final List<Product> products;

  ProductUpdated(this.products);
}
