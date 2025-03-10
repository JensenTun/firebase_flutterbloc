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

  Future<void> addProduct(ProductModel product) async {
    try {
      await _firestore
          .collection('blocproducts')
          .doc(product.id)
          .set(product.toMap());
    } catch (e) {
      print('Error add products: $e');
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      await _firestore
          .collection('blocproducts')
          .doc(product.id)
          .update(product.toMap());
    } catch (e) {
      print('Error update products: $e');
    }
  }

  Future<void> productDelete(String productID) async {
    try {
      await _firestore.collection('blocproducts').doc(productID).delete();
    } catch (e) {
      print('Error delete products: $e');
    }
  }

  Future<void> incremenQuantity(String productID) async {
    try {
      final doc =
          await _firestore.collection('blocproducts').doc(productID).get();
      if (doc.exists) {
        final product = ProductModel.fromMap(doc);
        product.quantity += 1;
        await _firestore
            .collection('blocproducts')
            .doc(productID)
            .update(product.toMap());
      }
    } catch (e) {
      print('Error incrementQuantity products: $e');
    }
  }

  Future<void> decremenQuantity(String productID) async {
    try {
      final doc =
          await _firestore.collection('blocproducts').doc(productID).get();
      if (doc.exists) {
        final product = ProductModel.fromMap(doc);
        if (product.quantity > 0) {
          product.quantity -= 1;
          await _firestore
              .collection('blocproducts')
              .doc(productID)
              .update(product.toMap());
        }
      }
    } catch (e) {
      print('Error incrementQuantity products: $e');
    }
  }
}
