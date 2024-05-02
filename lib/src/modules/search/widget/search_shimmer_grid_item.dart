import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../general/constants/app_colors.dart';
import '../../../util/app_gap.dart';

class SearchShimmerGridItem extends StatelessWidget {
  const SearchShimmerGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppGap.w174,
      decoration: BoxDecoration(
        // color: AppColors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppGap.r8),
            topRight: Radius.circular(AppGap.r8)),
      ),
      child: Shimmer.fromColors(
        baseColor: AppColors.neutral300Color,
        highlightColor: AppColors.neutral100Color,
        child: Column(
          children: [
            Container(
              width: AppGap.w174,
              height: AppGap.h188,
              padding: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppGap.r8),
                    topRight: Radius.circular(AppGap.r8)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    color: AppColors.white,
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
