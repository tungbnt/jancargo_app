import 'package:flutter/material.dart';

import '../../../../components/resource/molecules/app_carousel_image.dart';
import '../../../../domain/dtos/search/search_all/search_all_dto.dart';
import '../../../../general/constants/app_colors.dart';
import '../../../../general/constants/app_styles.dart';
import '../../../../util/app_convert.dart';
import '../../../../util/app_gap.dart';

class PaypayItems extends StatelessWidget {
  const PaypayItems({super.key, required this.itemsDto});
  final AllSearchItems itemsDto;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        width: AppGap.w144,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AppCarouselImages(
                  height: AppGap.h144,
                  // ignore: invalid_use_of_protected_member
                  imagesUrl: [itemsDto.image!],
                  alignment: Alignment.topCenter,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(AppGap.r8),
                    topLeft: Radius.circular(AppGap.r8),
                  ),
                  imageDecoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(AppGap.r8),
                      topLeft: Radius.circular(AppGap.r8),
                    ),
                  ),
                  autoPlay: false,
                ),
                // Align(
                //   alignment: Alignment.topRight,
                //   child: Row(
                //     children: [
                //       Spacer(),
                //       Padding(
                //         padding:  EdgeInsets.only(right: AppGap.w20),
                //         child: ShapeDiscountWidget(cent: itemsDto.),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
            Text(
              itemsDto.name!,
              style: AppStyles.text7016(color: AppColors.black03),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(AppConvert.convertAmountVn(itemsDto.price!),
                style: AppStyles.text7016(color: AppColors.primary700Color)),
            Text(AppConvert.convertAmountJp(itemsDto.price!),
                style: AppStyles.text4014(color: AppColors.neutral400Color)),
          ],
        ),
      ),
    );
  }
}
