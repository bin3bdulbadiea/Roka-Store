import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rokastore/consts/colors.dart';
import 'package:rokastore/consts/firebase_const.dart';
import 'package:rokastore/consts/strings.dart';
import 'package:rokastore/layout/home_layout.dart';
import 'package:rokastore/screens/auth_screen/login_screen.dart';
import 'package:rokastore/widget_common/app_logo_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      auth.authStateChanges().listen((event) {
        if (event == null && mounted) {
          Get.offAll(() => const LoginScreen());
        } else {
          Get.offAll(() => const HomeLayout());
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      body: Center(
        child: Container(
          width: context.screenWidth,
          height: context.screenHeight,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              appLogoWidget(),
              (context.screenHeight / 100).heightBox,
              appName.text.black.make(),
            ],
          ),
        ),
      ),
    );
  }
}
