import 'package:firebase_flutterbloc/fetures/authen/service/user_repo_imp.dart';
import 'package:firebase_flutterbloc/fetures/notification/service/push_notification_helper.dart';
import 'package:firebase_flutterbloc/screens/main_app.dart';
import 'package:firebase_flutterbloc/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PushNotificationHelper.initialized();
  Bloc.observer = SimpleBlocObserver();
  runApp(MainApp(UserRepoImp()));
}

// https://www.youtube.com/watch?v=JwFiALyfD-0


// https://www.youtube.com/watch?v=bCSn7Flm33o