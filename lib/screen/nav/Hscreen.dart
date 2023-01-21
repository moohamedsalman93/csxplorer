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

class Hscreen extends StatefulWidget {
  const Hscreen({super.key});

  @override
  State<Hscreen> createState() => _HscreenState();
}

class _HscreenState extends State<Hscreen> {
  final user = FirebaseAuth.instance.currentUser!.uid;
  List<String> items = [
    "Course",
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
    Icons.home,
    Icons.explore,
    Icons.search,
    Icons.feed,
  ];
  late List<Widget> title = [Course(), Certificate(), Job(), Roadmap()];
  int current = 0;
  int i = 0;
  List temp = [];

  Auth a = Auth();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getfire();
    print(temp);
  }

  addfire(t) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user.toString())
        .collection('fav')
        .doc(t)
        .set({"productId": t});
  }

  delfire(t) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user.toString())
        .collection('fav')
        .doc(t)
        .delete();
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
                          setState(() {
                            current = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                            color: current == index ? y : b,
                            borderRadius: BorderRadius.circular(20),
                            border: current == index
                                ? Border.all(color: wh, width: 1)
                                : Border.all(
                                    color: wh.withOpacity(0.3), width: 1),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(icons[index],
                                    color: current == index ? wh : y),
                                Text(
                                  items[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: current == index ? wh : y),
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
              child: title[current])
        ]),
      ),
    );
  }

  Widget Course() => Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          head("programming","programming"),
          head("Adobe","adobe"),
          head("Game development","game"),
          head("Office","microsoft"),
          head("UI/UX","ui"),
          head("Animation","animation"),
          head("Cloud","cloud"),
        ],
      );

  Widget Certificate() => StreamBuilder(
      stream: FirebaseFirestore.instance.collection('all').snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Text("Something went Wrong",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: wh, fontSize: 30)));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
                color: ly,
              ),
            ),
          );
        }
        return GridView.builder(
            padding: const EdgeInsets.all(15),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: true ? 2 : 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 230,
              childAspectRatio: 1,
            ),
            itemCount: snapshot.data!.docs.length,
            primary: false,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              QueryDocumentSnapshot x = snapshot.data.docs[i];
              return Container(
                margin: const EdgeInsets.all(5),
                width: 164,
                height: 244,
                decoration: BoxDecoration(
                  color: b,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: wh.withOpacity(0.3), width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CachedNetworkImage(
                      imageUrl: x['img'],
                      imageBuilder: (context, imageProvider) => Container(
                        height: 124,
                        width: 154,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: wh.withOpacity(0.3), width: 1),
                          image: DecorationImage(
                            image: imageProvider,
                          ),
                        ),
                      ),
                      // placeholder:
                      //     (context, url) =>
                      //         mainimg(
                      //   h * 0.14,
                      //   w * 0.7,
                      // ),
                      // errorWidget:
                      //     (context, url, error) =>
                      //         Lottie.asset(
                      //   'assets/noimg.json',
                      //   width: w * 0.8,
                      //   height: h * 0.15,
                      // ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(x['title'],
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 30,
                          width: 70,
                          decoration: BoxDecoration(
                              color: y, borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text('Open',
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: wh,
                                )),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            });
      });
  Widget Job() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text("Recent",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ),
        const SizedBox(height: 10),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('job')
                .orderBy('date', descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Text("Something went Wrong",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: wh,
                            fontSize: 30)));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                      color: ly,
                    ),
                  ),
                );
              }
              return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: snapshot.data!.docs.length,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    QueryDocumentSnapshot x = snapshot.data.docs[i];

                    return Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                      decoration: BoxDecoration(
                        color: b,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 4,
                            offset: const Offset(0, 0),
                          )
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            splashColor: ly,
                            onTap: () => _link(x['link']),
                            child: Ink(
                              height: 350,
                              padding: const EdgeInsets.only(
                                  right: 20, left: 20, top: 15, bottom: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //dp
                                  Container(
                                    width: 330,
                                    height: 200,
                                    color: wh,
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: x['img'],

                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: 300,
                                        height: 300,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: imageProvider,
                                          ),
                                        ),
                                      ),
                                      // placeholder: (context, url) =>
                                      //     courseimg(h, w),
                                      // errorWidget:
                                      //     (context, url, error) =>
                                      //         Lottie.asset(
                                      //   'assets/noimg.json',
                                      // ),
                                    ),
                                  ),
                                  //title and button
                                  Text(x['title'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      )),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(x['date'],
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            )),
                                      ),
                                      Wrap(
                                        children: [
                                          Center(
                                            child: Text('Open',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: ly,
                                                )),
                                          ),
                                          Center(
                                            child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: ly,
                                              size: 20,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            )),
                      ),
                    );
                  });
            })
      ]);

  _link(String url) async {
    if (await canLaunch(url)) {
      final bool nativeAppLaunchSucceeded = await launch(
        url,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!nativeAppLaunchSucceeded) {
        await launch(url, forceSafariVC: true);
      }
    }
  }

  Widget Roadmap() => Container();

  Widget head(t,t2) => Padding(
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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>  course(title: t2,text: t,)));
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
