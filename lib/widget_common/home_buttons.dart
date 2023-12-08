import 'package:flutter/material.dart';
import 'package:rokastore/consts/colors.dart';
import 'package:velocity_x/velocity_x.dart';

Widget homeButtons({width, height, icon, String? title, onPressed}) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          width: 30,
        ),
        10.heightBox,
        title!.text.size(11).semiBold.color(darkFontGrey).make(),
      ],
    )
        .box
        .roundedSM
        .white
        .size(width, height)
        .margin(const EdgeInsets.symmetric(horizontal: 5))
        .make();
