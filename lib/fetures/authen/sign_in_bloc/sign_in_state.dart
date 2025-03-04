// part of 'sign_in_state.dart';

import 'package:equatable/equatable.dart';

sealed class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

class SignInInitial extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInFailure extends SignInState {
  final String? message;
  const SignInFailure({this.message});
}

class SignInProcess extends SignInState {}
