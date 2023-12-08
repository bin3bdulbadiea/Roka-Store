import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rokastore/consts/colors.dart';
import 'package:rokastore/consts/fonts.dart';
import 'package:rokastore/consts/strings.dart';
import 'package:rokastore/controllers/request_report_controller.dart';
import 'package:rokastore/widget_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class ReportProblemScreen extends StatefulWidget {
  const ReportProblemScreen({super.key});

  @override
  State<ReportProblemScreen> createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(RequestAndReportController());

    var formKey = GlobalKey<FormState>();

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
      body: SizedBox(
        width: context.screenWidth,
        height: context.screenHeight,
        child: SingleChildScrollView(
          child: Obx(
            () => Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  reportProblem.text.size(25).semiBold.make(),
                  (context.screenHeight / 20).heightBox,
                  addPhotoTitle.text.size(18).semiBold.make(),
                  addPhotoSubtitleToReportProblem.text.make(),
                  (context.screenHeight / 60).heightBox,

                  // add photoe
                  controller.imagePath.value.isEmpty
                      ? CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          maxRadius: 70,
                          child: const Icon(
                            Icons.add,
                            size: 50,
                          ),
                        ).onTap(() {
                          controller.changeImage(context);
                        })
                      : Container(
                          width: context.screenWidth / 2,
                          height: context.screenHeight / 4,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: Image.file(
                            File(controller.imagePath.value),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                        ),
                  (context.screenHeight / 150).heightBox,
                  ourButton(
                    backgroundColor: redColor,
                    onPressed: () {
                      controller.changeImage(context);
                    },
                    textColor: whiteColor,
                    title: change,
                  ),
                  (context.screenHeight / 40).heightBox,

                  // add description
                  TextFormField(
                    controller: controller.descController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return validatorText;
                      }
                      return null;
                    },
                    maxLines: 5,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: addDescriptionToReportProblem,
                    ),
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
                              try {
                                controller.isLoading(true);

                                VxToast.show(context, msg: sendReport);

                                await controller.uploadImageInReportProblem();

                                await controller.storeImageInReportProblem(
                                  img: controller.imageLink,
                                  desc: controller.descController.text,
                                );
                                Get.back();
                              } catch (e) {
                                controller.isLoading(false);

                                VxToast.show(context, msg: 'يجب إضافة صورة');
                              }
                            }
                          },
                          textColor: whiteColor,
                          title: send,
                        ),
                ],
              )
                  .box
                  .white
                  .roundedSM
                  .padding(const EdgeInsets.all(10))
                  .margin(const EdgeInsets.all(10))
                  .make(),
            ),
          ),
        ),
      ),
    );
  }
}
