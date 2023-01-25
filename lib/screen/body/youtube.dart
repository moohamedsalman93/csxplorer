import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csexp/const/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../const/const.dart';

class youtube extends StatefulWidget {
  var simg;
  var title;

  youtube({super.key, this.title, this.simg});

  @override
  State<youtube> createState() => _youtubeState();
}

class _youtubeState extends State<youtube> {
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
            child: SingleChildScrollView(
                child: Column(children: [
              appbared("Youtube Video", context),
              StreamBuilder(
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
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                    }
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 13),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 70,
                                  height: 70,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.simg,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          mainimg(195.0, 200.0),
                                      errorWidget: (context, url, error) =>
                                          Lottie.asset(
                                        'assets/noimg.json',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(widget.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          GridView.builder(
                              padding: EdgeInsets.all(10),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: true ? 1 : 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1.2,
                              ),
                              itemCount: snapshot.data!.docs.length,
                              primary: false,
                              shrinkWrap: true,
                              itemBuilder: (context, i) {
                                QueryDocumentSnapshot x = snapshot.data.docs[i];

                                return Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        borderRadius: BorderRadius.circular(20),
                                        splashColor: y,
                                        onTap: () => _link(x['url']),
                                        child: Ink(
                                          padding: EdgeInsets.only(
                                              right: 15,
                                              left: 15,
                                              top: 15,
                                              bottom: 15),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              //dp
                                              SizedBox(
                                                width: 400,
                                                height: 195,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    imageUrl: x["thumb"],
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    placeholder: (context,
                                                            url) =>
                                                        mainimg(195.0, 200.0),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Lottie.asset(
                                                      'assets/noimg.json',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              //title and button
                                              SizedBox(
                                                height: h * 0.001,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Center(
                                                    child: Text(x['title'],
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        )),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(x['dur'],
                                                          //minFontSize: 13,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.grey,
                                                          )),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(x['views'],
                                                          //    minFontSize: 13,
                                                          style:
                                                              const TextStyle(
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
                  }),
            ]))));
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
