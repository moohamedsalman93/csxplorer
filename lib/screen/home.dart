import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csexp/const/const.dart';
import 'package:csexp/screen/nav/ciii.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'nav/Fscreen.dart';
import 'nav/Pscreen.dart';
import 'nav/Sscreen.dart';
import 'nav/Hscreen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int ci = 0;

  final screen = [
    const Hscreen(),
    const Sscreen(),
    Fscreen(),
    Pscreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: b,
      body: Container(
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
                  child: screen[ci]))),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: ci,
          onTap: (index) => setState(
                () => ci = index,
              ),
          selectedItemColor: y,
          items: [
            BottomNavigationBarItem(
                backgroundColor: b,
                icon: const Icon(Icons.home),
                label: 'Home'),
            BottomNavigationBarItem(
                backgroundColor: b,
                icon: const Icon(Icons.search),
                label: 'Search'),
            BottomNavigationBarItem(
                backgroundColor: b,
                icon: const Icon(Icons.favorite_border),
                label: 'Fav'),
            BottomNavigationBarItem(
                backgroundColor: b,
                icon: const Icon(Icons.person_outline),
                label: 'Profile'),
          ]),
    );
  }
}
