import 'package:csexp/screen/home.dart';
import 'package:csexp/screen/login&signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class rout extends StatefulWidget {
  const rout({super.key});

  @override
  State<rout> createState() => _routState();
}

class _routState extends State<rout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Home();
            } else {
              return const LogiN();
            }
          }),
    );
  }
}
