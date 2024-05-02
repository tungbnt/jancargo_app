import 'package:flutter/material.dart';
import 'package:jancargo_app/src/components/resource/molecules/app_button.dart';
import 'package:jancargo_app/src/general/constants/app_enum.dart';

import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../domain/dtos/dashboard/recently_viewed/recently_viewed_dto.dart';
import '../../../domain/dtos/oder_management/oder_management_dto.dart';
import '../../../general/app_strings/app_strings.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_convert.dart';
import '../../../util/app_gap.dart';

class ItemRecently extends StatelessWidget {
  const ItemRecently({super.key, required this.dto});

  final RecentlyViewedDto dto;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
            children: [titleRow(),_infoItem(context), _divider(),_btn()]));
  }

  Widget titleRow(){
    return switch(dto.source){
      'RAK_JP' =>  textPadding('Rakuten'),
      'PFL_JP' =>  textPadding('Paypay Fleamarket'),
      'YSP_JP' =>  textPadding('Y!Shopping'),
      'YAC_JP' =>  textPadding('Y!Yahoo! Auction JP'),
      'AMZ_US' =>  textPadding('Amazon US'),
      'AMZ_JP' =>  textPadding('Amazon JP'),
      'MER_JP' =>  textPadding('Mercari JP'),
      _ => const SizedBox.shrink(),
    };
  }
  Widget textPadding(String nameStore)=> Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(nameStore,style: AppStyles.text5014(),),
  );

  Widget _btn() {
   return Padding(
     padding:  EdgeInsets.symmetric(vertical: AppGap.h5,horizontal: AppGap.w10),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         Text(dto.createdDate!,style: AppStyles.text4010(),),
         AppButton(onPressed: (){}, text: 'Đấu giá',width: AppGap.w106,height: AppGap.h32,),
       ],
     ),
   );
  }

  Widget _textSpan(String title, String description, TextStyle titleStyle,
      TextStyle descriptionStyle) =>
      RichText(
        text: TextSpan(
          children: [
            TextSpan(text: title, style: titleStyle),
            TextSpan(
              text: description,
              style: descriptionStyle,
            ),
          ],
        ),
      );

  Widget _divider() => const Divider();

  Widget _infoItem(BuildContext context) => Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: AppGap.w106,
            height: AppGap.h90,
            margin: EdgeInsets.symmetric(horizontal: AppGap.w10),
            decoration: BoxDecoration(
              color: AppColors.neutral200Color,
              borderRadius: BorderRadius.all(
                Radius.circular(AppGap.r8),
              ),
            ),
            child: AppCarouselImages(
              fit: BoxFit.cover,
              height: AppGap.h90,
              // ignore: invalid_use_of_protected_member
              imagesUrl: dto.images!,
              alignment: Alignment.topCenter,
              borderRadius: BorderRadius.circular(AppGap.r8),
              autoPlay: false,
              showIndicatorBottom: false,
              imageDecoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(AppGap.r8))),
            ),
          ),
        ],
      ),
      SizedBox(
        height: AppGap.h90,
        width: AppGap.w232,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: AppGap.w174,
              child: Text(
                dto.productName!,
                style: AppStyles.text5014(color: AppColors.neutral800Color),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
              ),
            ),
            Row(
              children: [
                Text(
                    '${AppStrings.of(context).nation}: ${dto.currencyUnit == 'JPY' ? 'Nhật Bản' : 'Mỹ'}',
                    style: AppStyles.text4012(
                        color: AppColors.neutral600Color)),
                const Spacer(),
                Text('x1',
                    style: AppStyles.text4012(
                        color: AppColors.neutral600Color)),
                AppGap.sbW8,
              ],
            ),
            AppGap.sbH10,
            Row(
              children: [
                Text(
                  AppConvert.convertAmountVn(dto.price!),
                  style:
                  AppStyles.text4014(color: AppColors.primary800Color),
                ),
                Text(
                  AppConvert.convertAmountJp(dto.price!),
                  style:
                  AppStyles.text4012(color: AppColors.neutral700Color),
                ),
                AppGap.sbW8,
              ],
            ),
            AppGap.sbH10,
          ],
        ),
      ),
    ],
  );
}
