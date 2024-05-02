import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_colors.dart';
import '../../web_view/screen/web_view.dart';

class WalletOders extends StatelessWidget {
  const WalletOders({super.key, required this.number,  this.color = AppColors.white, this.callBack});
  final int number;
  final Color color;
  final VoidCallback? callBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,


      padding: EdgeInsets.symmetric(vertical: AppGap.h10,horizontal: AppGap.w10),
      child:Column(
        children: [
          Row(
            children: [
              Text(AppStrings.of(context).paymentMethods,style: AppStyles.text6014(color: AppColors.neutral800Color),),
              const Spacer(),
              GestureDetector(
                  onTap: () async{
                    Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
                    String isToken = hiveBox.get(AppConstants.ACCESS_TOKEN);
                    await RouteService.routeGoOnePage(WebViewScreen(url: "https://m.jancargo.com/redirect?access_token=$isToken&next=/account/wallet/billing?view=app",title: "Nạp tiền",));
                    callBack!();

                  },
                  child: Text(AppStrings.of(context).topUp,style: AppStyles.text5014(color: AppColors.primary800Color),)),
            ],
          ),
          AppGap.sbH5,
          Container(
            height: AppGap.h55,
            padding: EdgeInsets.symmetric(vertical: AppGap.h10,horizontal: AppGap.w10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(AppGap.r8)),
                color: AppColors.white,
                boxShadow:  [BoxShadow(
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                    spreadRadius: 0,
                    color: AppColors.back.withOpacity(0.25)
                )]
            ),
            child: Row(
              children: [
                SvgPicture.asset(AppImages.icWallet),
                AppGap.sbW8,
                Text(AppStrings.of(context).walletJan,style: AppStyles.text5014(color: AppColors.neutral600Color),),
                const Spacer(),
                Text(AppConvert.convertAmountVn(number).replaceAll('đ', 'Đ'),style: AppStyles.text4016(color: AppColors.neutral800Color),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
