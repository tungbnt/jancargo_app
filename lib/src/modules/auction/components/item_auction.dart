import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/util/app_convert.dart';

import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_gap.dart';

class ItemAuctionScreen extends StatelessWidget {
  const ItemAuctionScreen({super.key, required this.price, required this.images, required this.name, required this.percent});
  final int price;
  final String name;
  final double percent;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      color: AppColors.white,
      padding:
      EdgeInsets.symmetric(vertical: AppGap.h10, horizontal: AppGap.w10),
      child: Row(
        children: [
          Container(
            width: AppGap.w144,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(AppGap.r8))),
            child: AppCarouselImages(
              fit: BoxFit.fill,
              height: AppGap.h136,
              // ignore: invalid_use_of_protected_member
              imagesUrl: images,
              alignment: Alignment.topCenter,
              borderRadius: BorderRadius.zero,
              autoPlay: false,
              showIndicatorBottom: false,
              imageDecoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(AppGap.r8),),),
            ),
          ),
          Container(
            width: AppGap.w195,
            height: AppGap.h136,
            padding: EdgeInsets.only(left: AppGap.w3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: AppGap.w208,
                  child: Text(
                    name,
                    style:
                    AppStyles.text4012(color: AppColors.neutral800Color),
                    maxLines: 3,
                  ),
                ),
                Container(
                  color: AppColors.neutral200Color,
                  padding: EdgeInsets.all(AppGap.w3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('${AppStrings.of(context).currentPrice}: ',
                              style: AppStyles.text5012(
                                  color: AppColors.neutral700Color)),
                          Spacer(),
                          Text(
                            AppConvert.convertAmountVn(price),
                            style: AppStyles.text4016(
                                color: AppColors.yellow800Color),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            AppConvert.convertAmountJp(price),
                            style: AppStyles.text5012(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Center(
                  child: Container(
                    height: AppGap.h16,
                    padding: EdgeInsets.symmetric(horizontal: AppGap.w5),
                    margin: EdgeInsets.only(top: AppGap.h10),
                    decoration: BoxDecoration(
                      color: percent > AppConstants.percent ? AppColors.greenColor : AppColors.primary800Color,
                      borderRadius: BorderRadius.all(Radius.circular(AppGap.r4),),
                    ),
                    child: Text(percent > AppConstants.percent
                        ? "          Người bán uy tín         "
                        : "Cảnh báo: Người bán uy tín thấp",style: AppStyles.text4010(color: AppColors.white),),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
