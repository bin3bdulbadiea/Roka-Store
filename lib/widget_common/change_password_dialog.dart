import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rokastore/consts/colors.dart';
import 'package:rokastore/consts/firebase_const.dart';
import 'package:rokastore/consts/strings.dart';
import 'package:rokastore/controllers/profile_controller.dart';
import 'package:rokastore/layout/home_layout.dart';
import 'package:rokastore/widget_common/custom_text_field.dart';
import 'package:rokastore/widget_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key, this.data});
  final dynamic data;

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  var isOldPassword = true;

  var isNewPassword = true;

  var controller = Get.put(ProfileController());

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Obx(
        () => Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              changePassword.text.bold.size(18).make(),
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
                hint: oldPasswordHint,
                obscureText: isOldPassword,
                suffixIcon:
                    isOldPassword ? Icons.visibility : Icons.visibility_off,
                suffixPressed: () {
                  isOldPassword = !isOldPassword;
                  setState(() {});
                },
              ),
              (context.screenHeight / 100).heightBox,

              // new password
              customTextField(
                controller: controller.newPasswordController,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value!.isEmpty) {
                    return validatorText;
                  }
                  return null;
                },
                hint: newPasswordHint,
                obscureText: isNewPassword,
                suffixIcon:
                    isNewPassword ? Icons.visibility : Icons.visibility_off,
                suffixPressed: () {
                  isNewPassword = !isNewPassword;
                  setState(() {});
                },
              ),
              (context.screenHeight / 100).heightBox,

              // retype new password
              customTextField(
                controller: controller.retypeNewPasswordController,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value!.isEmpty) {
                    return validatorText;
                  }
                  return null;
                },
                hint: retypeNewPasswordHint,
                obscureText: isNewPassword,
                suffixIcon:
                    isNewPassword ? Icons.visibility : Icons.visibility_off,
                suffixPressed: () {
                  isNewPassword = !isNewPassword;
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
                        if (formKey.currentState!.validate()) {
                          controller.isLoading(true);

                          Get.offAll(() => const HomeLayout());

                          if (widget.data[0]['password'] ==
                              controller.passwordController.text) {
                            if (controller.newPasswordController.text ==
                                controller.retypeNewPasswordController.text) {
                              //----
                              VxToast.show(context, msg: doneChangePassword);

                              await controller.changePassword(
                                email: currentUser!.email,
                                oldPassword: controller.passwordController.text,
                                newPassword:
                                    controller.newPasswordController.text,
                              );

                              await controller.updateProfile(
                                name: widget.data[0]['name'],
                                email: widget.data[0]['email'],
                                phone: widget.data[0]['phone'],
                                address: widget.data[0]['address'],
                                password: controller.newPasswordController.text,
                              );
                            } else {
                              VxToast.show(context, msg: passwordNotMatch);

                              controller.isLoading(false);
                            }
                          } else {
                            VxToast.show(context, msg: wrongPassword);

                            controller.isLoading(false);
                          }
                          controller.isLoading(false);
                        }
                      },
                      textColor: whiteColor,
                      title: save,
                    ).box.width(context.screenWidth - 30).make(),
            ],
          ).box.roundedSM.margin(const EdgeInsets.all(20)).make(),
        ),
      ),
    );
  }
}
