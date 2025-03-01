import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutterbloc/fetures/authen/service/user_repo_imp.dart';
import 'package:firebase_flutterbloc/firebase_options.dart';
import 'package:firebase_flutterbloc/screens/main_app.dart';
import 'package:firebase_flutterbloc/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Bloc.observer = SimpleBlocObserver();
  runApp(MainApp(UserRepoImp()));
}
