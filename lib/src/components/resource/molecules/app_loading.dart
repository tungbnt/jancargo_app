import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:injectable/injectable.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/util/app_gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../app_manager.dart';
import '../../../modules/web_view/screen/web_view.dart';

@singleton
class AppLoading {
  static const List<Color> _kDefaultRainbowColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];
  static BuildContext get context =>
      AppManager.globalKeyRootMaterial.currentContext!;

  static Future<dynamic> hideLoading() async {
    return RouteService.pop();
  }
  static Future<dynamic> openPouringHour(
      {bool barrierDismissible = true}) async {
    showDialog(
        context: context,
        barrierColor: Colors.white.withOpacity(0.45),
        builder: (context) => const Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: SpinKitPouringHourGlassRefined(color: AppColors.yellow800Color,size: 40,strokeWidth: 2 ),
    ));
  }
  static Future<dynamic> openSpinkit(BuildContext context,
      {bool barrierDismissible = true}) async {
    showDialog(
        context: context,
        barrierColor: Colors.white.withOpacity(0.45),
        builder: (context) => const Dialog(
          insetPadding: EdgeInsets.zero,
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Positioned.fill(child: LoadingSpinkit()),
        ));
  }
}
