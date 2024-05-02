import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jancargo_app/src/domain/dtos/dashboard/auction/auction_dto.dart';
import 'package:slivers/widgets.dart';

import '../../../../components/bloc/favorite/favorite_cubit.dart';
import '../../../../components/resource/molecules/app_carousel_image.dart';
import '../../../../components/resource/molecules/line_time.dart';
import '../../../../components/resource/molecules/shape_time_widget.dart';
import '../../../../domain/services/navigator/route_service.dart';
import '../../../../general/constants/app_colors.dart';
import '../../../../general/constants/app_constants.dart';
import '../../../../general/constants/app_images.dart';
import '../../../../general/constants/app_styles.dart';
import '../../../../util/app_convert.dart';
import '../../../../util/app_gap.dart';
import '../../../details_product_auction/screens/details_product_screen.dart';
import '../../../home/widget/auction_items.dart';

class SearchIAuctionItems extends StatefulWidget {
  const SearchIAuctionItems({super.key, required this.nameStore, required this.dto});
  final String nameStore;
  final AuctionDto dto;

  @override
  State<SearchIAuctionItems> createState() => _SearchIAuctionItemsState();
}

class _SearchIAuctionItemsState extends State<SearchIAuctionItems> {
  final FavoriteCubit _cubitFavorite = FavoriteCubit();

  @override
  Widget build(BuildContext context) {
    return SliverContainer(
      decoration: const BoxDecoration(color: AppColors.white),
      sliver: SliverGroup(
        slivers: [
          _nameStore(),
          _searchResult(widget.dto),

        ],
      ),
    );
  }

  Widget _nameStore()=>SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: AppGap.h10,horizontal: AppGap.w10),
      child: Row(
        children: [
          Image.asset(AppImages.imgAuction,height: 24.h,width: 24.w,),
          AppGap.sbW8,
          Text(widget.nameStore, style: AppStyles.text6016(),)
        ],
      ),
    ),
  );



  Widget _searchResult(AuctionDto dto)=> SliverPadding(
    padding:  EdgeInsets.symmetric(
        horizontal: AppGap.h5, vertical: AppGap.h10),
    sliver: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: AppGap.h5,
            mainAxisSpacing: AppGap.h5,
            mainAxisExtent: AppGap.h275),
        itemBuilder: (context, index) {
          return _items(dto.results![index]);
        },
        itemCount: dto.results!.length),
  );

  Widget _items(AuctionItemsDto itemsDto)=>  InkWell(
    onTap: () => RouteService.routeGoOnePage(ProductDetailsScreen(
      code: itemsDto.code!,
      source: AppConstants.auctionShoppingSource,
    ),),
    child: Ink(
      width: AppGap.w144,
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
                    borderRadius: BorderRadius.only(topRight: Radius.circular(AppGap.r8),topLeft: Radius.circular(AppGap.r8),),
                    autoPlay: false,),
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
                          Text(itemsDto.bids!, style: AppStyles.text5012(color: AppColors.neutral800Color),),
                          const SizedBox(width: 3),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Text(itemsDto.name!,style: AppStyles.text7016(color: AppColors.black03),maxLines: 2,overflow: TextOverflow.ellipsis,),
              Text(AppConvert.convertAmountVn(itemsDto.price!),style: AppStyles.text7016(color: AppColors.primary700Color)),
              Text(AppConvert.convertAmountJp(itemsDto.price!),style: AppStyles.text4014(color: AppColors.neutral400Color)),

            ],
          ),
          Positioned(
            bottom: 10,
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
