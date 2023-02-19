import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../const/auth.dart';
import '../../const/const.dart';

class Certificate extends StatefulWidget {
  List temp;
  Certificate({super.key, required this.temp});

  @override
  State<Certificate> createState() => _CertificateState();
}

class _CertificateState extends State<Certificate> {
  late ScrollController _scrollController;
  Color appBarColor = Colors.transparent;
  late final PageController pageController;
  int pageNo = 0;
  List temp = [];
  final user = FirebaseAuth.instance.currentUser!.uid;
  final _isAnonymous = FirebaseAuth.instance.currentUser!.isAnonymous;
  Auth a = Auth();
  bool s1 = true;
  bool s2 = true;
  bool s3 = true;
  List d = ["freebootcamp", "LinkedIn"];
  List d1 = ["Google", "Microsoft"];
  List d2 = ["Harvard university"];

  addfire(t, t2, u) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user.toString())
        .collection('fav')
        .doc(t)
        .set({"title": t, 'under': 'certificate', 'by': t2, 'url': u});
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
        .where('under', isEqualTo: 'certificate')
        .get();
    setState(() {
      temp = sa.docs.map((e) => e.data()['title']).toList();
    });
    print(temp);
  }

  Widget _certi(t, isTab) => StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('certificate')
          .where('under', isEqualTo: t)
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Text("Something went Wrong",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: y, fontSize: 30)));
        } else if (snapshot.hasData) {
          return PageView.builder(
            controller: pageController,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (_, index) {
              QueryDocumentSnapshot x = snapshot.data.docs[index];
              return AnimatedBuilder(
                animation: pageController,
                builder: (ctx, child) {
                  return child!;
                },
                child: Container(
                  width: 300,
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.only(
                      right: 8, left: 8, top: 24, bottom: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: wh.withOpacity(0.1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(x['title'],
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            )),
                      ),
                      Text(x['by'],
                          softWrap: false,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: y,
                          )),
                      Expanded(child: Container()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                                      onTap: () => _link(x['url']),
                                      child: Ink(
                                          height: 38,
                                          width: 120,
                                          child: const Center(
                                              child: Text(
                                            "Open",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          )))))),
                          IconButton(
                              onPressed: () {
                                if (!_isAnonymous) {
                                  if (temp.contains(x['title'])) {
                                    delfire(x['title']);
                                    getfire();
                                    setState(() {});
                                  } else {
                                    addfire(x['title'], x['by'], x['url']);
                                    getfire();
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Not avail on Anonymous user"),
                                    ),
                                  );
                                }
                              },
                              icon: Icon(
                                temp.contains(x['title'])
                                    ? Icons.favorite
                                    : Icons.favorite_border_rounded,
                                color:
                                    temp.contains(x['title']) ? Colors.red : wh,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
        return SizedBox(
          height: 500,
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              color: y,
            ),
          ),
        );
      });

  Widget _certi2(t, t2) => StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('certificate')
          .where('under', isEqualTo: t)
          .where('by', isEqualTo: t2)
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Text("Something went Wrong",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: y, fontSize: 30)));
        } else if (snapshot.hasData) {
          return PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: pageController,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (_, index) {
              QueryDocumentSnapshot x = snapshot.data.docs[index];
              return AnimatedBuilder(
                animation: pageController,
                builder: (ctx, child) {
                  return child!;
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.only(
                      right: 8, left: 8, top: 24, bottom: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: y.withOpacity(0.3),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Wrap(children: [
                          Text(x['title'],
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              )),
                        ]),
                      ),
                      Text(x['by'],
                          softWrap: false,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: wh.withOpacity(0.3),
                          )),
                      Expanded(child: Container()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: wh.withOpacity(0.1)),
                              child: Material(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.transparent,
                                  child: InkWell(
                                      borderRadius: BorderRadius.circular(10),
                                      splashColor: y,
                                      onTap: () => _link(x['url']),
                                      child: Ink(
                                          height: 38,
                                          width: 120,
                                          child: Center(
                                              child: Text(
                                            "Open",
                                            style: TextStyle(
                                                color: wh, fontSize: 18),
                                          )))))),
                          IconButton(
                              onPressed: () {
                                if (temp.contains(x['title'])) {
                                  delfire(x['title']);
                                  getfire();
                                  setState(() {});
                                } else {
                                  addfire(x['title'], x['by'], x['url']);
                                  getfire();
                                }
                              },
                              icon: Icon(
                                temp.contains(x['title'])
                                    ? Icons.favorite
                                    : Icons.favorite_border_rounded,
                                color:
                                    temp.contains(x['title']) ? Colors.red : wh,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
        return SizedBox(
          height: 500,
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              color: y,
            ),
          ),
        );
      });

  Widget largecon(t, t2, isTab) => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: t2.length,
        itemBuilder: (BuildContext context, int index) {
          return wrp(t, t2[index], isTab);
        },
      );

  Widget wrp(t, t2, isTab) => Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(t2,
                style: const TextStyle(
                  fontSize: true ? 15 : 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(height: isTab ? 300 : 200, child: _certi2(t, t2)),
          const SizedBox(
            height: 12.0,
          ),
        ],
      );

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: 0, viewportFraction: 0.7);
    if (!_isAnonymous) {
      temp = widget.temp;
      print(temp);
      setState(() {});
    }
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset >= 50) {
        setState(() {
          appBarColor = wh.withOpacity(0.1);
        });
      } else {
        setState(() {
          appBarColor = Colors.transparent;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    bool isTab(BuildContext context) =>
        MediaQuery.of(context).size.width >= 600;

    size() {
      return isTab(context) ? 250.0 : 200.0;
    }

    size2() {
      return isTab(context) ? 650.0 : 500.0;
    }

    return Scaffold(
        backgroundColor: b,
        body: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollUpdateNotification) {
              if (_scrollController.offset >= 50) {
                setState(() {
                  appBarColor = ly.withOpacity(0.3);
                });
              } else {
                setState(() {
                  appBarColor = Colors.transparent;
                });
              }
            }
            return false;
          },
          child: Container(
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
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 120,
                              ),
                              //learning platforms
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text("Learning Platform",
                                        style: TextStyle(
                                          fontSize: true ? 18 : 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        )),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          s1 = !s1;
                                          s2 = true;
                                          s3 = true;
                                        });
                                      },
                                      icon: Icon(
                                        s1
                                            ? Icons.arrow_downward_rounded
                                            : Icons.arrow_upward_rounded,
                                        color: ly,
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AnimatedContainer(
                                height: s1 ? size() : size2(),
                                width: double.infinity,
                                duration: const Duration(milliseconds: 600),
                                child: s1
                                    ? _certi(
                                        "Learning platform", isTab(context))
                                    : largecon(
                                        "Learning platform", d, isTab(context)),
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              //bigtech
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text("Bigtech companies",
                                        style: TextStyle(
                                          fontSize: true ? 18 : 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        )),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          s1 = true;
                                          s2 = !s2;
                                          s3 = true;
                                        });
                                      },
                                      icon: Icon(
                                        s2
                                            ? Icons.arrow_downward_rounded
                                            : Icons.arrow_upward_rounded,
                                        color: ly,
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AnimatedContainer(
                                height: s2 ? size() : size2(),
                                width: double.infinity,
                                duration: const Duration(milliseconds: 600),
                                child: s2
                                    ? _certi(
                                        "Bigtech companies", isTab(context))
                                    : largecon("Bigtech companies", d1,
                                        isTab(context)),
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              //leading university
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text("Leading universities",
                                        style: TextStyle(
                                          fontSize: true ? 18 : 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        )),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          s1 = true;
                                          s2 = true;
                                          s3 = !s3;
                                        });
                                      },
                                      icon: Icon(
                                        s3
                                            ? Icons.arrow_downward_rounded
                                            : Icons.arrow_upward_rounded,
                                        color: ly,
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AnimatedContainer(
                                  height: s3 ? size() : size2(),
                                  width: double.infinity,
                                  duration: const Duration(milliseconds: 600),
                                  child: s3
                                      ? _certi("Leading universities",
                                          isTab(context))
                                      : largecon("Leading universities", d2,
                                          isTab(context))),
                            ],
                          ),
                        ),
                        Positioned(
                            top: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: ClipRRect(
                                child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 20,
                                      sigmaY: 20,
                                    ),
                                    child: appbared("Certificates", context,
                                        appBarColor)))),
                      ],
                    ),
                  ))),
        ));
  }
}
