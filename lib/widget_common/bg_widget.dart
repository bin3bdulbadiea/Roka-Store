import 'package:flutter/material.dart';
import 'package:rokastore/consts/images.dart';

Widget bgWidget({
  Widget? child,
}) =>
    Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imgBackground),
          fit: BoxFit.fill,
        ),
      ),
      child: child,
    );
