import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rokastore/consts/colors.dart';
import 'package:rokastore/consts/firebase_const.dart';
import 'package:rokastore/consts/strings.dart';
import 'package:rokastore/controllers/profile_controller.dart';
import 'package:rokastore/screens/auth_screen/signup_screen.dart';
import 'package:rokastore/widget_common/custom_text_field.dart';
import 'package:rokastore/widget_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({super.key, this.data});
  final dynamic data;

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  var controller = Get.put(ProfileController());

  var isOldPassword = true;

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
          deleteAccount.text.bold.size(18).make(),
          20.heightBox,
          sureDelete.text.make(),
          20.heightBox,

          // old password

          customTextField(
            controller: controller.passwordController,
            keyboardType: TextInputType.visiblePassword,
            validator: (value) {
              if (value!.isEmpty) {
                return validatorText;
              }
              return null;
            },
            hint: passwordHint,
            obscureText: isOldPassword,
            suffixIcon: isOldPassword ? Icons.visibility : Icons.visibility_off,
            suffixPressed: () {
              isOldPassword = !isOldPassword;
              setState(() {});
            },
          ),
          (context.screenHeight / 100).heightBox,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ourButton(
                backgroundColor: redColor,
                onPressed: () async {
                  controller.isLoading(true);

                  if (widget.data[0]['password'] ==
                      controller.passwordController.text) {
                    VxToast.show(context, msg: deleteUser);

                    await firestore
                        .collection(usersCollection)
                        .doc(currentUser!.uid)
                        .delete();

                    Get.offAll(() => const SignupScreen());
                  } else {
                    VxToast.show(context, msg: wrongPassword);

                    controller.isLoading(false);
                  }
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
