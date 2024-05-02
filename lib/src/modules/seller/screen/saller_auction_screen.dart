import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slivers/slivers.dart';

import '../../../components/bloc/favorite/favorite_cubit.dart';
import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../components/resource/molecules/line_time.dart';
import '../../../components/resource/molecules/shape_time_widget.dart';
import '../../../domain/dtos/detail_product/seller_auction/seller_auction_dto.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_constants.dart';
import '../../../general/constants/app_images.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_convert.dart';
import '../../../util/app_gap.dart';
import '../../details_product_auction/screens/details_product_screen.dart';
import '../../home/widget/auction_items.dart';
import '../../searchs/widget/field_search.dart';
import '../../searchs/widget/fillter_search_bottomsheet.dart';
import '../bloc/auction/seller_auction_cubit.dart';
import '../widget/AuctionFilterSeller.dart';
import '../widget/dialog_like_seller.dart';

class SallerAuctionScreen extends StatefulWidget {
  const SallerAuctionScreen(
      {super.key, required this.sellerId, required this.sellerName});

  final String sellerId;
  final String sellerName;

  @override
  State<SallerAuctionScreen> createState() => _SallerAuctionScreenState();
}

class _SallerAuctionScreenState extends State<SallerAuctionScreen> {
  final SellerAuctionCubit _cubit = SellerAuctionCubit();
  final FavoriteCubit _cubitFavorite = FavoriteCubit();
  String? avt = "";
  String? name = "";
  String? url = "";
  String? code = "";
  double percent = 0.0;
  int rate = 0;

  @override
  void initState() {
    super.initState();
    _cubit.fetchSellerAuction(widget.sellerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral200Color,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          widget.sellerName,
          style: AppStyles.text6016(),
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<SellerAuctionCubit, SellerAuctionState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state is SellerDetailProductLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is SellerSuccessProduct) {
            return CustomScrollView(
              slivers: [
                _fieldSearch(
                  (keyword) {
                    if (keyword.isEmpty && keyword == '') {
                    } else {
                      _cubit.getSellerAuction(keyword);
                    }
                  },
                ),
                _infoStore(),
                _itemContainer(),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _fieldSearch(
    ValueSetter<String> onChange,
  ) =>
      SliverToBoxAdapter(
        child: ValueListenableBuilder(
            valueListenable: _cubit.controller!,
            builder: (context, _, __) {
              return FieldSearch(
                onChange: onChange,
                filterSheetBuilder: _filterSheetBuilder,
                controller: _cubit.controller!.value,
                valueFilter: (value) {
                  if (value) {}
                },
              );
            }),
      );

  Widget _filterSheetBuilder(BuildContext context) {
    return FilterSearchBottomSheet(
      widgetCustom: AuctionFilterSeller(
        filterModel: _cubit.filterModel,
      ),
    );
  }

  Widget _infoStore() {
    return SliverToBoxAdapter(
      child: BlocBuilder<SellerAuctionCubit, SellerAuctionState>(
          bloc: _cubit,
          buildWhen: (prv, state) => state is SellerDetailProductSuccess ,
          builder: (context, state) {

            if (state is SellerDetailProductSuccess) {
              if(state.sellerDetailAuctionDto != null){
                  avt = state.sellerDetailAuctionDto!.data!.seller!.avatar ?? "";
                  name = state.sellerDetailAuctionDto!.data!.seller!.name!;
                  url = state.sellerDetailAuctionDto!.data!.seller!.url!;
                  url = state.sellerDetailAuctionDto!.data!.seller!.id!;
                  percent = state.sellerDetailAuctionDto!.data!.seller!.total!.percent!;
                  rate = state.sellerDetailAuctionDto!.data!.seller!.total!.count!;
              }else{
                avt = state.sellerInfoAuctionDto?.avatar ?? "";
                name = state.sellerInfoAuctionDto?.name!;
                url = state.sellerInfoAuctionDto?.url!;
                code = state.sellerInfoAuctionDto?.id!;
                percent = state.sellerInfoAuctionDto!.total!.percent!;
                rate = state.sellerInfoAuctionDto!.total!.count!;
              }
            }

            return _itemStore(avt ?? "",name ?? "",percent,rate,url ?? "");

          }

        ),
    );
  }



  Widget _itemContainer() =>
      BlocBuilder<SellerAuctionCubit, SellerAuctionState>(
        bloc: _cubit,
        buildWhen: (prv, state) => state is SellerDetailProductSuccess,
        builder: (context, state) {
          if (state is SellerDetailProductSuccess) {
            return SliverContainer(
              decoration: const BoxDecoration(color: AppColors.white),
              sliver: SliverGroup(
                slivers: [
                  _nameStore(),
                  _searchResult(state.sellerDetailAuctionDto!.data!),
                ],
              ),
            );
          }
          return const SliverToBoxAdapter(
            child: SizedBox.shrink(),
          );
        },
      );

  Widget _itemStore(String avt,String name,double percent,int rate,String url)=> DialogLikeSeller(avt:avt,name: name,percent: percent,rate: rate,url: url,code: code!,);

  Widget _nameStore() => SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppGap.h10, horizontal: AppGap.w10),
          child: Row(
            children: [
              Image.asset(AppImages.imgAuction,height: 24.h,width: 24.w,),
              AppGap.sbW8,
              Text(
                'Yahoo! Auction',
                style: AppStyles.text6016(),
              )
            ],
          ),
        ),
      );

  Widget _searchResult(SellerAuctionDto dto) => SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: AppGap.h5,
          mainAxisSpacing: AppGap.h5,
          mainAxisExtent: AppGap.h245),
      itemBuilder: (context, index) {
        return _items(dto.results![index]);
      },
      itemCount: dto.results!.length);

  Widget _items(ResultSellerAuctionDto itemsDto) => InkWell(
        onTap: () => RouteService.routeGoOnePage(
          ProductDetailsScreen(
            code: itemsDto.code!,
            source: AppConstants.auctionShoppingSource,
          ),
        ),
        child: Container(
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
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(AppGap.r8),
                          topLeft: Radius.circular(AppGap.r8),
                        ),
                        autoPlay: false,
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        right: 0,
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
                              SizedBox(width: 6),
                              Text(itemsDto.bids!.toString(), style: AppStyles.text5012(color: AppColors.neutral800Color),),
                              SizedBox(width: 3),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: AppGap.w5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          itemsDto.name!,
                          style: AppStyles.text5016(color: AppColors.black03),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(AppConvert.convertAmountVn(itemsDto.price!),
                            style: AppStyles.text7016(
                                color: AppColors.primary700Color)),
                        Text(AppConvert.convertAmountJp(itemsDto.price!),
                            style: AppStyles.text4014(
                                color: AppColors.neutral400Color)),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 10,
                right: 0,
                child: FavoriteIcon(
                  favorite: itemsDto.favorite,
                  code: itemsDto.code!,
                  siteCode: itemsDto.code!,
                  name: itemsDto.name!,
                  price: itemsDto.price!,
                  currency: itemsDto.priceBuy!.toString(),
                  endTime: itemsDto.endTime!,
                  url: itemsDto.url!,
                  image: itemsDto.image!,
                  cubit: _cubitFavorite,
                ),
              )
            ],
          ),
        ),
      );


}
