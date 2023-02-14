import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../const/const.dart';

class Roadmap extends StatefulWidget {
  List Rbased = [];
  List Sbased = [];
  // ignore: non_constant_identifier_names
  Roadmap({super.key, required this.Rbased, required this.Sbased});

  @override
  State<Roadmap> createState() => _RoadmapState();
}

class _RoadmapState extends State<Roadmap> {
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
                decoration: BoxDecoration(
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
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 120,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text("Role Based Roadmap",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      )),
                                ),
                                grid(widget.Rbased),
                                const Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text("Skill Based Roadmap",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      )),
                                ),
                                grid(widget.Sbased)
                              ],
                            ),
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
                                          "Roadmap", context, appBarColor)))),
                        ]))))));
  }

  Widget grid(t) => GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: true ? 3 : 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.7,
      ),
      itemCount: t.length,
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, i) {
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
                borderRadius: BorderRadius.circular(15),
                splashColor: ly.withOpacity(0.5),
                onTap: () {
                  String g = t[i].toLowerCase().replaceAll(" ", "-");
                  jandr('https://roadmap.sh/$g');
                },
                child: Ink(
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: Text(t[i],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        )),
                  ),
                )),
          ),
        );
      });
}
