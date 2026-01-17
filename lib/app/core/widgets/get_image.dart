// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:probashi_taxi_driver/app/core/utils/show_massege.dart';

// import '../../main.dart';
// import '../core/theme/app_colors.dart';

// Future<List<File>> getImage({bool isMultiple = false}) async {
//   var source = await showCupertinoModalPopup(
//     barrierColor: AppColors.grayDark.withOpacity(.65),
//     context: Get.context!,
//     builder: (BuildContext context) => CupertinoActionSheet(
//       actions: <Widget>[
//         Container(
//           color: Get.theme.cardTheme.color,
//           child: CupertinoActionSheetAction(
//             onPressed: () {
//               Navigator.pop(context, ImageSource.camera);
//             },
//             child: Text(
//               appLanguage().camera,
//               style: Get.textTheme.titleSmall!.copyWith(color: AppColors.primary),
//             ),
//           ),
//         ),
//         Container(
//           color: Get.theme.cardTheme.color,
//           child: CupertinoActionSheetAction(
//             onPressed: () {
//               try{
//                 Navigator.pop(context, ImageSource.gallery);
//               }catch(e){
//                 debugPrint(e.toString());
//               }
//             },
//             child: Text(appLanguage().gallery, style: Get.textTheme.titleSmall!.copyWith(color: AppColors.primary)),
//           ),
//         ),
//       ],
//       cancelButton: Card(
//         margin: EdgeInsets.zero,
//         child: CupertinoActionSheetAction(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text(appLanguage().close, style: Get.textTheme.titleSmall!.copyWith(color: AppColors.primary)),
//         ),
//       ),
//     ),
//   );
//   if (source != null) {
//     final picker = ImagePicker();
//     List<File> pickedFile = [];
//     try {
//       if(source == ImageSource.camera || !isMultiple){
//         XFile? singleFile = await picker.pickImage(source: source, imageQuality: 50);
//         if (singleFile != null) {
//           var image =  await getImageSize(File(singleFile.path));
//           pickedFile.add(image);
//         }
//       }else{
//         var image =  await picker.pickMultiImage(imageQuality: 50);
//         for (var element in image) {
//           var image =  await getImageSize(File(element.path));
//           pickedFile.add(image);
//         }
//       }
//       return pickedFile;

//     } catch (e) {
//       debugPrint(e.toString());
//       return [];
//     }
//   } else {
//     return [];
//   }
// }

// Future getImageSize(File image) async {
//   final bytes = (await image.readAsBytes()).lengthInBytes;
//   final kb = bytes / 1024;
//   final mb = kb / 1024;
//   if (mb > 4) {
//     errorMessage(message: appLanguage().file_size_to_large_please_select_another_file);
//     return null;
//   } else {
//     return image;
//   }
// }
