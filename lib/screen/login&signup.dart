import 'dart:ui';

import 'package:csexp/const/const.dart';
import 'package:csexp/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LogiN extends StatefulWidget {
  const LogiN({super.key});

  @override
  State<LogiN> createState() => _LogiNState();
}

class _LogiNState extends State<LogiN> {
  bool _isVisible = false;
  bool _isRem = false;

  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return PixelPerfect(
        assetPath: 'assets/Login.png',
        scale: 4.7,
        child: Scaffold(
          backgroundColor: b,
          body: Container(
            height: h,
            width: w,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color.fromRGBO(140, 83, 253, 0.31),
                Color.fromRGBO(140, 83, 253, 0)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(flex: 7, child: SizedBox()),
                SizedBox(
                  height: 83,
                  width: 187,
                  //color: b,
                  child: Image.asset(
                    'assets/logo.png',
                    height: 150,
                    scale: 4,
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "this app is developed for the learn and gain knowlage and which can able to find everything here  ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: wh.withOpacity(0.7),
                        fontFamily: 'Montserrat',
                        fontSize: 12),
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox()),
                SizedBox(
                  height: 51,
                  width: 292,
                  child: TextField(
                    style: TextStyle(
                        fontFamily: font,
                        color: wh.withOpacity(0.7),
                        fontSize: 15),
                    decoration: InputDecoration(
                        labelStyle: TextStyle(color: wh.withOpacity(0.7)),
                        labelText: 'User name :',
                        focusColor: wh,
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: wh,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: wh,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: wh,
                          ),
                        )),
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox()),
                SizedBox(
                  height: 51,
                  width: 292,
                  child: TextField(
                    style: TextStyle(
                        color: wh.withOpacity(0.7),
                        fontSize: 15,
                        fontFamily: font),
                    obscureText: _isVisible ? false : true,
                    decoration: InputDecoration(
                        helperStyle: TextStyle(color: wh.withOpacity(0.7)),
                        labelStyle: TextStyle(color: wh.withOpacity(0.7)),
                        labelText: 'Password :',
                        hintStyle: TextStyle(color: wh.withOpacity(0.7)),
                        focusColor: wh,
                        suffixIcon: IconButton(
                            onPressed: () => updateStatus(),
                            icon: Icon(
                                color: y,
                                _isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: wh,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: wh,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: wh,
                          ),
                        )),
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox()),
                SizedBox(
                  width: 292,
                  child: GestureDetector(
                    child: Text(
                      "Recovery password?",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: wh.withOpacity(0.7),
                          fontFamily: 'Montserrat',
                          fontSize: 12),
                    ),
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox()),
                SizedBox(
                  width: 292,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isRem = !_isRem;
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                            _isRem
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: _isRem ? y : wh),
                        Text(
                          "Remember me !",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: wh.withOpacity(0.7),
                              fontFamily: 'Montserrat',
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox()),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: y),
                    child: Material(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                        child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            splashColor: b,
                            onTap: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Home()));
                            },
                            child: Ink(
                                height: 38,
                                width: 176,
                                child: const Center(
                                    child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )))))),
                const Expanded(flex: 1, child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      Container(
                        child: CustomPaint(
                          size: const Size(98, 2),
                          painter: CurvePainter(),
                        ),
                      ),
                      Text(
                        "Or Continue with",
                        style: TextStyle(
                            color: wh,
                            fontFamily: font,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      Container(
                        child: CustomPaint(
                          size: const Size(98, 2),
                          painter: CurvePainter(),
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox()),
                Row(
                  children: [
                    const Expanded(flex: 2, child: SizedBox()),
                    Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Material(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(30),
                              splashColor: y,
                              onTap: () async {
                                // Navigator.of(context).push(
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const login()));
                              },
                              child: Image.asset(
                                'assets/g.png',
                                height: 40,
                                scale: 4,
                              ),
                            ))),
                    const Expanded(flex: 1, child: SizedBox()),
                    Text(
                      "OR",
                      style: TextStyle(
                          color: wh,
                          fontFamily: font,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    const Expanded(flex: 1, child: SizedBox()),
                    Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Material(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(30),
                              splashColor: y,
                              onTap: () async {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Home()));
                              },
                              child: Image.asset(
                                'assets/f.png',
                                height: 40,
                                scale: 4,
                              ),
                            ))),
                    const Expanded(flex: 2, child: SizedBox()),
                  ],
                ),
                const Expanded(flex: 7, child: SizedBox()),
              ],
            ),
          ),
        ));
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = wh;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, 0);
    path.quadraticBezierTo(size.width / 2, size.height / 2, size.width, 0);
    path.quadraticBezierTo(size.width / 2, -size.height / 2, 0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
