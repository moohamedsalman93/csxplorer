import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csexp/const/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../const/admob.dart';
import '../../const/shimmer.dart';
import '../body/youtube.dart';
import 'package:animations/animations.dart';

class Sscreen extends StatefulWidget {
  const Sscreen({super.key});

  @override
  State<Sscreen> createState() => _SscreenState();
}

final TextEditingController searchcon = TextEditingController();

class _SscreenState extends State<Sscreen> {
  List searchResult = [];
  final user = FirebaseAuth.instance.currentUser!.uid;
  List temp = [];
  BannerAd? _banner;

  @override
  void initState() {
    super.initState();
    getfire();
    _createBannerAd();
  }

  void _createBannerAd() {
    _banner = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: 'ca-app-pub-3806793165121775/5397582821',
        listener: Admob.bannerListener,
        request: const AdRequest())
      ..load();
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

  void searchFromFirebase(String query) async {
    var sa = await FirebaseFirestore.instance
        .collection('all')
        .where('caseSearch', arrayContains: query)
        .get();
    setState(() {
      searchResult = sa.docs.map((e) => e.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    bool isTab(BuildContext context) =>
        MediaQuery.of(context).size.width >= 600;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Search",
              style: TextStyle(color: wh, fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(10),
                color: wh.withOpacity(0.1),
              ),
              child: TextField(
                  controller: searchcon,
                  style: TextStyle(fontSize: 20, color: wh),
                  autofocus: true,
                  cursorHeight: isTab(context) ? 30 : 18,
                  cursorColor: wh,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      size: 30,
                      color: wh,
                    ),
                    suffixIcon: Container(
                      width: 10,
                      child: IconButton(
                        icon: Icon(Icons.cancel_outlined, color: wh),
                        onPressed: () {
                          searchcon.clear();
                          setState(() {});
                        },
                      ),
                    ),
                    border: InputBorder.none,
                    hintText: "Search...",
                    hintStyle: TextStyle(
                        textBaseline: TextBaseline.alphabetic,
                        color: wh.withOpacity(0.5)),
                  ),
                  onChanged: (query) {
                    searchFromFirebase(query);
                  }),
            ),
          ),
          body(isTab(context))
        ])),
        bottomNavigationBar: Container(
          color: Colors.transparent,
          margin: const EdgeInsets.only(bottom: 12),
          height: 60,
          width: w,
          child: Align(
              alignment: Alignment.bottomCenter, child: AdWidget(ad: _banner!)),
        ),
      ),
    );
  }

  Widget body(isTab) => Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Text('Result',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
          ),
          GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isTab ? 4 : 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.80,
              ),
              itemCount: searchResult.length,
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return OpenContainer(
                    transitionDuration: const Duration(milliseconds: 400),
                    openColor: ly,
                    closedColor: Colors.transparent,
                    middleColor: ly,
                    closedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    openShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    openBuilder: (context, _) => youtube(
                        title: searchResult[i]['title'],
                        simg: searchResult[i]["img"],
                        temp: temp),
                    closedBuilder: (context, VoidCallback openContainer) =>
                        Container(
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
                                borderRadius: BorderRadius.circular(15),
                                splashColor: y.withOpacity(0.5),
                                onTap: () async {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);

                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  await Future.delayed(
                                      Duration(milliseconds: 300),
                                      openContainer);
                                },
                                child: Ink(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: searchResult[i]["img"],
                                        imageBuilder:
                                            (context, imageProvider) =>
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
                                        errorWidget: (context, url, error) =>
                                            Lottie.asset(
                                          'assets/noimg.json',
                                          width: 100,
                                          height: 100,
                                        ),
                                      ),
                                      Center(
                                        child: Text(searchResult[i]['title'],
                                            softWrap: false,
                                            overflow: TextOverflow.fade,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            )),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ));
              })
        ],
      ));
}
