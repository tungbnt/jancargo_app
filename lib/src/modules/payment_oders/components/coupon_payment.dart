import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/coupon/screen/coupon_screen.dart';
import 'package:jancargo_app/src/modules/payment_oders/bloc/payment_oders_cubit.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

class CouponPayment extends StatelessWidget {
  const CouponPayment({super.key, required this.cubit});

  final PaymentOdersCubit cubit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        RouteService.routeGoOnePage(CouponScreen());
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(AppImages.icCouponPayment),
                  Text(
                    'Voucher Jancargo',
                    style: AppStyles.text5014(
                        color: AppColors.neutral800Color),
                  ),
                ],
              ),
              const Icon(Icons.navigate_next_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
