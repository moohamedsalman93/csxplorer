import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csexp/const/const.dart';
import 'package:csexp/const/shimmer.dart';
import 'package:csexp/screen/body/youtube.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class course extends StatefulWidget {
  var title;
  var text;
  course({super.key, this.title, this.text});

  @override
  State<course> createState() => _courseState();
}

class _courseState extends State<course> {
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
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                        padding: EdgeInsets.all(10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: true ? 3 : 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.80,
                        ),
                        itemCount: snapshot.data!.docs.length,
                        primary: false,
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          QueryDocumentSnapshot x = snapshot.data.docs[i];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
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
                                  highlightColor: Colors.black,
                                  splashColor:
                                      const Color.fromARGB(255, 2, 119, 173)
                                          .withOpacity(0.5),
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => youtube(
                                                  title: x['title'],
                                                  simg: x["img"],
                                                )));
                                  },
                                  child: Ink(
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: x["img"],
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
                                          child: Text(x['title'],
                                              style: TextStyle(
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
              SizedBox(
                height: 8,
              )
            ],
          ),
        ),
      ),
    );
  }
}
