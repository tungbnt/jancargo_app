import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/modules/home/widget/auction_items.dart';

import '../../../components/bloc/favorite/favorite_cubit.dart';
import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../components/resource/molecules/line_time.dart';
import '../../../components/resource/molecules/shape_time_widget.dart';
import '../../../data/object_request_api/favorite/favorite_request.dart';
import '../../../domain/dtos/auction/category_product/category_product_dto.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_images.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_convert.dart';
import '../../../util/app_gap.dart';
import '../../details_product_auction/screens/details_product_screen.dart';

class ItemCategoryProduct extends StatefulWidget {
  const ItemCategoryProduct({super.key, required this.itemsDto});

  final CategoryProductItemDto itemsDto;

  @override
  State<ItemCategoryProduct> createState() => _ItemCategoryProductState();
}

class _ItemCategoryProductState extends State<ItemCategoryProduct> {
  CategoryProductItemDto get itemsDto => widget.itemsDto;
  ValueNotifier<bool> isFavorite = ValueNotifier(false);
  final FavoriteCubit _cubitFavorite = FavoriteCubit();

  void favoriteHandle(CategoryProductItemDto item) {
    isFavorite.value = !isFavorite.value;
    context.read<FavoriteCubit>().favoriteItem(FavoriteRequest(
        code: item.code,
        siteCode: item.code,
        name: item.name,
        price: item.price,
        endTime: item.endTime,
        images: [item.image!]));
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => RouteService.routeGoOnePage(ProductDetailsScreen(
        code: itemsDto.code!,
        source: AppConstants.auctionShoppingSource,
      ),),
      child: Ink(
        width: AppGap.w144,
        height: AppGap.h194,
        child: Stack(
          children: [
            Column(
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
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding:  EdgeInsets.only(left: AppGap.w20,top: AppGap.h10),
                        child: Image.asset(AppImages.imgAuction,height: 24.h,width: 24.w,),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ColoredBox(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Expanded(
                              child: ShapeTimeWidget(
                                  widget: LineTimer(
                                    dateString: itemsDto.endTime!,
                                  )),
                            ),
                            SizedBox(width: AppGap.w24),
                            // SvgPicture.asset(AppImages.icHammer, width: 16, height: 16,),
                            // SizedBox(width: 6),
                            // Text('100', style: AppStyles.text5012(color: AppColors.neutral800Color),),
                            // SizedBox(width: 3),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  itemsDto.name!,
                  style: AppStyles.text5012(color: AppColors.black03),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(AppImages.icHammer,),
                    Expanded(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: " ${itemsDto.bids.toString()}",
                              style: AppStyles.text5012(
                                  color: AppColors.neutral700Color)),
                          TextSpan(
                            text: " lượt đấu giá",
                            style: AppStyles.text4012(
                                color: AppColors.neutral500Color),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
                Text(
                  AppConvert.convertAmountVn(itemsDto.price!),
                  style: AppStyles.text4012(color: AppColors.primary700Color),
                ),
              ],
            ),
            Positioned(
              bottom: 10.h,
              right: 0,
              child:   FavoriteIcon(
                favorite: itemsDto.favorite,
                code: itemsDto.code!,
                siteCode: itemsDto.code!,
                name: itemsDto.name!,
                price: itemsDto.price!,
                currency: itemsDto.priceBuy!.toString(),
                endTime: itemsDto.endTime!,
                url: itemsDto.url!,
                image:  itemsDto.image!,
                cubit: _cubitFavorite,
              ),)
          ],
        ),
      ),
    );
  }
}