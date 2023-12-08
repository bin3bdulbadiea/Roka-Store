import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rokastore/consts/colors.dart';
import 'package:rokastore/consts/strings.dart';
import 'package:rokastore/widget_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

Widget exitDialog(context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          logoutFromApp.text.bold.size(18).make(),
          20.heightBox,
          sureExit.text.make(),
          20.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ourButton(
                backgroundColor: redColor,
                onPressed: () {
                  SystemNavigator.pop();
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
