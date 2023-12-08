import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rokastore/consts/colors.dart';

ThemeData themes = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.grey[200],
  appBarTheme: const AppBarTheme(
    scrolledUnderElevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Color.fromRGBO(151, 8, 8, 1),
      statusBarBrightness: Brightness.light,
    ),
    color: Color.fromRGBO(151, 8, 8, 1),
    titleTextStyle: TextStyle(color: Colors.white),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    ),
  ),
  popupMenuTheme: const PopupMenuThemeData(
    color: Colors.white,
    elevation: 0,
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromRGBO(151, 8, 8, 1),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: const MaterialStatePropertyAll(redColor),
      padding: const MaterialStatePropertyAll(EdgeInsets.all(12)),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  ),
);
