import 'package:firebase_flutterbloc/fetures/product/model/product_model.dart';

abstract class ProductEvent {}

class FetchProducts extends ProductEvent {}

class AddProduct extends ProductEvent {
  final ProductModel productModel;
  AddProduct(this.productModel);
}

class UpdateProduct extends ProductEvent {
  final ProductModel productModel;
  UpdateProduct(this.productModel);
}

class DeleteProduct extends ProductEvent {
  final String productId;
  DeleteProduct(this.productId);
}

class IncrementQuantity extends ProductEvent {
  final String productId;
  IncrementQuantity(this.productId);
}

class DecrementQuantity extends ProductEvent {
  final String productId;
  DecrementQuantity(this.productId);
}
