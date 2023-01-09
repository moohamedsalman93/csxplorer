import 'package:csexp/const/const.dart';
import 'package:flutter/material.dart';
import 'package:pixel_perfect/pixel_perfect.dart';

class PrePage extends StatefulWidget {
  const PrePage({super.key});

  @override
  State<PrePage> createState() => _PrePageState();
}

class _PrePageState extends State<PrePage> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return PixelPerfect(
        assetPath: 'assets/preferencepage.png',
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
                  Color.fromRGBO(140, 83, 253, 0),
                  Color.fromRGBO(140, 83, 253, 0.31),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              child: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                        flex: 3,
                        child: SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "What’s your preferences ?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: wh,
                                    fontFamily: font,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Text(
                                  "Tap the circles below which intrest’s you like to get recmendation",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: wh.withOpacity(0.7),
                                      fontFamily: 'Montserrat',
                                      fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 17,
                        child: Container(
                          color: Colors.transparent,
                          child: Stack(
                            children: [
                              Positioned(
                                  top: 20.0,
                                  left: 72.0,
                                  child: c1(true, 'adobe', 'coding.png')),
                              Positioned(top: 38.0, left: 210.0, child: c7(wh)),
                              Positioned(
                                  top: 119.0, left: 124.0, child: c13(wh)),
                              Positioned(
                                  top: 135.0,
                                  left: 266.0,
                                  child: c1(false, 'AI', 'advanced.png')),
                              Positioned(top: 219.0, left: 60.0, child: c7(wh)),
                              Positioned(top: 219.0, left: 60.0, child: c7(wh)),
                              Positioned(
                                  top: 255.0, left: 227.0, child: c7(wh)),
                              Positioned(
                                  top: 291.0, left: 92.0, child: c13(wh)),
                              Positioned(
                                  top: 343.0,
                                  left: 250.0,
                                  child: c1(false, 'Cloud', 'cloud.png')),
                              Positioned(
                                  top: 425.0, left: 186.0, child: c7(wh)),
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: SizedBox(
                          child: Center(
                            child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: y),
                                child: Material(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.transparent,
                                    child: InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        splashColor: b,
                                        onTap: () async {
                                          // Navigator.of(context).push(
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             const login()));
                                        },
                                        child: Ink(
                                            height: 38,
                                            width: 176,
                                            child: const Center(
                                                child: Text(
                                              "Next",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            )))))),
                          ),
                        )),
                  ],
                ),
              ),
            )));
  }

  Widget c1(c, t, ic) => Container(
        width: 100,
        height: 100,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: c ? wh : y,
          shape: BoxShape.circle,
        ),
        child: Column(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icony/$ic'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Text(t)
          ],
        ),
      );
  Widget c7(c) => Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: c,
          shape: BoxShape.circle,
        ),
      );
  Widget c13(c) => Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          color: c,
          shape: BoxShape.circle,
        ),
      );
}
