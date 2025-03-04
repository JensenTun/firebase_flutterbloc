import 'package:firebase_flutterbloc/fetures/product/bloc/product_event.dart';
import 'package:firebase_flutterbloc/fetures/product/bloc/product_state.dart';
import 'package:firebase_flutterbloc/fetures/product/service/product_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService _service = ProductService();

  ProductBloc() : super(ProductInitial()) {
    // On Fetch
    on<FetchProducts>(_onFetchProducts);
  }

  void _onFetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
    try {
      final products = await _service.fetchProduct();
      emit(ProductedLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
