import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rokastore/consts/colors.dart';
import 'package:rokastore/consts/fonts.dart';
import 'package:rokastore/consts/images.dart';
import 'package:rokastore/consts/strings.dart';
import 'package:rokastore/controllers/profile_controller.dart';
import 'package:rokastore/widget_common/change_password_dialog.dart';
import 'package:rokastore/widget_common/confirm_dialog.dart';
import 'package:rokastore/widget_common/custom_text_field.dart';
import 'package:rokastore/widget_common/delete_account_dialog.dart';
import 'package:rokastore/widget_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, this.data});
  final dynamic data;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  var isOldPassword = true;

  var isNewPassword = true;

  var controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        () => Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  icApp,
                  scale: 7,
                ),
                (context.screenHeight / 40).heightBox,
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // edit text
                    editProfile.text
                        .fontWeight(FontWeight.bold)
                        .black
                        .size(25)
                        .make(),
                    (context.screenHeight / 40).heightBox,

                    // name
                    customTextField(
                      controller: controller.nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return validatorText;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      hint: nameHint,
                    ),
                    (context.screenHeight / 100).heightBox,

                    //email
                    customTextField(
                      controller: controller.emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return validatorText;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      hint: emailHint,
                    ),
                    (context.screenHeight / 100).heightBox,

                    //phone
                    customTextField(
                      controller: controller.phoneController,
                      maxLength: 11,
                      validator: (value) {
                        if (value!.isEmpty ||
                            controller.phoneController.text.length < 11) {
                          return validatorText;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      hint: phoneHint,
                    ),
                    (context.screenHeight / 100).heightBox,

                    // location
                    customTextField(
                      controller: controller.addressController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return validatorText;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      hint: addressHint,
                    ),
                    (context.screenHeight / 100).heightBox,

                    controller.isLoading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : ourButton(
                            backgroundColor: redColor,
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    ConfirmDialog(data: widget.data),
                              );
                            },
                            textColor: whiteColor,
                            title: save,
                          ).box.width(context.screenWidth - 30).make(),

                    (context.screenHeight / 70).heightBox,

                    // change password & delete account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  ChangePasswordDialog(data: widget.data),
                            );
                          },
                          child: changePassword.text.size(10).make(),
                        ),
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  DeleteAccountDialog(data: widget.data),
                            );
                          },
                          child: deleteAccount.text.size(10).make(),
                        ),
                      ],
                    ),
                  ],
                )
                    .box
                    .white
                    .shadowSm
                    .roundedSM
                    .padding(const EdgeInsets.all(10))
                    .margin(const EdgeInsets.all(10))
                    .make(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
