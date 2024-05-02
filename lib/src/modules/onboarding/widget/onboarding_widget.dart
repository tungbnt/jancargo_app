import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jancargo_app/src/components/resource/molecules/app_button.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/modules/onboarding/widget/intro_text.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

class OnboardOne extends StatelessWidget {
  const OnboardOne(
      {super.key,
      required this.indicator,
      required this.title,
      required this.description,
      required this.textBtn,
      this.onPressed,
      required this.image,
      required this.pageId,
      this.onPressedBack});

  // final String pageId;
  final List<Widget> indicator;
  final String pageId;
  final String image;
  final String title;
  final String description;
  final String textBtn;
  final void Function()? onPressed;
  final void Function()? onPressedBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: Key(pageId),
      children: [
        AppGap.sbH40,
        SizedBox(
          height: 403.h,
          child: Image.asset(image),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.h, bottom: 40.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: indicator,
          ),
        ),
        TextIntro(
          title: title,
          description: description,
        ),
        const Spacer(),
        pageId == '1'
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: AppButton(
                  onPressed: onPressed,
                  text: textBtn,
                  height: 60.h,
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AppButton(
                        onPressed: onPressedBack,
                        text: AppStrings.of(context).back,
                        color: AppColors.neutral100Color,
                        borderColor: AppColors.black03,
                        textColor: AppColors.black03,
                      ),
                    ),
                    AppGap.sbW20,
                    Expanded(
                      child: AppButton(onPressed: onPressed, text: textBtn),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
