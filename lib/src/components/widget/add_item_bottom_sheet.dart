import 'package:flutter/material.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import '../../general/app_strings/app_strings.dart';
import '../../general/constants/app_colors.dart';
import '../../general/constants/app_styles.dart';
import '../../util/app_gap.dart';
import '../resource/molecules/app_carousel_image.dart';

class AddItemBottomSheet extends StatelessWidget {
  const AddItemBottomSheet({super.key, required this.price, required this.images, required this.name});
  final int price;
  final String name;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      padding:
      EdgeInsets.symmetric(vertical: AppGap.h10, horizontal: AppGap.w10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: Column(
              children: [
                Container(
                  width: AppGap.w106,
                  height: AppGap.h106,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(AppGap.r8),),),
                  child: AppCarouselImages(
                    fit: BoxFit.fill,
                    height: AppGap.h106,
                    // ignore: invalid_use_of_protected_member
                    imagesUrl: images,
                    alignment: Alignment.topCenter,
                    borderRadius: BorderRadius.zero,
                    autoPlay: false,
                    showIndicatorBottom: false,
                    imageDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(AppGap.r8))),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.only(left: AppGap.w10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    name,
                    style:
                    AppStyles.text4012(color: AppColors.neutral800Color),

                  ),

                  Container(
                    color: AppColors.neutral200Color,
                    padding: EdgeInsets.symmetric(horizontal: AppGap.w3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${AppStrings.of(context).currentPrice}: ',
                                style: AppStyles.text5012(
                                    color: AppColors.neutral700Color)),
                            const Spacer(),
                            Text(
                              AppConvert.convertAmountVn(price),
                              style: AppStyles.text4016(
                                  color: AppColors.yellow800Color),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            Text(
                              AppConvert.convertAmountJp(price),
                              style: AppStyles.text5012(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
