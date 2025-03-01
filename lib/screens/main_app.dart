import 'package:firebase_flutterbloc/fetures/authen/bloc/auth_bloc.dart';
import 'package:firebase_flutterbloc/fetures/authen/service/user_repo.dart';
import 'package:firebase_flutterbloc/screens/app_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatelessWidget {
  final UserRepo userRepo;
  const MainApp(this.userRepo, {super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(userRepo: userRepo),
      child: AppView(),
    );
  }
}
