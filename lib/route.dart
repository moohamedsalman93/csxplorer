import 'package:csexp/const/const.dart';
import 'package:csexp/screen/home.dart';
import 'package:csexp/screen/login&signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';

class rout extends StatefulWidget {
  const rout({super.key});

  @override
  State<rout> createState() => _routState();
}

class _routState extends State<rout> {
  bool hasInternet = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() {
        this.hasInternet = hasInternet;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: b,
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (true) {
                if (snapshot.hasData) {
                  return const Home();
                } else {
                  return const LogiN();
                }
              }
              return nointer();
            }));
  }

  Widget nointer() => Container(
        color: b,
        child: Center(
          child: Column(
            children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No Internet !',
                      style: TextStyle(
                        color: wh,
                        fontSize: 20,
                      )),
                  Text(
                    'Check your Internet Connection',
                    style: TextStyle(
                      color: wh,
                      fontSize: 16.9,
                    ),
                  ),
                ],
              )),
              Lottie.asset(
                'assets/Artboard.json',
              ),
            ],
          ),
        ),
      );
}
