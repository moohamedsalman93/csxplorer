import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csexp/const/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

import '../../const/shimmer.dart';

class Fscreen extends StatefulWidget {
  Fscreen({super.key});

  @override
  State<Fscreen> createState() => _FscreenState();
}

class _FscreenState extends State<Fscreen> {
  List temp = [];
  late final PageController pageController;
  var user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: 0, viewportFraction: 0.7);
    getfire();
    user = FirebaseAuth.instance.currentUser!.uid;
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

  delfire(t, t2) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user.toString())
        .collection('fav')
        .doc('$t$t2')
        .delete();
  }

  delfirec(t) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user.toString())
        .collection('fav')
        .doc(t)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                height: 80,
                child: Text(
                  "Favorite",
                  style: TextStyle(color: wh, fontSize: 30),
                ),
              ),
              _certi("certificate"),
              _certi("youtube"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _certi(t) => StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('user')
          .doc(user.toString())
          .collection('fav')
          .where('under', isEqualTo: t)
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Text("Something went Wrong",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: y, fontSize: 30)));
        } else if (snapshot.hasData) {
          return snapshot.data.docs.length == 0
              ? Container()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        t,
                        style: TextStyle(color: wh, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (_, index) {
                          QueryDocumentSnapshot x = snapshot.data.docs[index];
                          return AnimatedBuilder(
                            animation: pageController,
                            builder: (ctx, child) {
                              return child!;
                            },
                            child: GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "Hello you tapped at ${index + 1} "),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                margin: const EdgeInsets.only(
                                    right: 8, left: 8, top: 24, bottom: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: b,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: Wrap(children: [
                                        Text(x['title'],
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
                                          color: y,
                                        )),
                                    Expanded(child: Container()),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: y),
                                            child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.transparent,
                                                child: InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    splashColor: b,
                                                    onTap: () {},
                                                    child: Ink(
                                                        height: 38,
                                                        width: 120,
                                                        child: const Center(
                                                            child: Text(
                                                          "Open",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18),
                                                        )))))),
                                        IconButton(
                                            onPressed: () {
                                              t == 'youtube'
                                                  ? delfire(x['title'], x['by'])
                                                  : delfirec(x['title']);
                                              getfire();
                                              setState(() {});
                                            },
                                            icon: const Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
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
}
