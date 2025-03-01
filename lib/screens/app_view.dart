import 'package:firebase_flutterbloc/fetures/authen/bloc/auth_bloc.dart';
import 'package:firebase_flutterbloc/fetures/authen/sign_in_bloc/sign_in_bloc.dart';
import 'package:firebase_flutterbloc/screens/home_screen.dart';
import 'package:firebase_flutterbloc/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          background: Colors.white,
          onBackground: Colors.black,
          primary: Color.fromRGBO(206, 147, 216, 1),
          onPrimary: Colors.black,
          secondary: Color.fromRGBO(244, 143, 177, 1),
          onSecondary: Colors.white,
          tertiary: Color.fromRGBO(255, 204, 128, 1),
          error: Colors.red,
          outline: Color(0xFF424242),
        ),
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state.status == AuthStateStatus.authenticated) {
            return BlocProvider(
              create:
                  (context) =>
                      SignInBloc(userRepo: context.read<AuthBloc>().userRepo),
              child: HomeScreen(),
            );
          } else {
            return WelcomeScreen();
          }
        },
      ),
    );
  }
}
