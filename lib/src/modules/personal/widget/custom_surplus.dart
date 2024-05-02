import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../general/constants/app_colors.dart';

class CustomSurplus extends StatelessWidget {
  CustomSurplus(
      {super.key,
      required this.number,
      });

  final int number;
  final ValueNotifier<bool> isObscure = ValueNotifier(false);
  final StreamController<bool> streamControllerObscure = StreamController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isObscure,
        builder: (context, value,_) {
        return Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: AppGap.h10, horizontal: AppGap.w10),
              margin: EdgeInsets.symmetric(horizontal: AppGap.w10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(AppGap.r4)),
                border: Border.all(color: AppColors.neutral300Color),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(AppImages.icWallet),
                  AppGap.sbW8,
                  Text(
                    'Số dư',
                    style: AppStyles.text5014(color: AppColors.neutral600Color),
                  ),
                  const Spacer(),
                  Text(
                    !value
                        ? "*********"
                        : AppConvert.convertAmountVn(number).replaceAll('đ', 'VND'),
                    style: AppStyles.text4016(
                        color:  !value
                            ? AppColors.neutral800Color
                            : AppColors.primary800Color),
                    textAlign: TextAlign.center,
                  ),
                  AppGap.sbW40,
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 20,
              bottom: 0,
              child:  Center(
                child: GestureDetector(
                  onTap: () {
                    isObscure.value = !isObscure.value;
                  },
                  child: SvgPicture.asset(
                      !value ? AppImages.icEye : AppImages.icEye),
                ),
              ),
            )
          ],
        );
      }
    );
  }
}
