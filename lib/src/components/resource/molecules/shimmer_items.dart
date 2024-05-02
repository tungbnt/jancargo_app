import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../general/constants/app_colors.dart';
import '../../../util/app_gap.dart';

class ShimmerItems extends StatelessWidget {
  const ShimmerItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 182,
      color: AppColors.white,
      alignment: Alignment.center,
      padding: EdgeInsets.all(AppGap.h10,),
      child: Center(
        child: GridView.builder(
          primary: false,
          scrollDirection: Axis.horizontal,
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 5/4,
            crossAxisSpacing: AppGap.h5,
            mainAxisSpacing:  AppGap.h5,),
          itemCount: 10,
          itemBuilder: (context, index) =>itemShimmer(),
        ),
      ),
    );
  }
  Widget itemShimmer()=> Shimmer.fromColors(
    baseColor: AppColors.neutral300Color,
    highlightColor: AppColors.neutral100Color,
    child: SizedBox(
      width: AppGap.w48,

      child: Column(
        children: [
          Container(
            height: AppGap.h48,
            width: AppGap.w48,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius:  BorderRadius.all(Radius.circular(AppGap.r8)),
            ),
          ),
          AppGap.sbH5,
          Container(height: AppGap.h5,width: AppGap.w48, decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius:  BorderRadius.all(Radius.circular(AppGap.r8)),
          ),),
        ],
      ),
    ),
  );
}
