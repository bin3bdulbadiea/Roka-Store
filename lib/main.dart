import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rokastore/consts/strings.dart';
import 'package:rokastore/screens/splash_screen/splash_screen.dart';
import 'package:rokastore/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      textDirection: TextDirection.rtl,
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: themes,
      home: const SplashScreen(),
    );
  }
}
