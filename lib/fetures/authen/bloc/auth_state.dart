part of 'auth_bloc.dart';

enum AuthStateStatus { authenticated, unauthenticated, unknow }

class AuthState extends Equatable {
  const AuthState._({this.status = AuthStateStatus.unknow, this.user});
  const AuthState.unknow() : this._();
  const AuthState.authenticated(User user)
    : this._(status: AuthStateStatus.authenticated, user: user);
  const AuthState.unauthenticated()
    : this._(status: AuthStateStatus.unauthenticated);
  final AuthStateStatus status;
  final User? user;

  @override
  List<Object?> get props => [status, user];
}
