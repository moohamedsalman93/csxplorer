import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csexp/const/shimmer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../const/const.dart';

class youtube extends StatefulWidget {
  var simg;
  var title;
  List temp = [];

  youtube({super.key, this.title, this.simg, required this.temp});

  @override
  State<youtube> createState() => _youtubeState();
}

class _youtubeState extends State<youtube> {
  late ScrollController _scrollController;
  Color appBarColor = Colors.transparent;
  var user = '';
  final _isAnonymous = FirebaseAuth.instance.currentUser!.isAnonymous;
  List temp = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!_isAnonymous) {
      temp = widget.temp;
      user = FirebaseAuth.instance.currentUser!.uid;
      print(temp);
      setState(() {});
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

  addfire(t, t2) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user.toString())
        .collection('fav')
        .doc("$t$t2")
        .set({"title": t, 'under': 'youtube', 'by': t2});
  }

  delfire(t, t2) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user.toString())
        .collection('fav')
        .doc("$t$t2")
        .delete();
  }

  getfire() async {
    var sa = await FirebaseFirestore.instance
        .collection('user')
        .doc(user.toString())
        .collection('fav')
        .where('under', isEqualTo: 'youtube')
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

    return ScreenUtilInit(
        designSize: const Size(360, 780),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => Scaffold(
            backgroundColor: b,
            resizeToAvoidBottomInset: true,
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
                            child: Stack(children: [
                              SingleChildScrollView(
                                controller: _scrollController,
                                child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("all")
                                        .doc(widget.title)
                                        .collection("nyt")
                                        .orderBy('value')
                                        .snapshots(),
                                    builder: (context, AsyncSnapshot snapshot) {
                                      if (snapshot.hasError) {
                                        return Lottie.asset(
                                          'assets/noimg.json',
                                        );
                                      } else if (snapshot.hasData) {
                                        return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 120.h),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 70.w,
                                                      height: 70.h,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: widget.simg,
                                                          imageBuilder: (context,
                                                                  imageProvider) =>
                                                              Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .transparent,
                                                              image:
                                                                  DecorationImage(
                                                                image:
                                                                    imageProvider,
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                          ),
                                                          placeholder: (context,
                                                                  url) =>
                                                              mainimg(
                                                                  195.0, 200.0),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Lottie.asset(
                                                            'assets/noimg.json',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20.w,
                                                    ),
                                                    Text(widget.title,
                                                        softWrap: false,
                                                        overflow:
                                                            TextOverflow.fade,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20.0,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 10.h),
                                              GridView.builder(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount:
                                                        isTab(context) ? 2 : 1,
                                                    crossAxisSpacing: 10.h,
                                                    mainAxisSpacing: 10.h,
                                                    childAspectRatio: 1.2,
                                                  ),
                                                  itemCount: snapshot
                                                      .data!.docs.length,
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  itemBuilder: (context, i) {
                                                    QueryDocumentSnapshot x =
                                                        snapshot.data.docs[i];

                                                    return Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        child: InkWell(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            splashColor: y,
                                                            onTap: () =>
                                                                _link(x['url']),
                                                            child: Ink(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right: 15,
                                                                      left: 15,
                                                                      top: 15,
                                                                      bottom:
                                                                          0),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  //dp
                                                                  SizedBox(
                                                                    width: isTab(
                                                                            context)
                                                                        ? 300
                                                                        : 400.w,
                                                                    height: isTab(
                                                                            context)
                                                                        ? 150
                                                                        : 195.h,
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        imageUrl:
                                                                            x["thumb"],
                                                                        imageBuilder:
                                                                            (context, imageProvider) =>
                                                                                Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.transparent,
                                                                            image:
                                                                                DecorationImage(
                                                                              image: imageProvider,
                                                                              fit: BoxFit.fill,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        placeholder: (context, url) => mainimg(
                                                                            195.0,
                                                                            200.0),
                                                                        errorWidget: (context,
                                                                                url,
                                                                                error) =>
                                                                            Lottie.asset(
                                                                          'assets/noimg.json',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  //title and button
                                                                  SizedBox(
                                                                    height: 10.h,
                                                                  ),
                                                                  Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      SizedBox(
                                                                        width: isTab(context)
                                                                            ? 90.w
                                                                            : 230.w,
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(x['title'],
                                                                                softWrap: false,
                                                                                overflow: TextOverflow.fade,
                                                                                style: const TextStyle(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  color: Colors.white,
                                                                                )),
                                                                            IconButton(
                                                                                onPressed: () {
                                                                                  if (!_isAnonymous) {
                                                                                    if (temp.contains(x['title'])) {
                                                                                      delfire(x['title'], x['topic']);
                                                                                      getfire();
                                                                                    } else {
                                                                                      addfire(x['title'], x['topic']);
                                                                                      getfire();
                                                                                    }
                                                                                  } else {
                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                      SnackBar(
                                                                                        content: Text("Not avail on Anonymous user"),
                                                                                      ),
                                                                                    );
                                                                                  }
                                                                                },
                                                                                icon: Icon(
                                                                                  temp.contains(x['title']) ? Icons.favorite : Icons.favorite_border_rounded,
                                                                                  color: temp.contains(x['title']) ? Colors.red : wh,
                                                                                ))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Column(
                                                                        children: [
                                                                          Text(
                                                                              x['dur'],
                                                                              //minFontSize: 13,
                                                                              style: const TextStyle(
                                                                                color: Colors.grey,
                                                                              )),
                                                                          const SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                              x['views'],
                                                                              //    minFontSize: 13,
                                                                              style: const TextStyle(
                                                                                color: Colors.grey,
                                                                              )),
                                                                        ],
                                                                      ),
                                                                    ],
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
                                          child: Center(
                                            child: appbared(
                                                "Videos", context, appBarColor),
                                          )))),
                            ])))))));
  }

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
}
