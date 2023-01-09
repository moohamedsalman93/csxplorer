import 'package:csexp/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
    const Fscreen(),
    const Pscreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
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
          child: screen[ci]),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: ci,
          onTap: (index) => setState(
                () => ci = index,
              ),
          selectedItemColor: y,
          items: const [
            BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(Icons.home),
                label: 'Home'),
            BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(Icons.search),
                label: 'Search'),
            BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(Icons.favorite_border),
                label: 'Fav'),
            BottomNavigationBarItem(
                backgroundColor: Colors.transparent,
                icon: Icon(Icons.person_outline),
                label: 'Profile'),
          ]),
    );
  }
}
