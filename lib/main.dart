import 'package:csexp/screen/home.dart';
import 'package:csexp/screen/login&signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screen/preferencepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MaterialApp(
        debugShowCheckedModeBanner: false, home: Home()), // Wrap your app
  );
}
