import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rokastore/consts/colors.dart';
import 'package:rokastore/consts/firebase_const.dart';
import 'package:rokastore/consts/lists.dart';
import 'package:rokastore/consts/strings.dart';
import 'package:rokastore/controllers/profile_controller.dart';
import 'package:rokastore/screens/profile_screen/edit_profile_screen.dart';
import 'package:rokastore/screens/profile_screen/favorites_screen.dart';
import 'package:rokastore/screens/profile_screen/orders_screen/orders_screen.dart';
import 'package:rokastore/screens/profile_screen/report_problem.dart';
import 'package:rokastore/screens/profile_screen/request_product.dart';
import 'package:rokastore/screens/profile_screen/suggest_screen.dart';
import 'package:rokastore/services/firestore_services.dart';
import 'package:rokastore/widget_common/logout_dialog.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return Scaffold(
      body: StreamBuilder(
        stream: FirestoreServices.getUser(currentUser!.uid),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else {
            var data = snapshot.data!.docs;

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //profile
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var userData = data[index];
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        '${userData['name']}'
                                            .text
                                            .semiBold
                                            .maxLines(1)
                                            .overflow(TextOverflow.ellipsis)
                                            .make(),
                                        '${userData['email']}'
                                            .text
                                            .maxLines(1)
                                            .overflow(TextOverflow.ellipsis)
                                            .make(),
                                        '${userData['address']}'
                                            .text
                                            .maxLines(1)
                                            .overflow(TextOverflow.ellipsis)
                                            .make(),
                                      ],
                                    ),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            const LogoutDialog(),
                                      );
                                    },
                                    child: 'تسجيل الخروج'.text.make(),
                                  ),
                                ],
                              ),
                              (context.screenHeight / 100).heightBox,
                              OutlinedButton(
                                onPressed: () {
                                  controller.nameController.text =
                                      data[0]['name'];

                                  controller.emailController.text =
                                      data[0]['email'];

                                  controller.phoneController.text =
                                      data[0]['phone'];

                                  controller.addressController.text =
                                      data[0]['address'];

                                  Get.to(() => EditProfileScreen(data: data));
                                },
                                child: editProfile.text.make(),
                              ).box.width(context.screenWidth).make(),
                            ],
                          )
                              .box
                              .white
                              .roundedSM
                              .padding(const EdgeInsets.all(10))
                              .make();
                        },
                      ),

                      (context.screenHeight / 100).heightBox,

                      //account list
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => SizedBox(
                          child: ListTile(
                            leading: Image.asset(
                              profileIconsList[index],
                              width: context.screenWidth / 17,
                            ),
                            title:
                                profileButtonsList[index].text.semiBold.make(),
                          ),
                        ).box.make().onTap(() {
                          index == 0
                              ? Get.to(() => const FavoritesScreen())
                              : Get.to(() => const OrdersScreen());
                        }),
                        separatorBuilder: (context, index) => const Divider(
                          color: lightGrey,
                        ),
                        itemCount: profileButtonsList.length,
                      )
                          .box
                          .white
                          .roundedSM
                          .padding(const EdgeInsets.symmetric(horizontal: 10))
                          .make(),
                      (context.screenHeight / 100).heightBox,

                      //app list
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => SizedBox(
                          child: ListTile(
                            leading: Image.asset(
                              appIconsList[index],
                              width: context.screenWidth / 17,
                            ),
                            title: appButtonsList[index].text.semiBold.make(),
                          ),
                        ).box.make().onTap(() {
                          index == 0
                              ? Get.to(() => const RequestProductScreen())
                              : index == 1
                                  ? Get.to(() => const ReportProblemScreen())
                                  : Get.to(() => const SuggestScreen());
                        }),
                        separatorBuilder: (context, index) => const Divider(
                          color: lightGrey,
                        ),
                        itemCount: appButtonsList.length,
                      )
                          .box
                          .white
                          .roundedSM
                          .padding(const EdgeInsets.symmetric(horizontal: 10))
                          .make(),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
