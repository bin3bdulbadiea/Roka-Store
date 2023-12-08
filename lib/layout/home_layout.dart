import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rokastore/consts/colors.dart';
import 'package:rokastore/consts/fonts.dart';
import 'package:rokastore/consts/images.dart';
import 'package:rokastore/consts/strings.dart';
import 'package:rokastore/controllers/home_controller.dart';
import 'package:rokastore/screens/cart_screen/cart_screen.dart';
import 'package:rokastore/screens/home_screen/home_screen.dart';
import 'package:rokastore/screens/profile_screen/profile_screen.dart';
import 'package:rokastore/widget_common/exit_dialog.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navBarItem = [
      BottomNavigationBarItem(
        icon: Image.asset(icHome, width: 26),
        label: home,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(icCart, width: 26),
        label: cart,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(icProfile, width: 26),
        label: profile,
      ),
    ];

    var navBarBody = [
      const HomeScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => exitDialog(context),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              WavyAnimatedText(
                'Roka Store',
                textStyle: const TextStyle(fontSize: 25, fontFamily: tektur),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: Obx(
          () => navBarBody.elementAt(controller.currentNavIndex.value),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            items: navBarItem,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
