import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jancargo_app/src/app_manager.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';

import '../../../components/resource/organisms/custom_snack_bar.dart';
import '../../../components/resource/organisms/top_snack_bar.dart';
import '../../../general/constants/app_styles.dart';

@singleton
class DialogService {
  static BuildContext get context =>
      AppManager.globalKeyRootMaterial.currentContext!;

  static Future<dynamic> hideDialog() async {
    return RouteService.pop();
  }

  static Future<dynamic> openDialog(Widget widget,
      {bool barrierDismissible = true}) {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      barrierDismissible: barrierDismissible,
      builder: (context) => Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: widget,
      ),
    );
  }

  static Future showCupertinoDialogAction(
      BuildContext context, {
        required String title,
        required String content,
        List<Widget> action = const [],
      }) {
    return showCupertinoModalPopup(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => CupertinoDialog(
        action: action,
        content: content,
        title: title,
      ),
    );
  }

  static Future showBottomSheet(BuildContext context, Widget action) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      barrierColor: AppColors.white.withOpacity(0.5),
      isScrollControlled: true,
      builder: (context) => action,
      elevation: 5,
    );
  }

  static Future<void>? showNotiBannerFailed(
      BuildContext context, Color colorText, String text) async {
    return showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: text,
        textStyle: AppStyles.text6016(color: AppColors.black03),
        backgroundColor: AppColors.white,
      ),
    );
  }

  static showNotiBannerSuccess(BuildContext context, String text) {
    return showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        message: text,
        textStyle: AppStyles.text6016(color: AppColors.white),
        icon: const Icon(
          Icons.sentiment_dissatisfied_rounded,
          color: Color(0x15000000),
          size: 120,
        ),
      ),
    );
  }

  static showNotiBannerInfo(BuildContext context, String text) {
    return showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(
        message: text,
        backgroundColor: AppColors.white,
        textStyle: AppStyles.text6016(color: AppColors.neutral800Color),
        icon: const Icon(
          Icons.sentiment_dissatisfied_rounded,
          color: Color(0x15000000),
          size: 120,
        ),
      ),
    );
  }
}

class CupertinoDialog extends StatelessWidget {
  const CupertinoDialog({
    super.key,
    required this.title,
    required this.content,
    this.action = const [],
  });

  final String title;
  final String content;
  final List<Widget> action;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: AppStyles.text5012(),
      ),
      content: Text(content,
          textAlign: TextAlign.center, style: AppStyles.text5012()),
      actions: action,
    );
  }
}
