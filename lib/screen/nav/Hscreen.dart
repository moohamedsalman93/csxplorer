import 'package:csexp/const/auth.dart';
import 'package:csexp/const/const.dart';
import 'package:csexp/const/shimmer.dart';
import 'package:csexp/screen/body/course.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';

import '../body/Roadmap.dart';
import '../body/ceritificate.dart';
import '../body/job.dart';

class Hscreen extends StatefulWidget {
  const Hscreen({super.key});

  @override
  State<Hscreen> createState() => _HscreenState();
}

class _HscreenState extends State<Hscreen> {
  final user = FirebaseAuth.instance.currentUser!.uid;
  List<String> items = [
    "Certificate",
    "Job",
    "Roadmap",
  ];
  final List<Widget> car = [
    Container(
      decoration:
          BoxDecoration(color: b, borderRadius: BorderRadius.circular(10)),
    ),
    Container(
      decoration:
          BoxDecoration(color: y, borderRadius: BorderRadius.circular(10)),
    ),
    Container(
      decoration:
          BoxDecoration(color: ly, borderRadius: BorderRadius.circular(10)),
    ),
  ];
  bool ischecked = false;

  /// List of body icon
  List<IconData> icons = [
    Icons.explore,
    Icons.search,
    Icons.feed,
  ];
  List temp = [];
  List Rbased = [];
  List Sbased = [];
  late List<Widget> title = [
    Certificate(
      temp: temp,
    ),
    Job(),
    Roadmap(Rbased:Rbased,Sbased:Sbased,)
  ];
  int current = 0;
  int i = 0;

  Auth a = Auth();

  @override
  void initState() {
    super.initState();
    getfire();
    getfire2();
  }

  getfire() async {
    var sa = await FirebaseFirestore.instance
        .collection('user')
        .doc(user.toString())
        .collection('fav')
        .get();
    setState(() {
      temp = sa.docs.map((e) => e.data()['productId']).toList();
    });
    print(temp);
  }

  getfire2() async {
    var rbased = await FirebaseFirestore.instance
        .collection('Roadmap')
        .where('under', isEqualTo: 'Rbased')
        .get();
    var sbased = await FirebaseFirestore.instance
        .collection('Roadmap')
        .where('under', isEqualTo: 'Rbased')
        .get();
    setState(() {
      Rbased = rbased.docs.map((e) => e.data()['title']).toList();
      Sbased = sbased.docs.map((e) => e.data()['title']).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: wh),
                        borderRadius: BorderRadiusDirectional.circular(30),
                        image: const DecorationImage(
                          image: AssetImage('assets/favicon.png'),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(
                        "Welcome salman",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: wh,
                            fontFamily: 'Montserrat',
                            fontSize: 20),
                      ),
                    )),
                Expanded(flex: 1, child: Container())
              ],
            ),
          ),
          CarouselSlider(
            items: car,
            options: CarouselOptions(
              height: 200,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.linearToEaseOut,
              enlargeCenterPage: true,
              enlargeFactor: 0.2,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: double.infinity,
            height: 50,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: items.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => title[index]));
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                              color: y,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: wh, width: 1)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(icons[index], color: wh),
                                Text(
                                  items[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500, color: wh),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),

          /// MAIN BODY
          Container(
              margin: const EdgeInsets.only(top: 5),
              width: double.infinity,
              color: Colors.transparent,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  head("programming", "Programming"),
                  head("Adobe", "adobe"),
                  head("Game development", "game"),
                  head("Office", "microsoft"),
                  head("UI/UX", "ui"),
                  head("Animation", "animation"),
                  head("Cloud", "cloud"),
                ],
              ))
        ]),
      ),
    );
  }

  Widget head(t, t2) => Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(t,
                style: const TextStyle(
                  fontSize: true ? 18 : 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => course(
                          title: t2,
                          text: t,
                        )));
              },
              child: Text(
                'View',
                style: TextStyle(color: ly),
              ),
            )
          ],
        ),
      );
}
