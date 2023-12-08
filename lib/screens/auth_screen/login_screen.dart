import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rokastore/consts/colors.dart';
import 'package:rokastore/consts/images.dart';
import 'package:rokastore/consts/strings.dart';
import 'package:rokastore/controllers/auth_controller.dart';
import 'package:rokastore/screens/auth_screen/signup_screen.dart';
import 'package:rokastore/layout/home_layout.dart';
import 'package:rokastore/widget_common/custom_text_field.dart';
import 'package:rokastore/widget_common/one_user_signup_dialog.dart';
import 'package:rokastore/widget_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var isPassword = true;

  var controller = Get.put(AuthController());

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: context.screenWidth,
        height: context.screenHeight,
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
                      //login text
                      login.text
                          .fontWeight(FontWeight.bold)
                          .black
                          .size(25)
                          .make(),
                      (context.screenHeight / 40).heightBox,

                      //email
                      customTextField(
                        controller: controller.emailController,
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

                      //password
                      customTextField(
                        controller: controller.passwordController,
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

                      //login button
                      controller.isLoading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            )
                          : ourButton(
                              backgroundColor: redColor,
                              title: login,
                              textColor: whiteColor,
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  controller.isLoading(true);
                                  await controller
                                      .loginMethod(context)
                                      .then((value) {
                                    if (value != null) {
                                      VxToast.show(context, msg: loggedin);
                                      Get.offAll(() => const HomeLayout());
                                    } else {
                                      controller.isLoading(false);
                                    }
                                  });
                                }
                              },
                            ).box.width(context.screenWidth - 30).make(),
                      (context.screenHeight / 100).heightBox,

                      //create account text
                      createNewAccount.text.color(fontGrey).make(),
                      (context.screenHeight / 100).heightBox,

                      //signup button
                      ourButton(
                        backgroundColor: lightGolden,
                        title: signup,
                        textColor: redColor,
                        onPressed: () {
                          Get.to(() => const SignupScreen());
                          showDialog(
                            context: context,
                            builder: (context) => oneUserSignUpDialog(context),
                          );
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
