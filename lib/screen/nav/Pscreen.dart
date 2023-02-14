import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csexp/const/auth.dart';
import 'package:csexp/const/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:share_plus/share_plus.dart';

class Pscreen extends StatefulWidget {
  const Pscreen({super.key});

  @override
  State<Pscreen> createState() => _PscreenState();
}

class _PscreenState extends State<Pscreen> {
  String selectedValue = 'student';
  final user = FirebaseAuth.instance.currentUser!.uid;
  final _isAnonymous = FirebaseAuth.instance.currentUser!.isAnonymous;
  List temp = [];
  bool isl = false;

  @override
  void initState() {
    super.initState();
    if (!_isAnonymous) {
      getfire();
    }
  }

  getfire() async {
    var sa = await FirebaseFirestore.instance
        .collection('user')
        .where("uid", isEqualTo: user.toString())
        .get();
    setState(() {
      temp = sa.docs.map((e) => e.data()).toList();
      isl = true;
      selectedValue = temp[0]['under'];
    });
    print(temp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            height: 80,
            child: Text(
              "Profile",
              style: TextStyle(color: wh, fontSize: 30),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      color: wh, borderRadius: BorderRadius.circular(100)),
                  child: const FittedBox(
                      child: Center(child: Icon(Icons.person_outline_sharp))),
                ),
                const SizedBox(
                  height: 20,
                ),
                // ignore: unnecessary_null_comparison
                isl
                    ? Text(temp[0]['name'],
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: wh,
                            fontFamily: 'Montserrat',
                            fontSize: 20))
                    : Text("Guest",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: wh,
                            fontFamily: 'Montserrat',
                            fontSize: 20)),
                DropdownButton<String>(
                  items: [
                    DropdownMenuItem(
                      value: 'student',
                      child: Text("Student",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: ly,
                              fontFamily: 'Montserrat',
                              fontSize: 20)),
                    ),
                    DropdownMenuItem(
                      value: 'professional',
                      child: Text("Professional",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: ly,
                              fontFamily: 'Montserrat',
                              fontSize: 20)),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value!;

                      FirebaseFirestore.instance
                          .collection('user')
                          .doc(user.toString())
                          .update({
                        'under': value,
                      });
                    });
                  },
                  value: selectedValue,
                ),
                const SizedBox(
                  height: 20,
                ),
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
                                child: Center(
                                    child: Text(
                                  _isAnonymous ? "Sign In" : "Sign Out",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )))))),
              ],
            ),
          ),
          const Expanded(
            child: SizedBox(
              height: 20,
            ),
          ),
          open("About Us", ''),
          open("Privacy policies",
              'https://github.com/moohamedsalman93/lastbenchers-privacy/blob/main/privacy-policy.md'),
          share("Share this app")
        ],
      ),
    );
  }

  Widget open(t, tt) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.transparent),
      child: Material(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
          child: InkWell(
              borderRadius: BorderRadius.circular(10),
              splashColor: ly,
              onTap: () {
                jandr(tt);
              },
              child: Ink(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        t,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.open_in_new_rounded,
                        color: wh.withOpacity(0.3),
                      )
                    ],
                  )))));

  Widget share(t) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.transparent),
      child: Material(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
          child: InkWell(
              borderRadius: BorderRadius.circular(10),
              splashColor: ly,
              onTap: () {
                Share.share('This is an example of sharing text');
              },
              child: Ink(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        t,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.share,
                        color: wh.withOpacity(0.3),
                      )
                    ],
                  )))));
}
