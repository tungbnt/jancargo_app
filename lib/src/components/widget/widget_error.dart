import 'package:flutter/material.dart';

import '../../domain/services/navigator/route_service.dart';
import '../../general/constants/app_colors.dart';
import '../../general/constants/app_images.dart';
import '../../general/constants/app_styles.dart';
import '../../modules/dashboard/screens/dashboard_screen.dart';
import '../../util/app_gap.dart';
import '../resource/molecules/app_button.dart';

class ErrorCustomWidget extends StatelessWidget {
  const ErrorCustomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: AppColors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(AppImages.imgErrorInternet),
          Text('Ôi không! Có lỗi đã xảy ra',style: AppStyles.text4016(color: AppColors.neutral800Color),),
          AppGap.sbH20,
          SizedBox(
            width: AppGap.w136,
            child: AppButton(
              enable: true,
              height: AppGap.h40,
              onPressed: () =>
                  RouteService.routeGoOnePage(const DashboardView()),
              text: "Trang chủ",
              radius: AppGap.r4,
              color: AppColors.yellow700Color,
              borderColor: AppColors.neutral200Color,
              textColor: AppColors.neutral800Color,
            ),
          ),
        ],
      ),
    );
  }
}
