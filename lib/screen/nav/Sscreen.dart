import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csexp/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Sscreen extends StatefulWidget {
  const Sscreen({super.key});

  @override
  State<Sscreen> createState() => _SscreenState();
}

final TextEditingController searchcon = TextEditingController();

class _SscreenState extends State<Sscreen> {
  List searchResult = [];
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
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
            child: Column(children: [
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(10),
                color: wh,
              ),
              child: TextField(
                  controller: searchcon,
                  style: TextStyle(color: b),
                  autofocus: true,
                  cursorHeight: 20,
                  cursorColor: ly,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      size: 30,
                      color: ly,
                    ),
                    suffixIcon: Container(
                      width: 10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color.fromRGBO(225, 225, 231, 1)),
                      child: IconButton(
                        icon: const Icon(Icons.cancel_outlined),
                        onPressed: () {
                          searchcon.clear();
                        },
                      ),
                    ),
                    border: InputBorder.none,
                    hintText: "Python",
                    hintStyle: TextStyle(
                        textBaseline: TextBaseline.alphabetic, color: b),
                  ),
                  onChanged: (query) {
                    searchFromFirebase(query);
                  }),
            ),
          ),
          body()
        ])));
  }

  Widget body() => Container(
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
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: true ? 2 : 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 230,
                childAspectRatio: 1,
              ),
              itemCount: searchResult.length,
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return Container(
                  margin: const EdgeInsets.all(5),
                  width: 164,
                  height: 244,
                  decoration: BoxDecoration(
                    color: b,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: wh.withOpacity(0.3), width: 1),
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                    child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        splashColor: y.withOpacity(1),
                        //onTap: () {},
                        child: Ink(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CachedNetworkImage(
                                imageUrl: searchResult[i]["img"],
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height: 124,
                                  width: 154,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: wh.withOpacity(0.3), width: 1),
                                    image: DecorationImage(
                                      image: imageProvider,
                                    ),
                                  ),
                                ),
                                // placeholder:
                                //     (context, url) =>
                                //         mainimg(
                                //   h * 0.14,
                                //   w * 0.7,
                                // ),
                                // errorWidget:
                                //     (context, url, error) =>
                                //         Lottie.asset(
                                //   'assets/noimg.json',
                                //   width: w * 0.8,
                                //   height: h * 0.15,
                                // ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(searchResult[i]['title'],
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    )),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        color: y,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Center(
                                      child: Text('Open',
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                            color: wh,
                                          )),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                );
              }),
        ],
      ));
}
