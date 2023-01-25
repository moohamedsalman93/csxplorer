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
  late final PageController pageController;
  int pageNo = 0;
  List temp = [];
  final user = FirebaseAuth.instance.currentUser!.uid;
  Auth a = Auth();
  bool s1 = true;
  bool s2 = true;
  bool s3 = true;
  List d = ["freebootcamp", "LinkedIn"];
  List d1 = ["Google", "Microsoft"];
  List d2 = ["Harvard university"];

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
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: 0, viewportFraction: 0.7);
    temp = widget.temp;
    print(temp);
    setState(() {});
  }

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
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 120,
                  ),
                  //learning platforms
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  s1
                      ? SizedBox(
                          height: 200,
                          width: w,
                          child: _certi("Learning platform"))
                      : Container(
                          color: b.withOpacity(0.5),
                          child: largecon("Learning platform", d)),
                  const SizedBox(
                    height: 12.0,
                  ),
                  //bigtech
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  s2
                      ? SizedBox(
                          height: 200,
                          width: w,
                          child: _certi("Bigtech companies"))
                      : Container(
                          color: b.withOpacity(0.5),
                          child: largecon("Bigtech companies", d1)),
                  const SizedBox(
                    height: 12.0,
                  ),
                  //leading university
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  s3
                      ? SizedBox(
                          height: 200,
                          width: w,
                          child: _certi("Leading universities"))
                      : Container(
                          color: b.withOpacity(0.5),
                          child: largecon("Leading universities", d2)),
                ],
              ),
            ),
            Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                    color: b, child: appbared("Certificate", context))),
          ],
        ),
      ),
    );
  }

  Widget _certi(t) => StreamBuilder(
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
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Hello you tapped at ${index + 1} "),
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
                                  if (temp.contains(x['title'])) {
                                    delfire(x['title']);
                                    getfire();
                                    setState(() {});
                                  } else {
                                    addfire(x['title']);
                                    getfire();
                                  }
                                },
                                icon: Icon(
                                  temp.contains(x['title'])
                                      ? Icons.favorite
                                      : Icons.favorite_border_rounded,
                                  color: temp.contains(x['title'])
                                      ? Colors.red
                                      : wh,
                                ))
                          ],
                        )
                      ],
                    ),
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
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Hello you tapped at ${index + 1} "),
                      ),
                    );
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
                              color: ly,
                            )),
                        Expanded(child: Container()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ly),
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
                                    addfire(x['title']);
                                    getfire();
                                  }
                                },
                                icon: Icon(
                                  temp.contains(x['title'])
                                      ? Icons.favorite
                                      : Icons.favorite_border_rounded,
                                  color: temp.contains(x['title'])
                                      ? Colors.red
                                      : wh,
                                ))
                          ],
                        )
                      ],
                    ),
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

  Widget largecon(t, t2) => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: t2.length,
        itemBuilder: (BuildContext context, int index) {
          return wrp(t, t2[index]);
        },
      );

  Widget wrp(t, t2) => Wrap(
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
          SizedBox(height: 200, child: _certi2(t, t2)),
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
}
