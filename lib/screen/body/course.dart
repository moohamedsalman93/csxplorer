import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csexp/const/const.dart';
import 'package:csexp/const/shimmer.dart';
import 'package:csexp/screen/body/youtube.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'dart:ui';

class course extends StatefulWidget {
  var title;
  var text;
  course({super.key, this.title, this.text});

  @override
  State<course> createState() => _courseState();
}

class _courseState extends State<course> {
  late ScrollController _scrollController;
  Color appBarColor = Colors.transparent;
  final user = FirebaseAuth.instance.currentUser!.uid;
  final _isAnonymous = FirebaseAuth.instance.currentUser!.isAnonymous;
  List temp = [];

  @override
  void initState() {
    super.initState();
    if (!_isAnonymous) {
      getfire();
    }
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset >= 50) {
        setState(() {
          appBarColor = ly.withOpacity(0.3);
        });
      } else {
        setState(() {
          appBarColor = Colors.transparent;
        });
      }
    });
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

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    bool isTab(BuildContext context) =>
        MediaQuery.of(context).size.width >= 600;

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
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('all')
                                  .where('topic', isEqualTo: widget.title)
                                  .snapshots(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text("Something went Wrong",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: y,
                                              fontSize: 30)));
                                } else if (snapshot.hasData) {
                                  return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 120),
                                        GridView.builder(
                                            padding: const EdgeInsets.all(10),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount:
                                                  isTab(context) ? 4 : 3,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              childAspectRatio: 0.80,
                                            ),
                                            itemCount:
                                                snapshot.data!.docs.length,
                                            primary: false,
                                            shrinkWrap: true,
                                            itemBuilder: (context, i) {
                                              QueryDocumentSnapshot x =
                                                  snapshot.data.docs[i];
                                              return Container(
                                                decoration: BoxDecoration(
                                                  color: wh.withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.25),
                                                      blurRadius: 4,
                                                      offset:
                                                          const Offset(0, 0),
                                                    )
                                                  ],
                                                ),
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      splashColor:
                                                          y.withOpacity(0.5),
                                                      onTap: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (context) => youtube(
                                                                    title: x[
                                                                        'title'],
                                                                    simg: x[
                                                                        "img"],
                                                                    temp:
                                                                        temp)));
                                                      },
                                                      child: Ink(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            CachedNetworkImage(
                                                              imageUrl:
                                                                  x["img"],
                                                              imageBuilder:
                                                                  (context,
                                                                          imageProvider) =>
                                                                      Container(
                                                                width: 80,
                                                                height: 80,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                                    image:
                                                                        imageProvider,
                                                                  ),
                                                                ),
                                                              ),
                                                              placeholder:
                                                                  (context,
                                                                          url) =>
                                                                      mainimg(
                                                                          100.0,
                                                                          100.0),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Lottie.asset(
                                                                'assets/noimg.json',
                                                                width: 100,
                                                                height: 100,
                                                              ),
                                                            ),
                                                            Center(
                                                              child: Text(
                                                                  x['title'],
                                                                  softWrap:
                                                                      false,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .fade,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .white,
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                ),
                                              );
                                            })
                                      ]);
                                }

                                return SizedBox(
                                  height: h * 0.6,
                                  width: w,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.black,
                                      color: y,
                                    ),
                                  ),
                                );
                              }),
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
                                    child: appbared(
                                        "Certificate", context, appBarColor)))),
                      ],
                    ),
                  ),
                ))));
  }
}
