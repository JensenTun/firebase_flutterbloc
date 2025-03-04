import 'package:firebase_flutterbloc/fetures/authen/bloc/auth_bloc.dart';
import 'package:firebase_flutterbloc/fetures/authen/service/user_repo.dart';
import 'package:firebase_flutterbloc/fetures/product/bloc/product_bloc.dart';
import 'package:firebase_flutterbloc/screens/app_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatelessWidget {
  final UserRepo userRepo;
  const MainApp(this.userRepo, {super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(userRepo: userRepo)),
        BlocProvider(create: (context) => ProductBloc()),
      ],
      child: AppView(),
    );
  }
}
