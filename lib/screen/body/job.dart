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
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 15),
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
                                              right: 20,
                                              left: 20,
                                              top: 15,
                                              bottom: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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

                                                  imageBuilder: (context,
                                                          imageProvider) =>
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
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        )),
                                                  ),
                                                  Wrap(
                                                    children: [
                                                      Center(
                                                        child: Text('Open',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: ly,
                                                            )),
                                                      ),
                                                      Center(
                                                        child: Icon(
                                                          Icons
                                                              .arrow_forward_ios_rounded,
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
                  ]),
            ),
            Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                    color: b.withOpacity(0.1),
                    child: appbared("Jobs", context))),
          ],
        ),
      ),
    );
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
