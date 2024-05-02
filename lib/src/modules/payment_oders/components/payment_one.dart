import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/oder_management/screens/oder_management_screen.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../components/resource/molecules/app_button.dart';
import '../../../components/resource/molecules/triangle.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/app_strings/app_strings.dart';
import '../../../general/constants/app_colors.dart';

class PaymentOne extends StatelessWidget {
  const PaymentOne(
      {super.key,
      required this.shipService,
      required this.shipPay,
      required this.shipInland});

  final String shipService;
  final String shipPay;
  final String shipInland;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          color: AppColors.white,
          padding: EdgeInsets.symmetric(
              vertical: AppGap.h10, horizontal: AppGap.w10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.of(context).oneStPayment,
                style: AppStyles.text6016(),
              ),
              _row(AppStrings.of(context).totalProductCost, shipService),
              _row(AppStrings.of(context).paymentFees, shipPay),
              _row(AppStrings.of(context).serviceCharge, shipInland),
              AppGap.sbH10,
              _notePayment(),
              _btnPayment(context),
            ].expand((e) => [e, AppGap.sbH10]).toList(),
          ),
        ),
        const Align(
          alignment: Alignment.topRight,
          child: CustomTriangle(),
        )
      ],
    );
  }

  Widget _btnPayment(BuildContext context) => AppButton(
        enable: true,
        onPressed: () => RouteService.routeGoOnePage(const OderManagement()),
        text: AppStrings.of(context).paymentOrders,
        radius: AppGap.r8,
        color: AppColors.yellow800Color,
        borderColor: AppColors.neutral200Color,
      );

  Widget _notePayment() => const Text('*Quý khách nên thanh toán ngay tránh sản phẩm bị tăng giá do chênh lệch tỉ giá');

  Widget _row(String ship, String number) {
    return Row(
      children: [
        Text(ship),
        const Spacer(),
        Text(
          number == '0'
              ? '__'
              : AppConvert.convertAmountJp(
                  int.parse(number),
                ),
        ),
      ],
    );
  }
}
