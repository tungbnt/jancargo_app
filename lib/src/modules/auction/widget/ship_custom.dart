import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../components/resource/molecules/triangle.dart';
import '../../../general/constants/app_colors.dart';

class CustomShip extends StatelessWidget {
  const CustomShip({super.key, required this.shipService, required this.shipPay, required this.shipInland});
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
          padding: EdgeInsets.symmetric(vertical: AppGap.h10,horizontal: AppGap.w10),
          margin: EdgeInsets.only(bottom: AppGap.h78),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.of(context).auctionFee,style: AppStyles.text6016(),),
              _row(AppStrings.of(context).serviceCharge,shipService),
              _row(AppStrings.of(context).paymentFees,shipPay),
              _row(AppStrings.of(context).domesticShippingFee,shipInland),

            ].expand((e) => [e,AppGap.sbH5]).toList(),
          ),
        ),
        const Align(
          alignment: Alignment.topRight,
          child:   CustomTriangle(),
        )
      ],
    );
  }

  Widget _row(String ship,String number) {
    return Row(
    children: [
      Text(ship),
      const Spacer(),
      Text(number == '0' ? '__' : AppConvert.convertAmountJp(int.parse(number),),),
    ],
  );
  }
}
