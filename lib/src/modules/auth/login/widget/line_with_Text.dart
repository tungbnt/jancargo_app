import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';

class LineWithText extends StatelessWidget {
  const LineWithText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            child: Container(
              height: 1,
              color: AppColors.color9E9E9E,
            )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 9.w),
          child: Text(
            AppStrings.of(context).or,
            style: AppStyles.text4014(),
          ),
        ),
        Flexible(
            child: Container(
              height: 1,
              color: AppColors.color9E9E9E,
            ))
      ],
    );
  }
}
