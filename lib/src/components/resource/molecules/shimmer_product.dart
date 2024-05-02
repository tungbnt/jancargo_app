import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_gap.dart';
import 'btn_seen_all.dart';

class ShimmerProduct extends StatelessWidget {
  const ShimmerProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppGap.h235,
      color: AppColors.white,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: AppGap.h10,left: AppGap.h10,top: AppGap.h10,),
      child:Column(
        children: [
          _btn(),
          Expanded(
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  return itemShimmer() ;
                }, separatorBuilder: (context,int)=>AppGap.sbW8, itemCount: 4),
          ),
        ],
      ),

    );
  }
  Widget _btn()=> Shimmer.fromColors(
    baseColor: AppColors.neutral300Color,
    highlightColor: AppColors.neutral100Color,
    child: Row(children: [
      Container(height: AppGap.h10,width: AppGap.w70,color: AppColors.white,),
      Spacer(),
      SeenAllBtn(),
    ],),
  );
  Widget itemShimmer()=> Shimmer.fromColors(
    baseColor: AppColors.neutral300Color,
    highlightColor: AppColors.neutral100Color,
    child: SizedBox(
      width: AppGap.w144,

      child: Column(
        children: [
          Container(
            height: AppGap.h144,
            width: AppGap.w144,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius:  BorderRadius.only(topLeft: Radius.circular(AppGap.r8),topRight: Radius.circular(AppGap.r8)),
            ),
          ),
          AppGap.sbH5,
          Container(height: AppGap.h5,color: AppColors.white,),
          AppGap.sbH5,
          Container(height: AppGap.h5,color: AppColors.white,),
        ],
      ),
    ),
  );
}
