import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget ourButton({
  void Function()? onPressed,
  Color? backgroundColor,
  Color? textColor,
  String? title,
}) =>
    ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(backgroundColor),
        padding: const MaterialStatePropertyAll(EdgeInsets.all(12)),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: onPressed,
      child: title!.text.color(textColor).fontWeight(FontWeight.bold).make(),
    );
