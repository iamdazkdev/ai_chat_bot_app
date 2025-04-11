import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quicklai/controller/dashboard_controller.dart';
import 'package:quicklai/theam/constant_colors.dart';
import 'package:quicklai/ui/home/category_list/category_list_screen.dart';
import 'package:quicklai/ui/home/home_screen/home_screen.dart';
import 'package:quicklai/ui/subscription/subscription_screen.dart';
import 'package:sizer/sizer.dart';

import '../../constant/constant.dart';
import '../setting/setting_screen.dart';
import '../text_to_image/text_to_image/text_to_image_screen.dart';

class DashBoardTwo extends StatelessWidget {
  const DashBoardTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetX<DashBoardController>(
        init: DashBoardController(),
        initState: (state) {
          if (Constant.isActiveSubscription == true) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(context);
            });
          }
        },
        builder: (controller) {
          return Scaffold(
            body: controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : controller.index.value == 0
                    ? const HomeScreen()
                    : controller.index.value == 1
                        ? const CategoryListScreen(
                            isShowing: true,
                          )
                        : controller.index.value == 2
                            ? const TextToImageScreen()
                            : SettingScreen(),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: ConstantColors.grey01,
              type: BottomNavigationBarType.fixed,
              currentIndex: controller.index.value,
              selectedItemColor: ConstantColors.blue04,
              unselectedItemColor: ConstantColors.grey03,
              selectedIconTheme: IconThemeData(color: ConstantColors.blue04),
              onTap: (value) {
                // if (value == 2) {
                //   Get.to(const SelectCharacterScreen(), transition: Transition.downToUp);
                //   // Get.to(const ChatBotScreen());
                // } else {
                controller.index.value = value;
                // }
              },
              items: [
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/icons/ic_home_icon.svg",
                      colorFilter: ColorFilter.mode(
                          controller.index.value == 0
                              ? ConstantColors.blue04
                              : ConstantColors.grey03,
                          BlendMode.srcIn),
                    ),
                    label: 'Home'),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/images/ic_category.svg",
                    colorFilter: ColorFilter.mode(
                        controller.index.value == 1
                            ? ConstantColors.blue04
                            : ConstantColors.grey03,
                        BlendMode.srcIn),
                  ),
                  label: "Category",
                ),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/icons/ic_gallery.svg",
                      colorFilter: ColorFilter.mode(
                          controller.index.value == 2
                              ? ConstantColors.blue04
                              : ConstantColors.grey03,
                          BlendMode.srcIn),
                    ),
                    label: "Image"),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/icons/ic_setting_Icon.svg",
                      colorFilter: ColorFilter.mode(
                          controller.index.value == 3
                              ? ConstantColors.blue04
                              : ConstantColors.grey03,
                          BlendMode.srcIn),
                    ),
                    label: "Settings")
              ],
            ),
            // bottomNavigationBar: ConvexAppBar(
            //   initialActiveIndex: controller.index.value,
            //   backgroundColor: ConstantColors.cardViewColor,
            //   activeColor: ConstantColors.primary,
            //   color: Colors.white,
            //   height: 55,
            //   curveSize: 80,
            //   onTabNotify: (index) {
            //     if (index == 1) {
            //       Get.to(const SelectCharacterScreen(),
            //           transition: Transition.downToUp);
            //       // Get.to(const ChatBotScreen());
            //       return false;
            //     }
            //     return true;
            //   },
            //   items: [
            //     TabItem(
            //         activeIcon: Padding(
            //           padding: const EdgeInsets.all(18),
            //           child: SvgPicture.asset('assets/icons/ic_home.svg',
            //               semanticsLabel: 'Acme Logo'.tr),
            //         ),
            //         icon: SvgPicture.asset('assets/icons/ic_home.svg',
            //             semanticsLabel: 'Acme Logo'.tr),
            //         title: 'Home'.tr),
            //     TabItem(
            //         activeIcon: Padding(
            //           padding: EdgeInsets.all(18.w),
            //           child: SvgPicture.asset('assets/icons/ic_chat.svg',
            //               semanticsLabel: 'Acme Logo'.tr),
            //         ),
            //         icon: SvgPicture.asset('assets/icons/ic_chat.svg',
            //             semanticsLabel: 'Acme Logo'.tr),
            //         title: 'Chat'.tr),
            //     TabItem(
            //         activeIcon: Padding(
            //           padding: const EdgeInsets.all(18),
            //           child: SvgPicture.asset('assets/icons/ic_image.svg',
            //               semanticsLabel: 'Acme Logo'.tr),
            //         ),
            //         icon: SvgPicture.asset('assets/icons/ic_image.svg',
            //             semanticsLabel: 'Acme Logo'.tr),
            //         title: 'Image'.tr),
            //     TabItem(
            //         activeIcon: Padding(
            //           padding: const EdgeInsets.all(18),
            //           child: SvgPicture.asset('assets/icons/ic_setting.svg',
            //               semanticsLabel: 'Acme Logo'.tr),
            //         ),
            //         icon: SvgPicture.asset('assets/icons/ic_setting.svg',
            //             semanticsLabel: 'Acme Logo'.tr),
            //         title: 'Settings'.tr),
            //   ],
            //   onTap: (index) {
            //     controller.index.value = index;
            //   },
            // )
          );
        },
      );
    });
  }

  showDialog(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return const FractionallySizedBox(
              heightFactor: 0.99, child: SubscriptionScreen());
        });
  }
}
