import 'package:firebase_flutterbloc/fetures/product/model/product_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductedLoaded extends ProductState {
  final List<ProductModel> products;
  ProductedLoaded(this.products);
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}
