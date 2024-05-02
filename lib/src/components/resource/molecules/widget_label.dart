import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';


class WidgetLabel extends StatelessWidget {
  const WidgetLabel({
    super.key,
    required this.label,
    this.isRequire = false,
    this.requireColor = Colors.red,
  });

  final String label;
  final bool isRequire;
  final Color? requireColor;

  @override
  Widget build(BuildContext context) {


    if (isRequire) {
      return Text.rich(TextSpan(
        children: [
          TextSpan(
            text: label,
            style: AppStyles.text4014(color: AppColors.neutral800Color),
          ),
          TextSpan(
            text: ' *',
            style: AppStyles.text4014(color: requireColor),
          ),
        ],
        style: AppStyles.text4014(color: AppColors.primary800Color),
      ));
    }

    return Text(
      label,
      style:AppStyles.text4014(color: AppColors.neutral800Color),
    );
  }
}
