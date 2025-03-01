import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutterbloc/fetures/authen/service/user_repo.dart';
import 'package:firebase_flutterbloc/fetures/authen/sign_in_bloc/sign_in_event.dart';
import 'package:firebase_flutterbloc/fetures/authen/sign_in_bloc/sign_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepo _userRepo;
  SignInBloc({required UserRepo userRepo})
    : _userRepo = userRepo,
      super(SignInInitial()) {
    on<SignInRequired>((event, emit) async {
      emit(SignInProcess());
      try {
        await _userRepo.signIn(event.email, event.password);

        emit(SignInSuccess());
      } on FirebaseAuthException catch (e) {
        emit(SignInFailure(message: e.code));
      } catch (e) {
        emit(SignInFailure());
      }
    });

    on<SignOutRequired>((event, emit) async {
      await _userRepo.sigOut();
    });
  }
}
