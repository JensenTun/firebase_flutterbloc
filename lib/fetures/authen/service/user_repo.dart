import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutterbloc/fetures/authen/model/user.dart';

abstract class UserRepo {
  Stream<User?> get user;

  Future<UserModel> signUp(UserModel user, String password);
  Future<void> setUserData(UserModel user);
  Future<void> signIn(String email, String password);
  Future<void> sigOut();
}
