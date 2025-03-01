import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutterbloc/fetures/authen/service/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepo userRepo;
  late final StreamSubscription<User?> _userSubscription;

  AuthBloc({required this.userRepo}) : super(const AuthState.unknow()) {
    _userSubscription = userRepo.user.listen((user) {
      add(AuthenticationUserChanged(user));
    });
    on<AuthenticationUserChanged>((event, emit) {
      if (event.user != null) {
        emit(AuthState.authenticated(event.user!));
      } else {
        emit(const AuthState.unauthenticated());
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
