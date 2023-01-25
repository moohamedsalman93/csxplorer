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
            child: Stack(children: [
              SingleChildScrollView(
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
              appbared("Developer Roadmaps", context)
            ])));
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
                splashColor: ly.withOpacity(0.5),
                onTap: () {
                  String g = t[i].toLowerCase().replaceAll(" ", "-");
                  jandr('https://roadmap.sh/$g');
                },
                child: Ink(
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: Text(t[i],
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
