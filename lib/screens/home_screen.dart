import 'package:firebase_flutterbloc/fetures/authen/sign_in_bloc/sign_in_bloc.dart';
import 'package:firebase_flutterbloc/fetures/authen/sign_in_bloc/sign_in_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home", style: TextStyle(fontSize: 20)),
        actions: [
          IconButton(
            onPressed: () {
              context.read<SignInBloc>().add(SignOutRequired());
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
