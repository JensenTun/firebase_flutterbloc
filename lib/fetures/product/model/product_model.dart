import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String? id;
  final String product;
  double price;
  int quantity;
  double get totalPrice => price * quantity;

  ProductModel({
    this.id,
    required this.product,
    required this.price,
    required this.quantity,
  });

  // Convert to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productName': product,
      'price': price,
      'quantity': quantity,
    };
  }

  // Convert from Firebase to Product Object
  factory ProductModel.fromMap(DocumentSnapshot<Map<String, dynamic>> map) {
    return ProductModel(
      id: map.id,
      product: map['productName'],
      price: map['price'].toDouble(),
      quantity: map['quantity'],
    );
  }
}
