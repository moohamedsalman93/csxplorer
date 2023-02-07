import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csexp/const/const.dart';
import 'package:csexp/const/shimmer.dart';
import 'package:csexp/screen/body/youtube.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  final user = FirebaseAuth.instance.currentUser!.uid;
  List temp = [];

  @override
  void initState() {
    super.initState();
    getfire();
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      appbared(widget.text, context),
                      StreamBuilder(
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
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox(
                                height: 500,
                                // width: w,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.black,
                                    color: y,
                                  ),
                                ),
                              );
                            }
                            return GridView.builder(
                                padding: const EdgeInsets.all(10),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: true ? 3 : 4,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.80,
                                ),
                                itemCount: snapshot.data!.docs.length,
                                primary: false,
                                shrinkWrap: true,
                                itemBuilder: (context, i) {
                                  QueryDocumentSnapshot x =
                                      snapshot.data.docs[i];
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: wh.withOpacity(0.1),
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
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          splashColor: y.withOpacity(0.5),
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        youtube(
                                                            title: x['title'],
                                                            simg: x["img"],
                                                            temp: temp)));
                                          },
                                          child: Ink(
                                            padding: const EdgeInsets.all(5),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl: x["img"],
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    width: 80,
                                                    height: 80,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                      ),
                                                    ),
                                                  ),
                                                  placeholder: (context, url) =>
                                                      mainimg(100.0, 100.0),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Lottie.asset(
                                                    'assets/noimg.json',
                                                    width: 100,
                                                    height: 100,
                                                  ),
                                                ),
                                                Center(
                                                  child: Text(x['title'],
                                                      softWrap: false,
                                                      overflow:
                                                          TextOverflow.fade,
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  );
                                });
                          }),
                      const SizedBox(
                        height: 8,
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
