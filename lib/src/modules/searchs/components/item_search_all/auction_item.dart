import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';

import '../../../../components/bloc/favorite/favorite_cubit.dart';
import '../../../../components/resource/molecules/app_carousel_image.dart';
import '../../../../components/resource/molecules/line_time.dart';
import '../../../../components/resource/molecules/shape_time_widget.dart';
import '../../../../domain/dtos/search/search_all/search_all_dto.dart';
import '../../../../domain/services/navigator/route_service.dart';
import '../../../../general/constants/app_colors.dart';
import '../../../../general/constants/app_constants.dart';
import '../../../../general/constants/app_styles.dart';
import '../../../../util/app_convert.dart';
import '../../../../util/app_gap.dart';
import '../../../details_product_auction/screens/details_product_screen.dart';
import '../../../home/widget/auction_items.dart';

class ItemAuction extends StatefulWidget {
  const ItemAuction({super.key, required this.itemsDto,});

  final AllSearchItems itemsDto;

  @override
  State<ItemAuction> createState() => _ItemAuctionState();
}

class _ItemAuctionState extends State<ItemAuction> {
  AllSearchItems get itemsDto => widget.itemsDto;
  ValueNotifier<bool> isFavorite = ValueNotifier(false);
  final FavoriteCubit _cubitFavorite = FavoriteCubit();
  @override
  void initState() {
    super.initState();

    _cubitFavorite.favorites();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => RouteService.routeGoOnePage(ProductDetailsScreen(
        code: itemsDto.code!,
        source: AppConstants.auctionShoppingSource,
      )),
      child: Ink(
        width: AppGap.w144,
        height: AppGap.h144,
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
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ColoredBox(
                        color: AppColors.neutral300Color,
                        child: Row(
                          children: [
                            Expanded(
                              child: ShapeTimeWidget(
                                  widget: LineTimer(
                                    dateString: itemsDto.endTime!,
                                  )),
                            ),
                            SizedBox(width: AppGap.w24),
                            SvgPicture.asset(AppImages.icHammer, width: 16, height: 16,),
                            const SizedBox(width: 6),
                            Text(itemsDto.bids.toString(), style: AppStyles.text5012(color: AppColors.neutral800Color),),
                            const SizedBox(width: 3),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  itemsDto.name!,
                  style: AppStyles.text5012(color: AppColors.black03),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(AppImages.icHammer),
                    AppGap.sbW8,
                    Expanded(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: itemsDto.bids.toString(),
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
                  style: AppStyles.text4016(color: AppColors.primary700Color),
                ),
              ],
            ),
            Positioned(
              bottom: AppGap.h10,
              right: - AppGap.w5,
              child: FavoriteIcon(
                favorite: isFavorite,
                code: itemsDto.code!,
                siteCode: itemsDto.code!,
                name: itemsDto.name!,
                price: itemsDto.price!,
                currency: itemsDto.priceBuy.toString(),
                endTime: itemsDto.endTime!,
                url: itemsDto.url!,
                image:  itemsDto.image!,
                cubit: _cubitFavorite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}