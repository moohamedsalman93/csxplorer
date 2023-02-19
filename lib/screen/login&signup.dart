import 'dart:ui';
import 'package:csexp/screen/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:csexp/const/auth.dart';
import 'package:csexp/const/const.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LogiN extends StatefulWidget {
  const LogiN({super.key});

  @override
  State<LogiN> createState() => _LogiNState();
}

class _LogiNState extends State<LogiN> {
  bool _isVisible = false;
  final email = TextEditingController();
  final pass = TextEditingController();
  Auth a = Auth();
  bool hasInternet = true;

  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: b,
        body: Container(
          decoration: BoxDecoration(
            color: b,
            image: const DecorationImage(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  //skip
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Row(
                      children: [
                        Expanded(child: Container()),
                        GestureDetector(
                          onTap: () async {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => Center(
                                      child: Lottie.asset(
                                        'assets/loading.json',
                                        width: 300,
                                        height: 300,
                                      ),
                                    ));
                            await FirebaseAuth.instance.signInAnonymously();
                            Navigator.of(context).pop();
                          },
                          child: Wrap(
                            children: [
                              Text(
                                "skip ",
                                style: TextStyle(color: ly, fontSize: 18),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: wh.withOpacity(0.3),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: w,
                    height: h - 70,
                    child: Column(
                      children: [
                        const Expanded(flex: 2, child: SizedBox()),
                        SizedBox(
                          height: 83,
                          width: 187,
                          child: Column(
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
                        ),
                        const Expanded(flex: 1, child: SizedBox()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            "Learn to Code Free for Everyone",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: wh.withOpacity(0.7),
                                fontFamily: 'Montserrat',
                                fontSize: 12),
                          ),
                        ),
                        const Expanded(flex: 1, child: SizedBox()),
                        //email
                        SizedBox(
                          height: 51,
                          width: 292,
                          child: TextField(
                            cursorColor: wh,
                            controller: email,
                            style: TextStyle(
                                fontFamily: font,
                                fontWeight: FontWeight.w700,
                                color: wh.withOpacity(0.7),
                                fontSize: 15),
                            decoration: InputDecoration(
                                labelStyle:
                                    TextStyle(color: wh.withOpacity(0.7)),
                                labelText: 'Email ',
                                focusColor: wh,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  borderSide: BorderSide(
                                    color: wh,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  borderSide: BorderSide(
                                    color: wh,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  borderSide: BorderSide(
                                    color: wh,
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        //pass
                        SizedBox(
                          height: 51,
                          width: 292,
                          child: TextField(
                            cursorColor: wh,
                            controller: pass,
                            style: TextStyle(
                                color: wh.withOpacity(0.7),
                                fontSize: 15,
                                fontFamily: font,
                                fontWeight: FontWeight.w700),
                            obscureText: _isVisible ? false : true,
                            decoration: InputDecoration(
                                helperStyle:
                                    TextStyle(color: wh.withOpacity(0.7)),
                                labelStyle:
                                    TextStyle(color: wh.withOpacity(0.7)),
                                labelText: 'Password ',
                                hintStyle:
                                    TextStyle(color: wh.withOpacity(0.7)),
                                focusColor: wh,
                                suffixIcon: IconButton(
                                    onPressed: () => updateStatus(),
                                    icon: Icon(
                                        color: y,
                                        _isVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  borderSide: BorderSide(
                                    color: wh,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  borderSide: BorderSide(
                                    color: wh,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  borderSide: BorderSide(
                                    color: wh,
                                  ),
                                )),
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () async {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => Center(
                                      child: Lottie.asset(
                                        'assets/loading.json',
                                        width: 300,
                                        height: 300,
                                      ),
                                    ));
                            if (email.text == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Enter email first"),
                                ),
                              );
                              Navigator.of(context).pop();
                            } else {
                              await a.sendPasswordResetEmail(
                                  email: email.text, context: context);
                            }
                          },
                          child: SizedBox(
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
                        ),
                        const Expanded(flex: 1, child: SizedBox()),
                        //login
                        Container(
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
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) => Center(
                                                child: Lottie.asset(
                                                  'assets/loading.json',
                                                  width: 300,
                                                  height: 300,
                                                ),
                                              ));
                                      if (email.text == '' && pass.text == '') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                "enter email and password properly"),
                                          ),
                                        );
                                        Navigator.of(context).pop();
                                      } else {
                                        await a.signin(
                                            e: email.text,
                                            p: pass.text,
                                            context: context);
                                      }
                                    },
                                    child: Ink(
                                        height: 38,
                                        width: 176,
                                        child: const Center(
                                            child: Text(
                                          "Login",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        )))))),
                        const Expanded(flex: 1, child: SizedBox()),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Signup()));
                          },
                          child: Text("Create new account !",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: ly,
                                  fontFamily: 'Montserrat',
                                  fontSize: 15)),
                        ),
                        const Expanded(flex: 5, child: SizedBox()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
