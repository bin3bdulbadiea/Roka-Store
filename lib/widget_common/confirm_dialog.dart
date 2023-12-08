import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rokastore/consts/colors.dart';
import 'package:rokastore/consts/strings.dart';
import 'package:rokastore/controllers/profile_controller.dart';
import 'package:rokastore/layout/home_layout.dart';
import 'package:rokastore/widget_common/custom_text_field.dart';
import 'package:rokastore/widget_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class ConfirmDialog extends StatefulWidget {
  const ConfirmDialog({super.key, this.data});
  final dynamic data;

  @override
  State<ConfirmDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  var isOldPassword = true;

  var controller = Get.put(ProfileController());

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
          confirm.text.bold.size(18).make(),
          20.heightBox,
          passwordNote.text.make(),
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

          controller.isLoading.value
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                )
              : ourButton(
                  backgroundColor: redColor,
                  onPressed: () async {
                    controller.isLoading(true);

                    Get.offAll(() => const HomeLayout());

                    if (widget.data[0]['password'] ==
                        controller.passwordController.text) {
                      VxToast.show(context, msg: updateAccount);

                      await controller.updateProfile(
                        name: controller.nameController.text,
                        email: controller.emailController.text,
                        phone: controller.phoneController.text,
                        address: controller.addressController.text,
                        password: controller.passwordController.text,
                      );
                    } else {
                      VxToast.show(context, msg: wrongPassword);

                      controller.isLoading(false);
                    }
                  },
                  textColor: whiteColor,
                  title: save,
                ).box.width(context.screenWidth - 30).make(),
        ],
      ).box.roundedSM.margin(const EdgeInsets.all(20)).make(),
    );
  }
}
