import 'package:csexp/route.dart' as r;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  final navigatorKey = GlobalKey<NavigatorState>();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.indigo,
          ),
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          home: r.rout()), // Wrap your app
    );
  });
}
