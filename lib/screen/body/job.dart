import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csexp/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class Job extends StatefulWidget {
  const Job({super.key});

  @override
  State<Job> createState() => _JobState();
}

class _JobState extends State<Job> {
  late ScrollController _scrollController;
  Color appBarColor = Colors.transparent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                                const SizedBox(height: 130),
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
                                      if (snapshot.hasData) {
                                        return ListView.builder(
                                            padding: const EdgeInsets.all(10),
                                            itemCount:
                                                snapshot.data!.docs.length,
                                            primary: false,
                                            shrinkWrap: true,
                                            itemBuilder: (context, i) {
                                              QueryDocumentSnapshot x =
                                                  snapshot.data.docs[i];

                                              return Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 15),
                                                decoration: BoxDecoration(
                                                  color: b,
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
                                                      splashColor: ly,
                                                      onTap: () =>
                                                          _link(x['link']),
                                                      child: Ink(
                                                        height: 350,
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 20,
                                                                left: 20,
                                                                top: 15,
                                                                bottom: 15),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            //dp
                                                            Container(
                                                              width: 330,
                                                              height: 200,
                                                              color: wh,
                                                              child:
                                                                  CachedNetworkImage(
                                                                fit:
                                                                    BoxFit.fill,
                                                                imageUrl:
                                                                    x['img'],

                                                                imageBuilder:
                                                                    (context,
                                                                            imageProvider) =>
                                                                        Container(
                                                                  width: 300,
                                                                  height: 300,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      image:
                                                                          imageProvider,
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
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Text(
                                                                      x['date'],
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      )),
                                                                ),
                                                                Wrap(
                                                                  children: [
                                                                    Center(
                                                                      child: Text(
                                                                          'Open',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color:
                                                                                ly,
                                                                          )),
                                                                    ),
                                                                    Center(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .arrow_forward_ios_rounded,
                                                                        color:
                                                                            ly,
                                                                        size:
                                                                            20,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                          ],
                                                        ),
                                                      )),
                                                ),
                                              );
                                            });
                                      }
                                      return SizedBox(
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            backgroundColor: Colors.black,
                                            color: ly,
                                          ),
                                        ),
                                      );
                                    })
                              ]),
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
                                        "Job", context, appBarColor)))),
                      ],
                    ),
                  ))),
        ));
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
