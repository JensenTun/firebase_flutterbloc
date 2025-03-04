import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutterbloc/fetures/product/model/product_model.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> fetchProduct() async {
    try {
      final snapshot = await _firestore.collection('blocproducts').get();
      final product =
          snapshot.docs.map((data) => ProductModel.fromMap(data)).toList();
      return product;
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }
}
