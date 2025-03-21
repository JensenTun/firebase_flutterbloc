import 'package:firebase_flutterbloc/fetures/product/bloc/product_bloc.dart';
import 'package:firebase_flutterbloc/fetures/product/bloc/product_event.dart';
import 'package:firebase_flutterbloc/fetures/product/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateProductScreen extends StatefulWidget {
  final ProductModel productModel;
  const UpdateProductScreen({super.key, required this.productModel});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.productModel.product);
    _priceController = TextEditingController(
      text: widget.productModel.price.toString(),
    );
    _quantityController = TextEditingController(
      text: widget.productModel.quantity.toString(),
    );
  }

  void _updateProduct() {
    if (_formKey.currentState!.validate()) {
      final updatedProduct = ProductModel(
        id: widget.productModel.id,
        product: _nameController.text,
        price: double.parse(_priceController.text),
        quantity: int.parse(_quantityController.text),
      );

      // Dispatch UpdateProduct Event
      context.read<ProductBloc>().add(UpdateProduct(updatedProduct));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product Updated Successfully!')),
      );

      Navigator.pop(context); // Go back to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Product')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
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
                onPressed: _updateProduct,
                child: const Text('Update Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
