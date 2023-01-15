import 'package:csexp/const/auth.dart';
import 'package:csexp/const/const.dart';
import 'package:flutter/material.dart';

class Pscreen extends StatefulWidget {
  const Pscreen({super.key});

  @override
  State<Pscreen> createState() => _PscreenState();
}

class _PscreenState extends State<Pscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 120,
              width: 120,
              color: b,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Mohamed salman",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: wh,
                  fontFamily: 'Montserrat',
                  fontSize: 20)),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: y),
              child: Material(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                  child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      splashColor: b,
                      onTap: () {
                        Auth a = Auth();
                        a.signOut();
                      },
                      child: Ink(
                          height: 38,
                          width: 176,
                          child: const Center(
                              child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )))))),
        ],
      ),
    );
  }
}
