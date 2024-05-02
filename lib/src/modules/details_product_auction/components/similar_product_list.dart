import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jancargo_app/src/components/resource/organisms/will_view.dart';
import 'package:jancargo_app/src/domain/dtos/detail_product/list/relates_dto.dart';

import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../components/resource/molecules/widget_shape_discount.dart';
import '../../../domain/dtos/detail_product/detail_marcari/detail_marcari_dto.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_constants.dart';
import '../../../general/constants/app_images.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_convert.dart';
import '../../../util/app_gap.dart';
import '../screens/details_product_screen.dart';

class SimilarProduct extends StatelessWidget {
  const SimilarProduct({super.key, required this.dto});
  final List<RelatesDto> dto;

  @override
  Widget build(BuildContext context) {
    return  WillView(
      child: Container(
        color: AppColors.white,
        width: double.infinity,
        padding: EdgeInsets.all(AppGap.w8),
        child: Column(
          children: [
            _title(),
            _items(dto),
          ],
        ),
      ),
    );
  }

  Widget _title()=>  Row(
    children: [
      Text('Sản phẩm tương tự',style: AppStyles.text7018(),),

    ],
  );

  Widget _items(List<RelatesDto> dto)=> SizedBox(
    height: AppGap.h235,
    child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
          return _item(dto[index]);
        }, separatorBuilder: (context,i) {

      return AppGap.sbW8;

    }, itemCount: dto.length),
  );

  Widget _item(RelatesDto dto)=> InkWell(
    onTap: ()=> RouteService.routeGoOnePage(ProductDetailsScreen(
      code: dto.code!,
      source: AppConstants.auctionShoppingSource,
    ),),
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
                imagesUrl: [dto.image!],
                alignment: Alignment.topCenter,
                borderRadius: BorderRadius.only(topRight: Radius.circular(AppGap.r8),topLeft: Radius.circular(AppGap.r8),),
                autoPlay: false,),
              Align(
                alignment: Alignment.topRight,
                child: Row(
                  children: [
                    Spacer(),
                    Padding(
                      padding:  EdgeInsets.only(right: AppGap.w10),
                      child: ShapeDiscountWidget(cent: '25'),
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
                Text(dto.name!,style: AppStyles.text7016(color: AppColors.black03),maxLines: 2,overflow: TextOverflow.ellipsis,),
                Text(AppConvert.convertAmountVn(dto.price!),style: AppStyles.text7016(color: AppColors.primary700Color)),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

class SimilarProductMercari extends StatelessWidget {
  const SimilarProductMercari({super.key, required this.dto});
  final List<RelatesMarcariDetailDto> dto;

  @override
  Widget build(BuildContext context) {
    return  WillView(
      child: Container(
        color: AppColors.white,
        width: double.infinity,
        padding: EdgeInsets.all(AppGap.w8),
        child: Column(
          children: [
            _title(),
            _items(dto),
          ],
        ),
      ),
    );
  }

  Widget _title()=>  Row(
    children: [
      Text('Sản phẩm tương tự',style: AppStyles.text7018(),),

    ],
  );

  Widget _items(List<RelatesMarcariDetailDto> dto)=> SizedBox(
    height: AppGap.h235,
    child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
          return _item(dto[index]);
        }, separatorBuilder: (context,i) {

      return AppGap.sbW8;

    }, itemCount: dto.length),
  );

  Widget _item(RelatesMarcariDetailDto dto)=> InkWell(
    onTap: ()=> RouteService.routeGoOnePage(ProductDetailsScreen(
      code: dto.code!,
      source: AppConstants.auctionShoppingSource,
    ),),
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
                imagesUrl: [dto.image!],
                alignment: Alignment.topCenter,
                borderRadius: BorderRadius.only(topRight: Radius.circular(AppGap.r8),topLeft: Radius.circular(AppGap.r8),),
                autoPlay: false,),
              Align(
                alignment: Alignment.topRight,
                child: Row(
                  children: [
                    Spacer(),
                    Padding(
                      padding:  EdgeInsets.only(right: AppGap.w10),
                      child: ShapeDiscountWidget(cent: '25'),
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
                Text(dto.name!,style: AppStyles.text7016(color: AppColors.black03),maxLines: 2,overflow: TextOverflow.ellipsis,),
                Text(AppConvert.convertAmountVn(dto.price!),style: AppStyles.text7016(color: AppColors.primary700Color)),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
