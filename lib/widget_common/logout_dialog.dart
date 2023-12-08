import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rokastore/consts/colors.dart';
import 'package:rokastore/consts/firebase_const.dart';
import 'package:rokastore/consts/strings.dart';
import 'package:rokastore/controllers/auth_controller.dart';
import 'package:rokastore/screens/auth_screen/login_screen.dart';
import 'package:rokastore/widget_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class LogoutDialog extends StatefulWidget {
  const LogoutDialog({super.key});

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  @override
  void initState() {
    auth.authStateChanges().listen((event) {
      if (event == null) {
        Get.offAll(() => const LoginScreen());
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          'تسجيل الخروج'.text.bold.size(18).make(),
          (context.screenHeight / 100).heightBox,
          sureExit.text.make(),
          (context.screenHeight / 100).heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ourButton(
                backgroundColor: redColor,
                onPressed: () async {
                  await Get.put(AuthController()).signoutMethod(context);
                  Get.put(AuthController()).isLoading(false);
                },
                textColor: whiteColor,
                title: yes,
              ),
              ourButton(
                backgroundColor: redColor,
                onPressed: () {
                  Navigator.pop(context);
                },
                textColor: whiteColor,
                title: no,
              ),
            ],
          ),
        ],
      ).box.roundedSM.margin(const EdgeInsets.all(20)).make(),
    );
  }
}
