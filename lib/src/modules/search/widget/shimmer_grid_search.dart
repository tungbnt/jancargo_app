import 'package:flutter/material.dart';
import 'package:jancargo_app/src/modules/search/widget/search_shimmer_grid_item.dart';

import '../../../util/app_gap.dart';

class SearchShimmerGrid extends StatelessWidget {
  const SearchShimmerGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(
        AppGap.h10,
      ),
      sliver: SliverGrid(
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
    );
  }
}
