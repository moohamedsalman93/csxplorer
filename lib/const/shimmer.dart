import 'package:csexp/const/const.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget mainimg(
  h,
  w,
) =>
    Shimmer.fromColors(
      baseColor: ly,
      highlightColor: b,
      child: Container(
        height: h,
        width: h,
        decoration: BoxDecoration(
            color: b, borderRadius: BorderRadius.circular(5)),
      ),
    );