import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_flutterbloc/fetures/authen/model/user.dart';
import 'package:firebase_flutterbloc/fetures/authen/service/user_repo.dart';
import 'package:firebase_flutterbloc/fetures/authen/sign_up_bloc/sign_up_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'sign_in_bloc_test.mocks.dart';

// Generate a mock class for UserRepo
@GenerateMocks([UserRepo])
void main() {
  late MockUserRepo mockUserRepo;
  late SignUpBloc signUpBloc;
  late UserModel testUser;

  setUp(() {
    mockUserRepo = MockUserRepo();
    signUpBloc = SignUpBloc(userRepo: mockUserRepo);
    testUser = UserModel(
      userId: '123',
      email: 'test@example.com',
      name: 'test',
    );
  });

  tearDown(() {
    signUpBloc.close();
  });

  test('initial state should be SignUpInitial', () {
    expect(signUpBloc.state, SignUpInitial());
  });

  blocTest<SignUpBloc, SignUpState>(
    'emits [SignUpProcess, SignUpSuccess] when sign-up is successful',
    build: () {
      when(mockUserRepo.signUp(any, any)).thenAnswer((_) async => testUser);
      when(mockUserRepo.setUserData(any)).thenAnswer((_) async {});
      return signUpBloc;
    },
    act: (bloc) => bloc.add(SignUpRequired(testUser, 'password123')),
    expect: () => [SignUpProcess(), SignUpSuccess()],
    verify: (_) {
      verify(mockUserRepo.signUp(testUser, 'password123')).called(1);
      verify(mockUserRepo.setUserData(testUser)).called(1);
    },
  );

  blocTest<SignUpBloc, SignUpState>(
    'emits [SignUpProcess, SignUpFailure] when sign-up fails',
    build: () {
      when(
        mockUserRepo.signUp(any, any),
      ).thenThrow(Exception('Sign-up failed'));
      return signUpBloc;
    },
    act: (bloc) => bloc.add(SignUpRequired(testUser, 'password123')),
    expect: () => [SignUpProcess(), SignUpFailure()],
  );
}
