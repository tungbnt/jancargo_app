import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/modules/search/widget/search_shimmer_grid_item.dart';
import 'package:shimmer/shimmer.dart';
import 'package:slivers/slivers.dart';

import '../../../util/app_gap.dart';

class SearchShimmerGrid extends StatelessWidget {
  const SearchShimmerGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverContainer(
      decoration: const BoxDecoration(color: AppColors.white),
      padding: EdgeInsets.symmetric(vertical: AppGap.h5,horizontal: AppGap.w10),
      sliver: SliverGroup(
        slivers: [
          SliverToBoxAdapter(
            child: Shimmer.fromColors(
              baseColor: AppColors.neutral300Color,
              highlightColor: AppColors.neutral100Color,
              child: Container(
                width: double.infinity,

                height: AppGap.h20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(AppGap.r4),),
                  color: AppColors.white,
                ),
                margin: EdgeInsets.only(bottom: AppGap.h10,),
              ),
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 5 / 4,
                crossAxisSpacing: AppGap.h5,
                mainAxisSpacing: AppGap.h5,
                mainAxisExtent: AppGap.h221),
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return const SearchShimmerGridItem();
              },
              childCount: 6,
            ),
          ),
        ],
      ),
    );
  }
}
