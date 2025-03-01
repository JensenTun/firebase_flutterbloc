import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutterbloc/fetures/authen/service/user_repo.dart';
import 'package:firebase_flutterbloc/fetures/authen/sign_in_bloc/sign_in_bloc.dart';
import 'package:firebase_flutterbloc/fetures/authen/sign_in_bloc/sign_in_event.dart';
import 'package:firebase_flutterbloc/fetures/authen/sign_in_bloc/sign_in_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'sign_in_bloc_test.mocks.dart';

// Generate a mock class for UserRepo
@GenerateMocks([UserRepo])
void main() {
  late MockUserRepo mockUserRepo;
  late SignInBloc signInBloc;

  setUp(() {
    mockUserRepo = MockUserRepo();
    signInBloc = SignInBloc(userRepo: mockUserRepo);
  });

  tearDown(() {
    signInBloc.close();
  });

  test('initial state should be SignInInitial', () {
    expect(signInBloc.state, SignInInitial());
  });

  blocTest<SignInBloc, SignInState>(
    'emits [SignInProcess, SignInSuccess] when sign-in is successful',
    build: () {
      when(mockUserRepo.signIn(any, any)).thenAnswer((_) async {});
      return signInBloc;
    },
    act:
        (bloc) =>
            bloc.add(const SignInRequired('test@example.com', 'password123')),
    expect: () => [SignInProcess(), SignInSuccess()],
    verify: (_) {
      verify(mockUserRepo.signIn('test@example.com', 'password123')).called(1);
    },
  );

  blocTest<SignInBloc, SignInState>(
    'emits [SignInProcess, SignInFailure] when sign-in fails with FirebaseAuthException',
    build: () {
      when(
        mockUserRepo.signIn(any, any),
      ).thenThrow(FirebaseAuthException(code: 'user-not-found'));
      return signInBloc;
    },
    act:
        (bloc) =>
            bloc.add(const SignInRequired('wrong@example.com', 'wrongpass')),
    expect:
        () => [SignInProcess(), const SignInFailure(message: 'user-not-found')],
  );

  blocTest<SignInBloc, SignInState>(
    'emits [SignInProcess, SignInFailure] when sign-in fails with a generic error',
    build: () {
      when(mockUserRepo.signIn(any, any)).thenThrow(Exception('Unknown error'));
      return signInBloc;
    },
    act:
        (bloc) =>
            bloc.add(const SignInRequired('error@example.com', 'password')),
    expect: () => [SignInProcess(), const SignInFailure()],
  );

  blocTest<SignInBloc, SignInState>(
    'calls signOut when SignOutRequired event is added',
    build: () {
      when(mockUserRepo.sigOut()).thenAnswer((_) async {});
      return signInBloc;
    },
    act: (bloc) => bloc.add(const SignOutRequired()),
    verify: (_) {
      verify(mockUserRepo.sigOut()).called(1);
    },
  );
}
