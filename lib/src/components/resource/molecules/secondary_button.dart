import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';


class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    this.onPressed,
    this.backgroundColor,
    this.border,
    this.prefixIcon,
    this.suffixIcon,
    this.text,
    this.textStyle,
    this.textColor,
    this.isCenter,
    this.padding,
    this.flexible = false,
  });
  final String? text;
  final TextStyle? textStyle;
  final Color? backgroundColor;

  final BoxBorder? border;
  final Color? textColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? isCenter;
  final EdgeInsetsGeometry? padding;
  final bool flexible;
  // final double? borderRadius;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: onPressed != null ? backgroundColor : AppColors.neutral200Color,
          border: border,
        ),
        alignment: isCenter == true ? Alignment.center : Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: isCenter == true ? MainAxisAlignment.center : MainAxisAlignment.start,
          mainAxisSize: flexible ? MainAxisSize.min : MainAxisSize.max,
          children: [
            prefixIcon ?? Container(),
            Padding(
              padding: padding ?? const EdgeInsets.all(0),
              child: Text(
                text ?? '',
                style: textStyle ??
                   AppStyles.text4012(
                      color: onPressed != null ? textColor : Colors.white,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            suffixIcon ?? Container(),
          ],
        ),
      ),
    );
  }
}
