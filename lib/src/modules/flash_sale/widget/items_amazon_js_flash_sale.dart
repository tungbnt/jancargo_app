import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';

import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../components/resource/molecules/btn_seen_all.dart';
import '../../../components/resource/molecules/flash_sale_timer.dart';
import '../../../domain/dtos/flash_sale/amazon_js/amazon_js_dto.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_gap.dart';
import '../../detail_product_rakuten/screens/detail_product_rakuten.dart';

class ItemsAmazonJsFlashSale extends StatelessWidget {
  const ItemsAmazonJsFlashSale({super.key, required this.dto});

  final AmazonJsFlashSaleDto dto;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
        color: AppColors.white,
        padding: EdgeInsets.all(AppGap.h10),
        margin: EdgeInsets.only(bottom: AppGap.h10),
        child: Column(
          children: [
            _title(),
            AppGap.sbH10,
            _items(),
          ],
        ));
  }

  Widget _title() => Row(
    children: [
      Image.asset(AppImages.imgAmazon,height: 24.h,width: 24.w,),
      Text(
        'Amazon Nhật',
        style: AppStyles.text6016(),
      ),
      AppGap.sbW8,
      const FlashSaleTimer(),
      const Spacer(),
      SeenAllBtn(onTap: () {}),
    ],
  );

  Widget _items() => SizedBox(
    height: AppGap.h235,
    child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _item(dto.products![index]);
        },
        separatorBuilder: (context, i) {
          return AppGap.sbW8;
        },
        itemCount: dto.products!.length),
  );

  Widget _item(ItemsAmazonJsFlashSaleDto itemsDto) => InkWell(
    onTap: (){
      RouteService.routeGoOnePage(RakutenDetailProductScreen(code: itemsDto.code!, source: 'RAK_JP',),);

    },
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
                autoPlay: false,
              ),
              const Align(
                alignment: Alignment.topRight,
                child: Row(
                  children: [
                    Spacer(),

                  ],
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding:  EdgeInsets.only(left: AppGap.w20,top: AppGap.h16),
                  child: Image.asset(AppImages.imgRakuten,height: 24.h,width: 24.w,),
                ),
              ),
            ],
          ),
          Text(
            itemsDto.title!,
            style: AppStyles.text7016(color: AppColors.black03),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}
