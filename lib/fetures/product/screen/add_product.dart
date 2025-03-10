import 'package:firebase_flutterbloc/fetures/product/bloc/product_bloc.dart';
import 'package:firebase_flutterbloc/fetures/product/bloc/product_event.dart';
import 'package:firebase_flutterbloc/fetures/product/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  //
  void _submitProduct() {
    if (_formkey.currentState!.validate()) {
      final product = ProductModel(
        product: _nameController.text,
        price: double.parse(_priceController.text),
        quantity: int.parse(_quantityController.text),
      );
      context.read<ProductBloc>().add(AddProduct(product));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product Added Successfully!')),
      );
    }
    Navigator.pop(context);
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator:
                    (value) =>
                        value!.isEmpty ? 'Please enter a product name' : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator:
                    (value) => value!.isEmpty ? 'Please enter a price' : null,
              ),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator:
                    (value) =>
                        value!.isEmpty ? 'Please enter a quantity' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitProduct,
                child: Text('Add product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
