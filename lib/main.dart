import 'package:csexp/route.dart' as r;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MaterialApp(
        debugShowCheckedModeBanner: false, home: r.rout()), // Wrap your app
  );
}
