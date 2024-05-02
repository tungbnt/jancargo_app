import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/util/app_gap.dart';


class CountingIndicator extends StatelessWidget {
  const CountingIndicator({
    super.key,
    required this.count,
    this.color,
    this.dimension = 16,
  });

  final ValueNotifier<int> count;
  final Color? color;
  final double dimension;

  @override
  Widget build(BuildContext context) {


    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(AppGap.r8)),
        color: color ?? AppColors.primary500Color,
      ),
      width: AppGap.w20,
      height: AppGap.h14,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 2, left: 1),
      child: Center(
        child: Text(
          '${count.value > 99 ? '99+' : count.value}',textAlign: TextAlign.center,
          style: AppStyles.text4010(color: AppColors.white),
        ),
      ),
    );
  }
}
