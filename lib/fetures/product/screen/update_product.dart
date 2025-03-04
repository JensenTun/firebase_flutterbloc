import 'package:firebase_flutterbloc/fetures/product/model/product_model.dart';
import 'package:flutter/material.dart';

class UpdateProductScreen extends StatefulWidget {
  final ProductModel productModel;
  const UpdateProductScreen({super.key, required this.productModel});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
