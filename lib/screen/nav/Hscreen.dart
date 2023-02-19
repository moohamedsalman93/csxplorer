import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csexp/const/auth.dart';
import 'package:csexp/const/const.dart';
import 'package:csexp/screen/body/course.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animations/animations.dart';
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
  final _isAnonymous = FirebaseAuth.instance.currentUser!.isAnonymous;

  List<String> items = [
    "Certificate",
    "Job",
    "Roadmap",
  ];
  final List<Widget> car = [
    Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, Color.fromARGB(255, 232, 0, 0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: CachedNetworkImage(
        imageUrl:
            "https://www.classcentral.com/report/wp-content/uploads/2021/12/free-certificates-banner.png",
        imageBuilder: (context, imageProvider) => Stack(
          children: [
            Container(
              width: 600,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.transparent, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              width: 600,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Container()),
                  const Text(
                    "Free Certificate",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      shadows: [
                        Shadow(
                          color: Colors.grey,
                          offset: Offset(2.0, 2.0),
                          blurRadius: 4.0,
                        )
                      ],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "From leading universities",
                    style: TextStyle(
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: b,
                          offset: const Offset(2.0, 2.0),
                          blurRadius: 4.0,
                        )
                      ],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(
            color: ly,
          ),
        ),
        errorWidget: (context, url, error) => Lottie.asset(
          'assets/noimg.json',
        ),
      ),
    ),
    CachedNetworkImage(
      imageUrl:
          "https://imgs.search.brave.com/djiHowax6UhP4qzVhB8fUGXclVwHalUz76EYoQQZK-A/rs:fit:1024:512:1/g:ce/aHR0cHM6Ly9kMzFk/bjduZnB1d2pubS5j/bG91ZGZyb250Lm5l/dC9pbWFnZXMvdmFs/b3JhY2lvbmVzLzAw/MzIvMzM3MS9GQUFO/Ry5wbmc_MTU0MjYz/NzUxMA",
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(
          color: ly,
        ),
      ),
      errorWidget: (context, url, error) => Lottie.asset(
        'assets/noimg.json',
      ),
    ),
    CachedNetworkImage(
      colorBlendMode: BlendMode.color,
      imageUrl: "https://wallpapercave.com/dwp2x/wp7692192.jpg",
      imageBuilder: (context, imageProvider) => Container(
          padding: const EdgeInsets.all(20),
          width: 600,
          decoration: BoxDecoration(
            color: b,
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Container()),
              Text(
                "Progamming",
                style: TextStyle(
                    color: wh,
                    fontSize: 20,
                    shadows: [
                      Shadow(
                        color: b,
                        offset: const Offset(2.0, 2.0),
                        blurRadius: 5.0,
                      )
                    ],
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "From top Youtubers",
                style: TextStyle(
                    color: wh,
                    shadows: [
                      Shadow(
                        color: b,
                        offset: const Offset(2.0, 2.0),
                        blurRadius: 1.0,
                      )
                    ],
                    fontWeight: FontWeight.w400),
              ),
            ],
          )),
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(
          color: ly,
        ),
      ),
      errorWidget: (context, url, error) => Lottie.asset(
        'assets/noimg.json',
      ),
    ),
  ];
  final List<Widget> car2 = [
    CachedNetworkImage(
      imageUrl:
          "https://www.classcentral.com/report/wp-content/uploads/2021/12/free-certificates-banner.png",
      imageBuilder: (context, imageProvider) => Container(
          width: 600,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [Colors.transparent, ly],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Container()),
                Text(
                  "Free Certificate",
                  style: TextStyle(
                      color: wh, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "From leading universities",
                  style: TextStyle(color: wh, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          )),
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(
          color: ly,
        ),
      ),
      errorWidget: (context, url, error) => Lottie.asset(
        'assets/noimg.json',
      ),
    ),
    CachedNetworkImage(
      imageUrl:
          "https://imgs.search.brave.com/djiHowax6UhP4qzVhB8fUGXclVwHalUz76EYoQQZK-A/rs:fit:1024:512:1/g:ce/aHR0cHM6Ly9kMzFk/bjduZnB1d2pubS5j/bG91ZGZyb250Lm5l/dC9pbWFnZXMvdmFs/b3JhY2lvbmVzLzAw/MzIvMzM3MS9GQUFO/Ry5wbmc_MTU0MjYz/NzUxMA",
      imageBuilder: (context, imageProvider) => Container(
          width: 600,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [Colors.transparent, ly],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Container()),
                Text(
                  "Job Alert",
                  style: TextStyle(
                      color: wh, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "From top MNC",
                  style: TextStyle(color: wh, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          )),
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(
          color: ly,
        ),
      ),
      errorWidget: (context, url, error) => Lottie.asset(
        'assets/noimg.json',
      ),
    ),
    CachedNetworkImage(
      imageUrl: "https://wallpapercave.com/dwp2x/wp7692192.jpg",
      imageBuilder: (context, imageProvider) => Container(
          width: 600,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [Colors.transparent, ly],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Container()),
                Text(
                  "Progamming",
                  style: TextStyle(
                      color: wh, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "From top Youtubers",
                  style: TextStyle(color: wh, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          )),
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(
          color: ly,
        ),
      ),
      errorWidget: (context, url, error) => Lottie.asset(
        'assets/noimg.json',
      ),
    ),
  ];

  /// List of body icon
  List temp = [];
  List Rbased = [];
  List Sbased = [];
  late List<Widget> title = [
    Certificate(
      temp: temp,
    ),
    const Job(),
    Roadmap(
      Rbased: Rbased,
      Sbased: Sbased,
    )
  ];
  int current = 0;
  int i = 0;

  Auth a = Auth();

  @override
  void initState() {
    super.initState();
    if (!_isAnonymous) {
      getfire();
    }
    getfire2();
  }

  getfire() async {
    var sa = await FirebaseFirestore.instance
        .collection('user')
        .doc(user.toString())
        .collection('fav')
        .get();
    setState(() {
      temp = sa.docs.map((e) => e.data()['title']).toList();
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
        .where('under', isEqualTo: 'Sbased')
        .get();
    setState(() {
      Rbased = rbased.docs.map((e) => e.data()['title']).toList();
      Sbased = sbased.docs.map((e) => e.data()['title']).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isTab(BuildContext context) =>
        MediaQuery.of(context).size.width >= 600;
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 70,
              child: Wrap(
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
          ),
          CarouselSlider(
            items: isTab(context) ? car : car2,
            options: CarouselOptions(
              height: isTab(context) ? 300 : 200,
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
                  return OpenContainer(
                      transitionDuration: const Duration(milliseconds: 400),
                      openColor: ly,
                      closedColor: Colors.transparent,
                      middleColor: ly,
                      closedShape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      openShape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      openBuilder: (context, _) => title[index],
                      closedBuilder: (context, VoidCallback openContainer) =>
                          GestureDetector(
                            onTap: () {
                              openContainer();
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              height: 40,
                              decoration: BoxDecoration(
                                  color: wh.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: wh.withOpacity(0.3), width: 0.8)),
                              child: Center(
                                child: Text(
                                  items[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500, color: wh),
                                ),
                              ),
                            ),
                          ));
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

  Widget head(t, t2) => OpenContainer(
        transitionDuration: const Duration(milliseconds: 400),
        openColor: ly,
        closedColor: Colors.transparent,
        middleColor: ly,
        closedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        openShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        openBuilder: (context, _) => course(
          title: t2,
          text: t,
        ),
        closedBuilder: (context, VoidCallback openContainer) => Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent),
            child: Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    splashColor: ly,
                    onTap: () {
                      openContainer();
                    },
                    child: Ink(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              t,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: ly,
                            )
                          ],
                        ))))),
      );
}
