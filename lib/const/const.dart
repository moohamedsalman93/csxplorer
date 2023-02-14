import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Color ly = const Color.fromARGB(255, 135, 156, 241);
//Color ly = const Color.fromARGB(255, 57, 213, 116);
//Color ly = const Color.fromARGB(255, 140, 83, 253);
Color y = const Color.fromARGB(255, 135, 156, 241);
//Color y = const Color.fromARGB(255, 140, 83, 253);
Color b = Colors.black;
Color wh = Colors.white;
String font = 'Montserrat';

Widget appbared(title, context, c) => Container(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      height: 100,
      color: c,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: wh.withOpacity(0.5), width: 1),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    splashColor: ly,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Ink(
                      height: 40,
                      width: 40,
                      child: Center(
                          child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: wh,
                      )),
                    )),
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 40,
            )
          ],
        ),
      ),
    );

jandr(String url) async {
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
