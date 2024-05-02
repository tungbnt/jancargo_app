import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../components/resource/molecules/widget_shape_discount.dart';
import '../../../domain/dtos/detail_product/list/relates_dto.dart';
import '../../../domain/dtos/detail_product/suggestion_rakuten/suggestion_rakuten_dto.dart';
import '../../../domain/dtos/search/search_shop/search_shopping_dto.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_constants.dart';
import '../../../general/constants/app_images.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_convert.dart';
import '../../../util/app_gap.dart';
import '../screens/details_product_screen.dart';

class Suggestions extends StatelessWidget {
  const Suggestions({super.key, required this.dto});
  final RelatesDto dto;

  @override
  Widget build(BuildContext context) {
    return  _item(dto);
  }

  Widget _item(RelatesDto dto)=> InkWell(
    onTap: () => RouteService.routeGoOnePage(ProductDetailsScreen(
      code: dto.code!,
      source: AppConstants.auctionShoppingSource,
    ),),
    child: Container(
      width: AppGap.w144,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(AppGap.r8),topLeft: Radius.circular(AppGap.r8),),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AppCarouselImages(
                height: AppGap.h144,
                // ignore: invalid_use_of_protected_member
                imagesUrl: [dto.image!],
                alignment: Alignment.topCenter,
                borderRadius: BorderRadius.only(topRight: Radius.circular(AppGap.r8),topLeft: Radius.circular(AppGap.r8),),
                autoPlay: false,),
              // Align(
              //   alignment: Alignment.topRight,
              //   child: Row(
              //     children: [
              //       const Spacer(),
              //       Padding(
              //         padding:  EdgeInsets.only(right: AppGap.w10),
              //         child: const ShapeDiscountWidget(cent: '25'),
              //       ),
              //     ],
              //   ),
              // ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(AppGap.h10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.yellow800Color,
                  ),
                  child: Image.asset(AppImages.imgAuction,height: 24.h,width: 24.w,),
                ),
              )
            ],
          ),
         Padding(
           padding:  EdgeInsets.all(AppGap.h5),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(dto.name!,style: AppStyles.text7016(color: AppColors.black03),maxLines: 2,overflow: TextOverflow.ellipsis,),
               AppGap.sbH10,
               Text(AppConvert.convertAmountVn(dto.price!),style: AppStyles.text7016(color: AppColors.primary700Color)),
             ],
           ),
         ),
        ],
      ),
    ),
  );
}

class SuggestionsYShopping extends StatelessWidget {
  const SuggestionsYShopping({super.key, required this.dto});
  final ItemsShoppingDto dto;

  @override
  Widget build(BuildContext context) {
    return  _item(dto);
  }

  Widget _item(ItemsShoppingDto dto)=> InkWell(
    onTap: () => RouteService.routeGoOnePage(ProductDetailsScreen(
      code: dto.code!,
      source: AppConstants.auctionShoppingSource,
    ),),
    child: Container(
      width: AppGap.w144,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(AppGap.r8),topLeft: Radius.circular(AppGap.r8),),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AppCarouselImages(
                height: AppGap.h128,
                // ignore: invalid_use_of_protected_member
                imagesUrl: [dto.image!],
                alignment: Alignment.topCenter,
                borderRadius: BorderRadius.only(topRight: Radius.circular(AppGap.r8),topLeft: Radius.circular(AppGap.r8),),
                autoPlay: false,),
              Align(
                alignment: Alignment.topRight,
                child: Row(
                  children: [
                    const Spacer(),
                    Padding(
                      padding:  EdgeInsets.only(right: AppGap.w10),
                      child: const ShapeDiscountWidget(cent: '25'),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(AppGap.h10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.yellow800Color,
                  ),
                  child: Image.asset(AppImages.imgAuction,height: 24.h,width: 24.w,),
                ),
              )
            ],
          ),
          Padding(
            padding:  EdgeInsets.all(AppGap.h3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dto.name!,style: AppStyles.text4012(color: AppColors.black03),maxLines: 2,overflow: TextOverflow.ellipsis,),
                Text(AppConvert.convertAmountVn(dto.price!),style: AppStyles.text7016(color: AppColors.primary700Color)),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

class SuggestionsRakuten extends StatelessWidget {
  const SuggestionsRakuten({super.key, required this.dto});
  final ItemsSuggestionRakutenDto dto;

  @override
  Widget build(BuildContext context) {
    return  _item(dto);
  }

  Widget _item(ItemsSuggestionRakutenDto dto)=> InkWell(
    onTap: () => RouteService.routeGoOnePage(ProductDetailsScreen(
      code: dto.itemCode!,
      source: AppConstants.auctionShoppingSource,
    ),),
    child: Container(
      width: AppGap.w144,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(AppGap.r8),topLeft: Radius.circular(AppGap.r8),),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AppCarouselImages(
                height: AppGap.h128,
                // ignore: invalid_use_of_protected_member
                imagesUrl: [dto.smallImageUrls![0].imageUrl!],
                alignment: Alignment.topCenter,
                borderRadius: BorderRadius.only(topRight: Radius.circular(AppGap.r8),topLeft: Radius.circular(AppGap.r8),),
                autoPlay: false,),
              Align(
                alignment: Alignment.topRight,
                child: Row(
                  children: [
                    const Spacer(),
                    Padding(
                      padding:  EdgeInsets.only(right: AppGap.w10),
                      child: const ShapeDiscountWidget(cent: '25'),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(AppGap.h10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.yellow800Color,
                  ),
                  child: Image.asset(AppImages.imgAuction,height: 24.h,width: 24.w,),
                ),
              )
            ],
          ),
          Padding(
            padding:  EdgeInsets.all(AppGap.h3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dto.itemName!,style: AppStyles.text4012(color: AppColors.black03),maxLines: 2,overflow: TextOverflow.ellipsis,),
                Text(AppConvert.convertAmountVn(int.parse(dto.itemPrice!)),style: AppStyles.text7016(color: AppColors.primary700Color)),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

