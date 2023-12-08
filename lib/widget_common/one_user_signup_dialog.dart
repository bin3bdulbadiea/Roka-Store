import 'package:flutter/material.dart';
import 'package:rokastore/consts/colors.dart';
import 'package:rokastore/consts/strings.dart';
import 'package:rokastore/widget_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

Widget oneUserSignUpDialog(context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          warning.text.bold.size(18).make(),
          20.heightBox,
          oneUserAccount.text.make(),
          20.heightBox,
          ourButton(
            backgroundColor: redColor,
            onPressed: () {
              Navigator.pop(context);
            },
            textColor: whiteColor,
            title: understand,
          ),
        ],
      ).box.roundedSM.margin(const EdgeInsets.all(20)).make(),
    );
