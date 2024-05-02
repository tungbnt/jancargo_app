import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../general/constants/app_images.dart';

class ContainerAddCartAnimation extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;
  final Color color;
  final Color? textColor;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final String text;
  final double? textSize;
  final String? icon;
  final bool enable;
  final bool isChecked;
  final FontWeight? fontWeight;
  final EdgeInsets? padding;
  final GlobalKey widgetKey;

  const ContainerAddCartAnimation(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.width,
      this.radius = 8,
      this.borderColor,
      this.color = AppColors.yellow800Color,
      this.textColor = AppColors.white,
      this.height = 55.0,
      this.textSize = 16,
      this.icon,
      this.enable = true,
      this.isChecked = false,
      this.fontWeight = FontWeight.normal,
      this.padding,
      required this.widgetKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: enable ? color : AppColors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Stack(
        children: [
          ElevatedButton(
            onPressed: enable ? onPressed : null,
            style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: padding,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    side: enable
                        ? BorderSide(color: borderColor ?? color)
                        : BorderSide.none,
                    borderRadius: BorderRadius.circular(radius))),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  icon != null && icon!.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(right: 4.w),
                          child: Container(
                              key: widgetKey,
                              child: SvgPicture.asset(icon ?? '', width: 24.w)),
                        )
                      : const SizedBox(),

                  icon != null && icon!.isNotEmpty
                      ? AppGap.sbW2
                      : const SizedBox(),
                  Text(
                    text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: textSize ?? 16,
                        color: borderColor == null ? Colors.white : textColor,
                        fontWeight: fontWeight),
                  ),
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 16.0),
          //   child: Align(alignment: Alignment.centerRight, child: isChecked ? SvgPicture.asset(AppImages.icCheck) : Container()),
          // ),
        ],
      ),
    );
  }
}
