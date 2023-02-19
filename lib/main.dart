import 'dart:ui';

import 'package:csexp/const/const.dart';
import 'package:csexp/route.dart' as r;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

Future<void> main() async {
  final navigatorKey = GlobalKey<NavigatorState>();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.indigo,
          ),
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          home: const Splash()), // Wrap your app
    );
  });
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bgggg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 15,
              sigmaY: 15,
            ),
            child: Container(
                height: h,
                width: w,
                color: b.withOpacity(0.6),
                child: AnimatedSplashScreen(
                    duration: 1000,
                    splash: Column(
                      children: [
                        Text(
                          "CS",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ly,
                              fontFamily: 'Montserrat',
                              fontSize: 30),
                        ),
                        Text(
                          "explorer",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: wh,
                              fontFamily: 'Montserrat',
                              fontSize: 28),
                        ),
                      ],
                    ),
                    nextScreen: r.rout(),
                    splashTransition: SplashTransition.fadeTransition,
                    backgroundColor: Colors.transparent))));
  }
}
