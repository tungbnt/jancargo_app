import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';

import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_images.dart';
import '../../../util/app_gap.dart';


class GroupOptionItem extends StatelessWidget {
  const GroupOptionItem({
    super.key,
    required this.onTap,
    required this.titleLangKey,
    this.titleColor,
    this.iconData,
    this.icon,
    this.isDense = false,
    this.trailingAction,
  });

  final String titleLangKey;
  final Color? titleColor;
  final IconData? iconData;
  final Widget? icon;
  final bool isDense;
  final bool? trailingAction;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {


    return InkWell(
      onTap: onTap,
      child: Ink(
        color: AppColors.white,
        child: Padding(
          padding: isDense ? EdgeInsets.all(10) :  EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              if (iconData != null) ...[
                Icon(iconData!, size: 20, color: AppColors.neutral800Color),
                AppGap.sbW12,
              ] else if (icon != null) ...[
                icon!,
                AppGap.sbW12,
              ]else ...[AppGap.sbW12],
              Expanded(
                child: Text(
                  titleLangKey,
                  style:AppStyles.text5014(),
                ),
              ),
              if (trailingAction == true) ...[
                AppGap.sbW8,
                SvgPicture.asset(AppImages.icArrowight,),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
