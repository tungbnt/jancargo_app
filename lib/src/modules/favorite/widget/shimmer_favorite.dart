import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../general/constants/app_colors.dart';

class ShimmerFavorite extends StatelessWidget {
  const ShimmerFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.neutral300Color,
      highlightColor: AppColors.neutral100Color,
      child: Container(


      ),
    );
  }
}
