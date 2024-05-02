import 'package:flutter/widgets.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';


class ShimmerWrapper extends StatelessWidget {
  const ShimmerWrapper({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Shimmer.fromColors(
        baseColor: AppColors.neutral50Color,
        highlightColor: AppColors.neutral100Color,
        period: const Duration(milliseconds: 900),
        child: child,
      ),
    );
  }
}
