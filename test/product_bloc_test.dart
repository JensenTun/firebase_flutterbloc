import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_flutterbloc/fetures/product/bloc/product_bloc.dart';
import 'package:firebase_flutterbloc/fetures/product/bloc/product_event.dart';
import 'package:firebase_flutterbloc/fetures/product/bloc/product_state.dart';
import 'package:firebase_flutterbloc/fetures/product/service/product_service.dart';
import 'package:firebase_flutterbloc/fetures/product/model/product_model.dart';

class MockProductService extends Mock implements ProductService {}

void main() {
  late ProductBloc productBloc;
  late MockProductService mockProductService;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });

  setUp(() {
    mockProductService = MockProductService();
    productBloc = ProductBloc();
  });

  tearDown(() {
    productBloc.close();
  });

  group('ProductBloc', () {
    test('initial state is ProductInitial', () {
      expect(productBloc.state, ProductInitial());
    });

    // Fetch Products Test
    blocTest<ProductBloc, ProductState>(
      'emits ProductedLoaded when FetchProducts is added and service returns products',
      build: () {
        when(mockProductService.fetchProduct()).thenAnswer(
          (_) async => [
            ProductModel(
              id: '1',
              product: 'Product 1',
              price: 10.0,
              quantity: 10,
            ),
          ],
        );
        return productBloc;
      },
      act: (bloc) => bloc.add(FetchProducts()),
      expect:
          () => [
            ProductedLoaded([
              ProductModel(
                id: '1',
                product: 'Product 1',
                price: 10.0,
                quantity: 10,
              ),
            ]),
          ],
    );

    // Add Product Test
    blocTest<ProductBloc, ProductState>(
      'emits ProductedLoaded after adding a product',
      build: () {
        when(mockProductService.fetchProduct()).thenAnswer(
          (_) async => [
            ProductModel(
              id: '1',
              product: 'Product 1',
              price: 10.0,
              quantity: 10,
            ),
          ],
        );
        when(
          mockProductService.addProduct(any as ProductModel),
        ).thenAnswer((_) async {});
        return productBloc;
      },
      act:
          (bloc) => bloc.add(
            AddProduct(
              ProductModel(
                id: '1',
                product: 'Product 1',
                price: 10.0,
                quantity: 10,
              ),
            ),
          ),
      expect:
          () => [
            ProductedLoaded([
              ProductModel(
                id: '1',
                product: 'Product 1',
                price: 10.0,
                quantity: 10,
              ),
            ]),
          ],
    );

    // Increment Product Quantity Test
    blocTest<ProductBloc, ProductState>(
      'emits ProductedLoaded after incrementing product quantity',
      build: () {
        when(mockProductService.fetchProduct()).thenAnswer(
          (_) async => [
            ProductModel(
              id: '1',
              product: 'Product 1',
              price: 10.0,
              quantity: 10,
            ),
          ],
        );
        when(
          mockProductService.incremenQuantity("any"),
        ).thenAnswer((_) async {});
        return productBloc;
      },
      act:
          (bloc) => bloc.add(
            IncrementQuantity('1'),
          ), // Pass productId as named argument
      expect:
          () => [
            ProductedLoaded([
              ProductModel(
                id: '1',
                product: 'Product 1',
                price: 10.0,
                quantity: 11, // Expect the incremented quantity
              ),
            ]),
          ],
    );

    // Delete Product Test
    blocTest<ProductBloc, ProductState>(
      'emits ProductedLoaded after deleting a product',
      build: () {
        when(mockProductService.fetchProduct()).thenAnswer((_) async => []);
        when(mockProductService.productDelete("")).thenAnswer((_) async {});
        return productBloc;
      },
      act: (bloc) => bloc.add(DeleteProduct('1')), // Pass productId correctly
      expect: () => [ProductedLoaded([])],
    );

    // Increment Product Quantity Test
    blocTest<ProductBloc, ProductState>(
      'emits ProductedLoaded after incrementing product quantity',
      build: () {
        when(mockProductService.fetchProduct()).thenAnswer(
          (_) async => [
            ProductModel(
              id: '1',
              product: 'Product 1',
              price: 10.0,
              quantity: 10,
            ),
          ],
        );
        when(mockProductService.incremenQuantity("")).thenAnswer((_) async {});
        return productBloc;
      },
      act: (bloc) => bloc.add(IncrementQuantity('1')),
      expect:
          () => [
            ProductedLoaded([
              ProductModel(
                id: '1',
                product: 'Product 1',
                price: 10.0,
                quantity: 11, // Expect the incremented quantity
              ),
            ]),
          ],
    );
  });
}
