import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jancargo_app/src/domain/dtos/dashboard/top_shop/top_shop_dto.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/modules/seller/screen/seller_mercari_screen.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:shimmer/shimmer.dart';

import '../../../components/resource/molecules/cached_network_shaped_image.dart';
import '../../../components/resource/organisms/will_view.dart';
import '../../../general/constants/app_images.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_gap.dart';
import '../../seller/screen/saller_auction_screen.dart';
import '../bloc/home_cubit.dart';

class OutstandingSeller extends StatelessWidget {
  const OutstandingSeller({super.key, required this.topShopDto, required this.cubit});

  final TopShopDto topShopDto;
  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    final useMaterial3 = Theme.of(context).useMaterial3;
    return WillView(
      child: Theme(
        data: ThemeData(useMaterial3: true),
        child: Column(
          children: [
            Container(
              height: 300,
              color: AppColors.white,
              padding: EdgeInsets.all(AppGap.h10),
              margin: EdgeInsets.only(bottom: AppGap.h10),
              child: DefaultTabController(
                length: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.of(context).outstandingSeller,
                      style: AppStyles.text7018(),
                    ),
                    TabBar(
                      automaticIndicatorColorAdjustment: false,
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: AppColors.primary700Color,
                      dividerColor:
                          useMaterial3 ? null : AppColors.neutral700Color,
                      indicatorWeight: 2,
                      tabAlignment: TabAlignment.start,
                      unselectedLabelColor: AppColors.neutral600Color,
                      labelColor: AppColors.primary700Color,
                      labelStyle: AppStyles.text7016(),
                      onTap: (index) {
                        // controller.changeTabBar(index);
                      },
                      tabs: const [
                        Text('Tất cả'),
                        Text('Y!Auction'),
                        Text('Mercari'),
                        Text('Mercari Shop'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _itemBarView(topShopDto),
                          ItemBarStore(cubit: cubit,site: "auction",key: const Key("auction"),),
                          ItemBarStore(cubit: cubit,site: "mercari",key: const Key("mercari"),),
                          ItemBarStore(cubit: cubit,site: "mercari-shop",key: const Key("mercari-shop"),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemBarView(TopShopDto topShopDto) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppGap.h20, top: AppGap.h10),
      child: GridView.builder(
        primary: false,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => _item(topShopDto.results![index]),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            mainAxisExtent: AppGap.w255,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: topShopDto.results!.length,
      ),
    );
  }

  Widget _item(ShopDto dto) => InkWell(
    onTap: () => RouteService.routeGoOnePage(SallerAuctionScreen(
      sellerId: dto.code!,
      sellerName: dto.name!,
    )),
    child: Container(
      alignment: Alignment.center,
      height: AppGap.h50,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neutral300Color),
        borderRadius: BorderRadius.all(Radius.circular(AppGap.r15)),
      ),
      child: Row(
        children: [
          _sizedBox(
              AppGap.w50,
              [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppGap.w3),
                  child: ClipRRect(
                    borderRadius:
                    BorderRadius.all(Radius.circular(AppGap.r100)),
                    child: CachedNetworkRectangleImage(
                      imageDecoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(AppGap.r100)),
                      ),
                      imageUrl: dto.image ?? "",
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.center,
                      errorWidget: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.neutral200Color),
                            shape: BoxShape.circle),
                        child: SvgPicture.asset(
                          AppImages.logoLogin,
                        ),
                      ),
                    ),
                  ),
                ),
                AppGap.sbW12,
              ],
              CrossAxisAlignment.center),
          _sizedBox(
              AppGap.w144,
              [
                Text(
                  dto.name!,
                  style: AppStyles.text5014(),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(dto.siteCode!,
                    style: AppStyles.text4012(),
                    overflow: TextOverflow.ellipsis),
                Text(dto.code!,
                    style: AppStyles.text4012(),
                    overflow: TextOverflow.ellipsis),
              ],
              CrossAxisAlignment.start),
          const Spacer(),
          _sizedBox(
              AppGap.w50,
              [
                Column(
                  children: [
                    Text(
                      AppConvert.convertNumber(dto.view!),
                      maxLines: 1,
                    ),
                    Text(
                      'Lượt xem',
                      maxLines: 1,
                      style: AppStyles.text4012(
                          color: AppColors.neutral400Color),
                    ),
                  ],
                ),
              ],
              CrossAxisAlignment.center),
        ],
      ),
    ),
  );

  Widget _sizedBox(
      double w, List<Widget> widgets, CrossAxisAlignment alignment) =>
      SizedBox(
        width: w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: alignment,
          children: widgets,
        ),
      );
}

class ItemBarStore extends StatefulWidget {
  const ItemBarStore({super.key, required this.cubit, required this.site});

  final HomeCubit cubit;
  final String site;

  @override
  State<ItemBarStore> createState() => _ItemBarStoreState();
}

class _ItemBarStoreState extends State<ItemBarStore> {
  @override
  void initState() {
    super.initState();
    widget.cubit.fetchTopShop(widget.site);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: widget.cubit,
      buildWhen: (pre, current) => current is TopShopDataSuccess  || current is TopShopDataLoading,
      builder: (context, state) {
        return switch(state){
        TopShopDataLoading()=> const ShimmerStoreProduct(),
        TopShopDataSuccess(topShopDto: final TopShopDto topShopDto)=>_itemBarView(topShopDto),
        _=> const SizedBox.shrink(),

        };
      },
    );
  }

  Widget _itemBarView(TopShopDto topShopDto) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppGap.h20, top: AppGap.h10),
      child: GridView.builder(
        primary: false,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => _item(topShopDto.results![index],),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            mainAxisExtent: AppGap.w255,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: topShopDto.results!.length,
      ),
    );
  }

  Widget _item(ShopDto dto) => InkWell(
        onTap: () {
          print('site có data : ${widget.site}');
          if(widget.site == 'auction'){
            RouteService.routeGoOnePage(SallerAuctionScreen(
              sellerId: dto.code!,
              sellerName: dto.name!,
            ),);
          }else  if(widget.site == 'mercari'){
            RouteService.routeGoOnePage(SellerMercariScreen(
              sellerId: dto.code!,
              sellerName: dto.name!,
            ),);
          }else  if(widget.site == 'mercari-shop'){
            RouteService.routeGoOnePage(SellerMercariScreen(
              sellerId: dto.code!,
              sellerName: dto.name!,
            ),);
          }

        },
        child: Container(
          alignment: Alignment.center,
          height: AppGap.h50,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.neutral300Color),
            borderRadius: BorderRadius.all(Radius.circular(AppGap.r15)),
          ),
          child: Row(
            children: [
              _sizedBox(
                  AppGap.w50,
                  [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppGap.w3),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.all(Radius.circular(AppGap.r100)),
                        child: CachedNetworkRectangleImage(
                          imageDecoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(AppGap.r100)),
                          ),
                          imageUrl: dto.image ?? "",
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.center,
                          errorWidget: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.neutral200Color),
                                shape: BoxShape.circle),
                            child: SvgPicture.asset(
                              AppImages.logoLogin,
                            ),
                          ),
                        ),
                      ),
                    ),
                    AppGap.sbW12,
                  ],
                  CrossAxisAlignment.center),
              _sizedBox(
                  AppGap.w144,
                  [
                    Text(
                      dto.name!,
                      style: AppStyles.text5014(),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(dto.siteCode!,
                        style: AppStyles.text4012(),
                        overflow: TextOverflow.ellipsis),
                    Text(dto.code!,
                        style: AppStyles.text4012(),
                        overflow: TextOverflow.ellipsis),
                  ],
                  CrossAxisAlignment.start),
              const Spacer(),
              _sizedBox(
                  AppGap.w50,
                  [
                    Column(
                      children: [
                        Text(
                          AppConvert.convertNumber(dto.view!),
                          maxLines: 1,
                        ),
                        Text(
                          'Lượt xem',
                          maxLines: 1,
                          style: AppStyles.text4012(
                              color: AppColors.neutral100Color),
                        ),
                      ],
                    ),
                  ],
                  CrossAxisAlignment.center),
            ],
          ),
        ),
      );

  Widget _sizedBox(
          double w, List<Widget> widgets, CrossAxisAlignment alignment) =>
      SizedBox(
        width: w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: alignment,
          children: widgets,
        ),
      );
}

class ShimmerStoreProduct extends StatelessWidget {
  const ShimmerStoreProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppGap.h235,
      color: AppColors.white,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: AppGap.h10,left: AppGap.h10,top: AppGap.h10,),
      child:GridView.builder(
        primary: false,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => itemShimmer(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            mainAxisExtent: AppGap.w255,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: 4,
      ),

    );
  }

  Widget itemShimmer()=> Shimmer.fromColors(
    baseColor: AppColors.neutral300Color,
    highlightColor: AppColors.neutral100Color,
    child: SizedBox(
      width: AppGap.w144,

      child: Row(
        children: [
          Container(
            height: AppGap.h50,
            width: AppGap.w50,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius:  BorderRadius.only(topLeft: Radius.circular(AppGap.r8),topRight: Radius.circular(AppGap.r8)),
            ),
          ),
          AppGap.sbW8,
         Column(
           children: [
             Container(height: AppGap.h5,color: AppColors.white,),
             AppGap.sbW8,
             Container(height: AppGap.h5,color: AppColors.white,),
           ],
         ),
        ],
      ),
    ),
  );
}
