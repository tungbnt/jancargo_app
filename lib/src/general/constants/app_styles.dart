import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';

class AppStyles {

// text style 700
  static TextStyle text7024({Color? color, double? height}) {
    return TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700, height: height ?? 1.5,color: color ?? AppColors.black03);
  }
  static TextStyle text7018({Color? color, double? height}) {
    return TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, height: height ?? 1.5,color: color ?? AppColors.black03);
  }
  static TextStyle text7016({Color? color, double? height}) {
    return TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, height: height ?? 1.5,color: color ?? AppColors.color9E9E9E);
  }
// text style 600
  static TextStyle text6024({Color? color, double? height}) {
    return TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600, height: height ?? 1.5,color: color ?? AppColors.black03);
  }
  static TextStyle text6020({Color? color, double? height}) {
    return TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, height: height ?? 1.5,color: color ?? AppColors.black03);
  }
  static TextStyle text6016({Color? color, double? height}) {
    return TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, height: height ?? 1.5,color: color ?? AppColors.black03);
  }
  static TextStyle text6014({Color? color, double? height}) {
    return TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, height: height ?? 1.5,color: color ?? AppColors.yellow700Color);
  }
  // text style 500
  static TextStyle text5008({Color? color, double? height}) {
    return TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w500, height: height ?? 1.5,color: color ?? AppColors.black03);
  }
  static TextStyle text5020({Color? color, double? height}) {
    return TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, height: height ?? 1.5,color: color ?? AppColors.neutral800Color);
  }
  static TextStyle text5016({Color? color, double? height}) {
    return TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, height: height ?? 1.5,color: color ?? AppColors.neutral800Color);
  }
  static TextStyle text5014({Color? color, double? height}) {
    return TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, height: height ?? 1.5,color: color ?? AppColors.neutral700Color);
  }
  static TextStyle text5012({Color? color, double? height}) {
    return TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, height: height ?? 1.5,color: color ?? AppColors.neutral700Color);
  }

  // text style 400
  static TextStyle text4010({Color? color, double? height}) {
    return TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, height: height ?? 1.5,color: color ?? AppColors.neutral600Color);
  }
  static TextStyle text4024({Color? color, double? height}) {
    return TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400, height: height ?? 1.5,color: color ?? AppColors.black03);
  }
  static TextStyle text4017({Color? color, double? height}) {
    return TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w400, height: height ?? 1.5,color: color ?? AppColors.black03);
  }
  static TextStyle text4016({Color? color, double? height}) {
    return TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, height: height ?? 1.5,color: color ?? AppColors.black03);
  }
  static TextStyle text4014({Color? color, double? height}) {
    return TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, height: height ?? 1.5,color: color ?? AppColors.neutral400Color);
  }
  static TextStyle text4012({Color? color, double? height}) {
    return TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, height: height ?? 1.5,color: color ?? AppColors.neutral400Color);
  }
}