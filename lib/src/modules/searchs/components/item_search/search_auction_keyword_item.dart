import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/auction_search/auction_search_cubit.dart';
import 'package:slivers/widgets.dart';

import '../../../../components/bloc/favorite/favorite_cubit.dart';
import '../../../../components/resource/molecules/app_carousel_image.dart';
import '../../../../components/resource/molecules/line_time.dart';
import '../../../../components/resource/molecules/shape_time_widget.dart';
import '../../../../domain/dtos/auction/auction_search/auction_search_dto.dart';
import '../../../../domain/services/navigator/route_service.dart';
import '../../../../general/constants/app_colors.dart';
import '../../../../general/constants/app_constants.dart';
import '../../../../general/constants/app_images.dart';
import '../../../../general/constants/app_styles.dart';
import '../../../../util/app_convert.dart';
import '../../../../util/app_gap.dart';
import '../../../details_product_auction/screens/details_product_screen.dart';
import '../../../home/widget/auction_items.dart';

class SearchAuctionKeyWordItems extends StatefulWidget {
  const SearchAuctionKeyWordItems({super.key, required this.nameStore, required this.dto, required this.cubit});
  final String nameStore;
  final AuctionSearchDto dto;
  final AuctionSearchCubit cubit;

  @override
  State<SearchAuctionKeyWordItems> createState() => _SearchAuctionKeyWordItemsState();
}

class _SearchAuctionKeyWordItemsState extends State<SearchAuctionKeyWordItems> {
  final FavoriteCubit _cubitFavorite = FavoriteCubit();

  @override
  Widget build(BuildContext context) {
    return SliverContainer(
      decoration: const BoxDecoration(color: AppColors.white),
      sliver: SliverGroup(
        slivers: [
          _buildNameTab(),
          _searchResult(widget.dto),

        ],
      ),
    );
  }

  Widget _buildNameTab()=>SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: AppGap.h10,horizontal: AppGap.w10),
      child: Row(
        children: [
          ...widget.dto.data!.tabs!.map((e) => _buildItemTabBar((){
             widget.cubit.load('', widget.cubit.controller!.value.text,false,e.params);
          },e)),

        ],
      ),
    ),
  );

  Widget _buildItemTabBar(void Function()? onTap,TabsAuctionSearchDataDto item,)=> GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppGap.w6,vertical: AppGap.h5),
        margin: EdgeInsets.only(right: AppGap.w3,),
        alignment: Alignment.center,
        decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(AppGap.r15),),
        color: item.isActive == true ?  AppColors.yellow800Color : AppColors.neutral300Color,
      ),child: RichText( textAlign: TextAlign.center,
        text: TextSpan(
            style: AppStyles.text5012(color: AppColors.neutral900Color),
            children: [
              TextSpan(text: item.label),
              TextSpan(
                  text: ' (${AppConvert.convertNumber(item.count)})',

                  style: AppStyles.text4010(
                      color: AppColors.neutral800Color)),
            ]),
      ),));

  Widget _searchResult(AuctionSearchDto dto)=> SliverPadding(
    padding:  EdgeInsets.only(
        left: AppGap.w8, right: AppGap.w8,bottom:  AppGap.h14),
    sliver: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: AppGap.h10,
            mainAxisSpacing: AppGap.w10,
            mainAxisExtent: AppGap.h240),
        itemBuilder: (context, index) {
          return _items(dto.data!.results![index]);
        },
        itemCount: dto.data!.results!.length),
  );

  Widget _items(AuctionItemSearchDto itemsDto)=>  InkWell(
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
                    bottom: 0,
                    right: 0,
                    child: ColoredBox(
                      color: AppColors.neutral200Color,
                      child: Row(
                        children: [
                          Expanded(
                            child: ShapeTimeWidget(
                                widget: LineTimer(
                                  dateString: itemsDto.endTime!,
                                )),
                          ),
                          SizedBox(width: AppGap.w15),
                          SvgPicture.asset(AppImages.icHammer, width: 16, height: 16,),
                          SizedBox(width: 6),
                          Text(itemsDto.bids.toString(), style: AppStyles.text5012(color: AppColors.neutral800Color),),
                          SizedBox(width: 3),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Text(itemsDto.name!,style: AppStyles.text7016(color: AppColors.black03),maxLines: 2,overflow: TextOverflow.ellipsis,),
              Text(AppConvert.convertAmountVn(itemsDto.price!),style: AppStyles.text7016(color: AppColors.primary700Color)),
              Text(AppConvert.convertAmountJp(itemsDto.price!),style: AppStyles.text4014(color: AppColors.neutral400Color)),

            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child:   FavoriteIcon(
              favorite: ValueNotifier(false),
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
