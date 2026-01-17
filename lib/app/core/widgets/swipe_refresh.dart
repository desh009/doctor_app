import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';



class SwipeRefresh extends StatelessWidget {
  final bool? primary;
  final RefreshController controller;
  final VoidCallback onRefresh;
  final VoidCallback? onLoading;
  final List<Widget>? children;
  final Widget? child;
  final bool enablePullUp;
  final ScrollController? scrollController;
  final ScrollPhysics? physics;
  final Color? loadingThemeColor;

  const SwipeRefresh({super.key, required this.controller, required this.onRefresh, this.onLoading, this.children, this.child, this.scrollController, this.physics, this.primary, this.loadingThemeColor, this.enablePullUp = false});

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      child: child ?? ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: children ?? [],
      ),
      scrollController: scrollController,
      onRefresh: onRefresh,
      onLoading: onLoading,
      physics: physics,
      // header: const WaterDropMaterialHeader(backgroundColor: AppColors.primary, color: AppColors.black,),
      footer: ClassicFooter(
        noDataText: '',
        textStyle: Get.textTheme.bodyLarge!.copyWith(color: loadingThemeColor ?? Get.textTheme.bodyLarge!.color),
        loadingIcon: SizedBox(
          width: 25.0,
          height: 25.0,
          child: Platform.isIOS
              ? CupertinoActivityIndicator(color: loadingThemeColor ?? Get.textTheme.bodyLarge!.color,)
              : const CircularProgressIndicator(),
        ),
      ),
      enablePullDown: true,
      primary: primary ?? false,
      enablePullUp: onLoading != null ? true : false,
      controller: controller,
    );
  }
}


