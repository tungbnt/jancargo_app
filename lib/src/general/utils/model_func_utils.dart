import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';

Future<dynamic> openDialogBox(BuildContext context, Widget widget,{bool? isBarrierDismissible = true}) async{
  return await showDialog(
      barrierColor: AppColors.white.withOpacity(0.6),
      context: context,
      barrierDismissible: isBarrierDismissible!,
      builder: (context) {
        return widget;
      });
}

openBottomSheetBox(BuildContext context, Widget widget) {
  return showModalBottomSheet(
      isScrollControlled: true,
      barrierColor: const Color.fromRGBO(255, 255, 255, 0.85),
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return widget;
      });
}
