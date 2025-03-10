import 'package:firebase_flutterbloc/fetures/product/bloc/product_event.dart';
import 'package:firebase_flutterbloc/fetures/product/bloc/product_state.dart';
import 'package:firebase_flutterbloc/fetures/product/service/product_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService _service = ProductService();

  ProductBloc() : super(ProductInitial()) {
    // On Fetch
    on<FetchProducts>(_onFetchProducts);
    on<AddProduct>(_onAddProduct);
    on<UpdateProduct>(_onUpdateProduct);
    on<DeleteProduct>(_onDeleteProduct);
    on<IncrementQuantity>(_onIncrementProductQuantity);
    on<DecrementQuantity>(_onDecrementProductQuantity);
  }

  void _onFetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
    try {
      final products = await _service.fetchProduct();
      emit(ProductedLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _onAddProduct(AddProduct event, Emitter<ProductState> emit) async {
    try {
      await _service.addProduct(event.productModel);
      add(FetchProducts());
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _onUpdateProduct(UpdateProduct event, Emitter<ProductState> emit) async {
    try {
      await _service.updateProduct(event.productModel);
      add(FetchProducts());
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _onDeleteProduct(DeleteProduct event, Emitter<ProductState> emit) async {
    try {
      await _service.productDelete(event.productId);
      add(FetchProducts());
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _onIncrementProductQuantity(
    IncrementQuantity event,
    Emitter<ProductState> emit,
  ) async {
    try {
      await _service.incremenQuantity(event.productId);
      add(FetchProducts());
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _onDecrementProductQuantity(
    DecrementQuantity event,
    Emitter<ProductState> emit,
  ) async {
    try {
      await _service.decremenQuantity(event.productId);
      add(FetchProducts());
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
