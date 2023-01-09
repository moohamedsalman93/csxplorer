import 'package:csexp/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
          
        ],
      ),
    );
  }
}
