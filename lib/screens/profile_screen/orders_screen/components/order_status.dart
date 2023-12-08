import 'package:flutter/material.dart';
import 'package:rokastore/consts/colors.dart';
import 'package:velocity_x/velocity_x.dart';

Widget orderStatus({icon, color, title, showDone}) => ListTile(
      leading: Icon(
        icon,
        color: color,
      ).box.border(color: color).roundedSM.p4.make(),
      trailing: SizedBox(
        height: 100,
        width: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            '$title'.text.make(),
            showDone
                ? const Icon(
                    Icons.done,
                    color: redColor,
                    size: 30,
                  )
                : Container(),
          ],
        ),
      ),
    );
