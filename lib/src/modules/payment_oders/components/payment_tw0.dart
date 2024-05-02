import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../components/resource/molecules/app_button.dart';
import '../../../components/resource/molecules/triangle.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_colors.dart';
import '../widget/accordion_payment.dart';

class PaymentTwo extends StatelessWidget {
  const PaymentTwo(
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
                'Thanh toán lần 2 (Sau)',
                style: AppStyles.text6016(color: AppColors.neutral600Color),
              ),
              Container(
                color: AppColors.white,
                child: AccordionPayment(
                  shipInland: shipInland,
                  shipService: shipService,
                  shipPay: shipPay,
                ),
              )
            ].expand((e) => [e, AppGap.sbH5]).toList(),
          ),
        ),
        const Align(
          alignment: Alignment.topRight,
          child: CustomTriangle(color: AppColors.neutral300Color,),
        )
      ],
    );
  }

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
