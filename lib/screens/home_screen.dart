import 'package:firebase_flutterbloc/fetures/authen/sign_in_bloc/sign_in_bloc.dart';
import 'package:firebase_flutterbloc/fetures/authen/sign_in_bloc/sign_in_event.dart';
import 'package:firebase_flutterbloc/fetures/product/bloc/product_bloc.dart';
import 'package:firebase_flutterbloc/fetures/product/bloc/product_event.dart';
import 'package:firebase_flutterbloc/fetures/product/bloc/product_state.dart';
import 'package:firebase_flutterbloc/fetures/product/screen/update_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<ProductBloc>().add(FetchProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home", style: TextStyle(fontSize: 20)),
        actions: [
          IconButton(
            onPressed: () {
              context.read<SignInBloc>().add(SignOutRequired());
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductedLoaded) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products.elementAt(index);
                return ListTile(
                  title: Text(product.product),
                  subtitle: Text(
                    'Price: \$${product.price}, Quantity: ${product.quantity} total ${product.totalPrice}',
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                UpdateProductScreen(productModel: product),
                      ),
                    );
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.remove)),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete_forever_rounded),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const Center(child: Text('No Products Available'));
        },
      ),
    );
  }
}
