import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../general/constants/app_colors.dart';
import '../../../util/app_gap.dart';

class BannerSliderShimmer extends StatelessWidget {
  const BannerSliderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Shimmer.fromColors(
          baseColor: AppColors.neutral300Color,
          highlightColor: AppColors.neutral100Color,
          child: Container(
            height: AppGap.h128,
            width: AppGap.w343,
            margin: EdgeInsets.symmetric(horizontal: AppGap.w10,vertical: AppGap.h10),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(AppGap.r8)),
            ),
          ),
        ),
        Positioned.fill(
          child: Icon(Icons.add_photo_alternate_rounded,size: AppGap.h40,color: AppColors.neutral50Color,),
        )
      ],
    );
  }
}
