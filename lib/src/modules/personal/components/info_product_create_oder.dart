import 'package:flutter/material.dart';

import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../general/app_strings/app_strings.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_gap.dart';

class InfoProductCreateOder extends StatelessWidget {
  const InfoProductCreateOder({super.key, });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.white,
      padding:
      EdgeInsets.symmetric(vertical: AppGap.h10, horizontal: AppGap.w10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: AppGap.w144,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(AppGap.r8))),
                child: AppCarouselImages(
                  fit: BoxFit.fill,
                  height: AppGap.h136,
                  // ignore: invalid_use_of_protected_member
                  imagesUrl: [],
                  alignment: Alignment.topCenter,
                  borderRadius: BorderRadius.zero,
                  autoPlay: false,
                  showIndicatorBottom: false,
                  imageDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(AppGap.r8),),),
                ),
              ),
              Container(
                width: AppGap.w195,
                height: AppGap.h136,
                padding: EdgeInsets.only(left: AppGap.w3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: AppGap.w208,
                      child: Text(
                        'đồng hồ',
                        style:
                        AppStyles.text4012(color: AppColors.neutral800Color),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('${AppStrings.of(context).currentPrice}: ',
                            style: AppStyles.text5012(
                                color: AppColors.neutral700Color)),
                        Text(
                          "tùng",
                          style: AppStyles.text4016(
                              color: AppColors.yellow800Color),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
