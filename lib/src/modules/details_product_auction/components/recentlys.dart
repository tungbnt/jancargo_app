import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jancargo_app/src/domain/dtos/dashboard/recently_viewed/recently_viewed_dto.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';

import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../components/resource/molecules/btn_seen_all.dart';
import '../../../components/resource/molecules/widget_shape_discount.dart';
import '../../../components/resource/organisms/will_view.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_images.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_convert.dart';
import '../../../util/app_gap.dart';
import '../../list_seller/screens/recently_vieweds.dart';
import '../../personal/screens/recently_viewed/recently_viewed_screen.dart';
import '../screens/details_product_screen.dart';

class Recentlys extends StatelessWidget {
  const Recentlys({super.key, required this.dto});
  final List<RecentlyViewedDto> dto;
  @override
  Widget build(BuildContext context) {
    return  WillView(
      child: Container(
        color: AppColors.white,
        width: double.infinity,
        height: AppGap.h240,
        padding: EdgeInsets.all(AppGap.h10),
        margin: EdgeInsets.only(top:AppGap.h10),
        child: Column(
          children: [
            _title(context),
            _items(),
          ],
        ),
      ),
    );
  }

  Widget _title(BuildContext context)=>  Row(
    children: [
      Padding(
        padding:  EdgeInsets.symmetric(horizontal: AppGap.w10),
        child: Text(AppStrings.of(context).recentlyViewed,style: AppStyles.text7018(),),
      ),
      const Spacer(),
      SeenAllBtn(onTap: ()=>RouteService.routeGoOnePage(const RecentlyViewedScreen(),),),
    ],
  );

  Widget _items()=> SizedBox(
    height: AppGap.h194,
    child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
          return _item(dto[index]);
        }, separatorBuilder: (context,i) {

      return AppGap.sbW8;

    }, itemCount: dto.length),
  );
  Widget _item(RecentlyViewedDto item)=> GestureDetector(
    onTap: ()=> RouteService.routeGoOnePage(ProductDetailsScreen(
      code: item.source!,
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
                height: AppGap.h128,
                // ignore: invalid_use_of_protected_member
                imagesUrl: item.images!,
                alignment: Alignment.topCenter,
                borderRadius: BorderRadius.only(topRight: Radius.circular(AppGap.r8),topLeft: Radius.circular(AppGap.r8),),
                autoPlay: false,),
              // Align(
              //   alignment: Alignment.topRight,
              //   child: Row(
              //     children: [
              //       Spacer(),
              //       Padding(
              //         padding:  EdgeInsets.only(right: AppGap.w10),
              //         child: ShapeDiscountWidget(cent: '25'),
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
            padding:  EdgeInsets.all(AppGap.h3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.productName!,style: AppStyles.text4012(color: AppColors.black03),maxLines: 2,overflow: TextOverflow.ellipsis,),
                Text(AppConvert.convertAmountVn(item.price!),style: AppStyles.text7016(color: AppColors.primary700Color)),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
