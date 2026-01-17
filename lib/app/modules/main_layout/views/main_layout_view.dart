import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:group_app/app/constans/assets.dart';


import '../controllers/main_layout_controller.dart';

class MainLayoutView extends GetView<MainLayoutController> {
  MainLayoutView({super.key});

  final List<DrawerItem> drawerItems = [

    // DrawerItem(
    //   title: "History",
    //   icon: Icons.history,
    //   page: const HistoryView(),
    //   binding: HistoryBinding(),
    // ),
    // DrawerItem(
    //   title: "Car Assigned",
    //   icon: Icons.car_rental,
    //   page: const CarAssignedView(),
    //   binding: CarAssignedBinding(),
    // ),
    // DrawerItem(
    //   title: "Settings",
    //   icon: Icons.settings,
    //   page: const SettingsView(),
    //   binding: SettingsBinding(),
    // ),
    DrawerItem(
      title: "Logout",
      icon: Icons.logout,
      page: null,
      binding: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainLayoutController>(
        init: controller,
        builder: (context) {
          return Obx(
            () => Scaffold(
              key: controller.mainLayoutKey,
              appBar: AppBar(
                // iconTheme: const IconThemeData(color: AppColors.black),
              ),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppAssets.header),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              AppAssets.logo,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Text(
                          //   "Probashi Taxi Driver",
                          //   style: Get.textTheme.titleLarge,
                          // ),
                        ],
                      ),
                    ),
                    Column(
                      children: drawerItems
                          .map(
                            (e) => ListTile(
                              // title: Text(
                              //   e.title,
                              //   style: Get.textTheme.bodyLarge!.copyWith(
                              //     color: controller.currentIndex.value ==
                              //             drawerItems.indexOf(e)
                              //         ? AppColors.primary
                              //         : AppColors.black,
                              //   ),
                              // ),
                              // leading: Icon(
                              //   e.icon,
                              //   size: 24,
                              //   color: controller.currentIndex.value ==
                              //           drawerItems.indexOf(e)
                              //       ? AppColors.primary
                              //       : AppColors.grayDark,
                              // ),
                              onTap: () {
                                if (e.title == "Logout") {
                                  controller.logout();
                                  return;
                                } else {
                                  controller.changePage(drawerItems.indexOf(e));
                                }
                                Get.back();
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
              body: PageView.builder(
                controller: controller.pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: drawerItems.length,
                itemBuilder: (context, index) {
                  drawerItems[index].binding!.dependencies();
                  return drawerItems[index].page!;
                },
              ),
            ),
          );
        });
  }
}

class DrawerItem {
  final String title;
  final IconData icon;
  final Widget? page;
  final Bindings? binding;

  DrawerItem({
    required this.title,
    required this.icon,
    required this.page,
    required this.binding,
  });
}
