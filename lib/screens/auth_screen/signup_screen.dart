import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:rokastore/consts/colors.dart';
import 'package:rokastore/consts/firebase_const.dart';
import 'package:rokastore/consts/images.dart';
import 'package:rokastore/consts/strings.dart';
import 'package:rokastore/controllers/auth_controller.dart';
import 'package:rokastore/layout/home_layout.dart';
import 'package:rokastore/widget_common/custom_text_field.dart';
import 'package:rokastore/widget_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  var isPassword = true;

  var isCheck = false;

  var controller = Get.put(AuthController());

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var addressController = TextEditingController();

  var passwordController = TextEditingController();

  var newPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icApp,
                scale: 7,
              ),
              (context.screenHeight / 40).heightBox,
              Obx(
                () => Form(
                  key: formKey,
                  child: Column(
                    children: [
                      signup.text
                          .fontWeight(FontWeight.bold)
                          .black
                          .size(25)
                          .make(),
                      (context.screenHeight / 40).heightBox,

                      //name
                      customTextField(
                        controller: nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return validatorText;
                          }
                          return null;
                        },
                        hint: nameHint,
                        keyboardType: TextInputType.name,
                      ),
                      (context.screenHeight / 100).heightBox,

                      //email
                      customTextField(
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return validatorText;
                          }
                          return null;
                        },
                        hint: emailHint,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      (context.screenHeight / 100).heightBox,

                      //phone

                      customTextField(
                        controller: phoneController,
                        maxLength: 11,
                        validator: (value) {
                          if (value!.isEmpty || phoneController.length < 11) {
                            return validatorText;
                          }
                          return null;
                        },
                        hint: phoneHint,
                        keyboardType: TextInputType.phone,
                      ),
                      (context.screenHeight / 100).heightBox,

                      //address
                      customTextField(
                        controller: addressController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return validatorText;
                          }
                          return null;
                        },
                        hint: addressHint,
                        keyboardType: TextInputType.text,
                      ),
                      (context.screenHeight / 300).heightBox,
                      // note for city
                      Align(
                        alignment: Alignment.center,
                        child: cityNote.text.color(redColor).size(5).make(),
                      ),
                      (context.screenHeight / 100).heightBox,

                      //password
                      customTextField(
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return validatorText;
                          }
                          return null;
                        },
                        hint: passwordHint,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: isPassword,
                        suffixIcon: isPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        suffixPressed: () {
                          setState(() {
                            isPassword = !isPassword;
                          });
                        },
                      ),
                      (context.screenHeight / 100).heightBox,

                      //new password
                      customTextField(
                        controller: newPasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return validatorText;
                          }
                          return null;
                        },
                        hint: retypePasswordHint,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: isPassword,
                        suffixIcon: isPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        suffixPressed: () {
                          setState(() {
                            isPassword = !isPassword;
                          });
                        },
                      ),
                      (context.screenHeight / 100).heightBox,

                      //signup button
                      controller.isLoading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            )
                          : ourButton(
                              backgroundColor: redColor,
                              title: signup,
                              textColor: whiteColor,
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  if (passwordController.text ==
                                      newPasswordController.text) {
                                    controller.isLoading(true);
                                    try {
                                      await controller
                                          .signupMethod(
                                        context: context,
                                        email: emailController.text,
                                        password: passwordController.text,
                                      )
                                          .then((value) {
                                        return controller.storeUserData(
                                          name: nameController.text,
                                          email: emailController.text,
                                          phone: phoneController.text,
                                          address: addressController.text,
                                          password: passwordController.text,
                                        );
                                      }).then((value) {
                                        VxToast.show(context, msg: loggedin);
                                        Get.offAll(() => const HomeLayout());
                                      });
                                    } catch (e) {
                                      auth.signOut();
                                      VxToast.show(context, msg: e.toString());
                                      controller.isLoading(false);
                                    }
                                  } else {
                                    VxToast.show(context,
                                        msg: passwordNotMatch);
                                  }
                                }
                              },
                            ).box.width(context.screenWidth - 30).make(),
                    ],
                  )
                      .box
                      .white
                      .padding(const EdgeInsets.all(16))
                      .rounded
                      .width(context.screenWidth - 50)
                      .make(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
