import 'package:firebase_core/firebase_core.dart';
import 'package:mockito/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutterbloc/fetures/product/model/product_model.dart';
import 'package:firebase_flutterbloc/fetures/product/service/product_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'product_service_test.mocks.dart';

// Generate mocks for FirebaseFirestore, CollectionReference, DocumentReference,
// QuerySnapshot, and QueryDocumentSnapshot
@GenerateMocks([
  FirebaseFirestore,
  CollectionReference<Map<String, dynamic>>,
  DocumentReference<Map<String, dynamic>>,
  QuerySnapshot<Map<String, dynamic>>,
  QueryDocumentSnapshot<
    Map<String, dynamic>
  >, // Include QueryDocumentSnapshot here
])
void main() {
  late MockFirebaseFirestore mockFirebaseFirestore;
  late MockCollectionReference<Map<String, dynamic>> mockCollectionReference;
  late MockDocumentReference<Map<String, dynamic>> mockDocumentReference;
  late ProductService productService;

  setUp(() async {
    // Mock Firebase initialization
    await Firebase.initializeApp();
    // Mock the FirebaseFirestore instance and other dependencies
    mockFirebaseFirestore = MockFirebaseFirestore();
    mockCollectionReference = MockCollectionReference<Map<String, dynamic>>();
    mockDocumentReference = MockDocumentReference<Map<String, dynamic>>();

    // Set up the ProductService with the mocked Firestore instance
    productService = ProductService();
  });

  group('ProductService', () {
    test('fetchProduct returns a list of products', () async {
      // Arrange
      final mockQuerySnapshot = MockQuerySnapshot<Map<String, dynamic>>();
      final mockQueryDocumentSnapshot =
          MockQueryDocumentSnapshot<
            Map<String, dynamic>
          >(); // Mock QueryDocumentSnapshot
      final productModel = ProductModel(
        id: '1',
        product: 'Product 1',
        price: 20.0,
        quantity: 10,
      );

      // Setting up mock behavior
      when(
        mockFirebaseFirestore.collection('blocproducts'),
      ).thenReturn(mockCollectionReference);
      when(
        mockCollectionReference.get(),
      ).thenAnswer((_) async => mockQuerySnapshot);
      when(mockQuerySnapshot.docs).thenReturn([
        mockQueryDocumentSnapshot,
      ]); // Mocking docs with a list containing mockQueryDocumentSnapshot
      when(
        mockQueryDocumentSnapshot.data(),
      ).thenReturn(productModel.toMap()); // Mocking the data

      // Act
      final result = await productService.fetchProduct();

      // Assert
      expect(result, isA<List<ProductModel>>());
      expect(result.first.product, 'Product 1');
    });

    test('addProduct successfully adds a product', () async {
      // Arrange
      final product = ProductModel(
        id: '1',
        product: 'Product 1',
        price: 20.0,
        quantity: 10,
      );

      when(
        mockFirebaseFirestore.collection('blocproducts'),
      ).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.set(any)).thenAnswer((_) async {});

      // Act
      await productService.addProduct(product);

      // Assert
      verify(mockCollectionReference.doc(product.id)).called(1);
      verify(mockDocumentReference.set(product.toMap())).called(1);
    });

    test('updateProduct successfully updates a product', () async {
      // Arrange
      final product = ProductModel(
        id: '1',
        product: 'Product 1',
        price: 20.0,
        quantity: 20,
      );

      when(
        mockFirebaseFirestore.collection('blocproducts'),
      ).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.update(any)).thenAnswer((_) async {});

      // Act
      await productService.updateProduct(product);

      // Assert
      verify(mockCollectionReference.doc(product.id)).called(1);
      verify(mockDocumentReference.update(product.toMap())).called(1);
    });

    test('productDelete deletes a product', () async {
      // Arrange
      final productId = '1';

      when(
        mockFirebaseFirestore.collection('blocproducts'),
      ).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.delete()).thenAnswer((_) async {});

      // Act
      await productService.productDelete(productId);

      // Assert
      verify(mockCollectionReference.doc(productId)).called(1);
      verify(mockDocumentReference.delete()).called(1);
    });

    test('incrementQuantity increases product quantity', () async {
      // Arrange
      final productId = '1';
      final product = ProductModel(
        id: productId,
        product: 'Product 1',
        price: 20.0,
        quantity: 10,
      );
      final docSnapshot = MockQueryDocumentSnapshot<Map<String, dynamic>>();

      when(
        mockFirebaseFirestore.collection('blocproducts'),
      ).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get()).thenAnswer((_) async => docSnapshot);
      when(docSnapshot.exists).thenReturn(true);
      when(docSnapshot.data()).thenReturn(product.toMap());
      when(mockDocumentReference.update(any)).thenAnswer((_) async {});

      // Act
      await productService.incremenQuantity(productId);

      // Assert
      expect(product.quantity, 11);
      verify(mockDocumentReference.update(any)).called(1);
    });

    test('decrementQuantity decreases product quantity', () async {
      // Arrange
      final productId = '1';
      final product = ProductModel(
        id: productId,
        product: 'Product 1',
        price: 20.0,
        quantity: 10,
      );
      final docSnapshot = MockQueryDocumentSnapshot<Map<String, dynamic>>();

      when(
        mockFirebaseFirestore.collection('blocproducts'),
      ).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get()).thenAnswer((_) async => docSnapshot);
      when(docSnapshot.exists).thenReturn(true);
      when(docSnapshot.data()).thenReturn(product.toMap());
      when(mockDocumentReference.update(any)).thenAnswer((_) async {});

      // Act
      await productService.decremenQuantity(productId);

      // Assert
      expect(product.quantity, 9);
      verify(mockDocumentReference.update(any)).called(1);
    });
  });
}
