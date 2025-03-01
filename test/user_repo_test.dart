import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutterbloc/fetures/authen/model/user.dart';
import 'package:firebase_flutterbloc/fetures/authen/service/user_repo_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_repo_test.mocks.dart';

@GenerateMocks([FirebaseAuth, FirebaseFirestore, UserCredential, User])
void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockFirebaseFirestore mockFirestore;
  late UserRepoImp userRepo;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized(); // Ensures async operations
  });

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockFirestore = MockFirebaseFirestore(); // Mock Firestore
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();

    userRepo = UserRepoImp(
      firbaseAuth: mockFirebaseAuth,
      firestore: mockFirestore, // Inject mocked Firestore
    );
  });

  group('UserRepoImp', () {
    test(
      'signIn should call FirebaseAuth signInWithEmailAndPassword',
      () async {
        when(
          mockFirebaseAuth.signInWithEmailAndPassword(
            email: anyNamed('email'),
            password: anyNamed('password'),
          ),
        ).thenAnswer((_) async => mockUserCredential);

        await userRepo.signIn('test@example.com', 'password123');
        verify(
          mockFirebaseAuth.signInWithEmailAndPassword(
            email: 'test@example.com',
            password: 'password123',
          ),
        ).called(1);
      },
    );

    test('signUp should create user and return UserModel', () async {
      when(
        mockFirebaseAuth.createUserWithEmailAndPassword(
          email: anyNamed('email'),
          password: anyNamed('password'),
        ),
      ).thenAnswer((_) async => mockUserCredential);
      when(mockUserCredential.user).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('12345');

      UserModel userModel = UserModel(
        email: 'test@example.com',
        userId: '123',
        name: 'test',
      );
      UserModel result = await userRepo.signUp(userModel, 'password123');

      expect(result.userId, '12345');
    });

    test('signOut should call FirebaseAuth signOut', () async {
      when(mockFirebaseAuth.signOut()).thenAnswer((_) async {});
      await userRepo.sigOut();
      verify(mockFirebaseAuth.signOut()).called(1);
    });
  });
}
