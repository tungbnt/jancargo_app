import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jancargo_app/src/components/resource/molecules/btn_seen_all.dart';
import 'package:jancargo_app/src/domain/dtos/auction/category_home/category_home_dto.dart';
import 'package:jancargo_app/src/domain/dtos/auction/category_product/category_product_dto.dart';
import 'package:jancargo_app/src/general/constants/app_storage.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:slivers/widgets.dart';

import '../../../app_manager.dart';
import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../components/resource/molecules/line_time.dart';
import '../../../components/resource/molecules/shape_time_widget.dart';
import '../../../domain/dtos/dashboard/auction/auction_dto.dart';
import '../../../domain/dtos/search/search_popular/search_popular_dto.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_constants.dart';
import '../../../general/constants/app_images.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_convert.dart';
import '../../../util/app_gap.dart';
import '../../auction/components/item_category_product.dart';
import '../../auction/components/item_type_category.dart';
import '../../details_product_auction/screens/details_product_screen.dart';
import '../../search/widget/search_popular_widget.dart';
import '../../searchs/screens/searchs_screens.dart';
import '../bloc/auctions/auction_cubit.dart';

class Auctions extends StatefulWidget {
  const Auctions({
    super.key,
  });

  @override
  State<Auctions> createState() => _AuctionsState();
}

class _AuctionsState extends State<Auctions> {
  final AuctionCubit _cubit = AuctionCubit();

  @override
  void initState() {
    super.initState();
    _cubit.prepare();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral200Color,
      extendBody: true,
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: AppColors.white,
        leading: InkWell(
          highlightColor: Colors.transparent,
          onTap: () => RouteService.pop(),
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.black03,
          ),
        ),
        title: Text(
          'Đấu giá',
          style: AppStyles.text7018(),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<AuctionCubit, AuctionState>(
        bloc: _cubit,
        buildWhen: (prv, state) => state is AuctionListDataSuccess || state is AuctionLoading,
        builder: (context, state) {
          if (state is AuctionLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is AuctionListDataSuccess) {
            return CustomScrollView(
              slivers: [
                _searchPopular(),
                _items(),
                _categoryHome(),
                _categoryProduct(),
                SliverToBoxAdapter(child: AppGap.sbH40),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _searchPopular() => BlocBuilder<AuctionCubit, AuctionState>(
      bloc: _cubit,
      buildWhen: (prv, state) => state is AuctionSearchPopularDataSuccess,
      builder: (context, state) {
        return switch (state) {
          AuctionSearchPopularDataSuccess(
            searchPopularDto: final SearchPopularDto dto
          ) =>
            SearchPopularWidget(
              populars: dto.data!,
              getIndexValue: (e) {
                //add key word
                AppManager.appSession.saveCodeCategory(e.name!.replaceAll("<br />", "").replaceAll("<br/>", ""));
                RouteService.routeGoOnePage( SearchsScreens(category: e.name,));
              },
            ),
          _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
        };
      });

  Widget _categoryHome() => BlocBuilder<AuctionCubit, AuctionState>(
      bloc: _cubit,
      buildWhen: (prv, state) => state is AuctionCategoryDataSuccess,
      builder: (context, state) {
        return switch (state) {
          AuctionCategoryDataSuccess(
            categoryHomeDto: final CategoryHomeDto dto
          ) =>
            SliverContainer(
              decoration: const BoxDecoration(color: AppColors.white),
              padding: EdgeInsets.symmetric(vertical: AppGap.h10),
              margin: EdgeInsets.symmetric(vertical: AppGap.h10),

              sliver: SliverGroup(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.only(left: AppGap.w10,bottom: AppGap.h10,top: AppGap.h5),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        'Danh mục sản phẩm',
                        style: AppStyles.text7016(color: AppColors.black03),
                      ),
                    ),
                  ),

                  SliverGrid.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: AppGap.h5,
                          mainAxisSpacing: AppGap.h5,
                          mainAxisExtent: AppGap.h90),
                      itemBuilder: (context, index) {
                        return ItemTypeCategoryWidget(
                          type: dto.data![index].name!,
                          icon: dto.data![index].image!,
                          categoryId: dto.data![index].categoryId!,
                        );
                      },
                      itemCount: 16),
                ],
              ),
            ),
          _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
        };
      });

  Widget _categoryProduct() => BlocBuilder<AuctionCubit, AuctionState>(
        bloc: _cubit,
        buildWhen: (prv, state) => state is AuctionCategoryProductDataSuccess,
        builder: (context, state) {
          return switch (state) {
            AuctionCategoryProductDataSuccess(
              categoryProductDto: final CategoryDto dto
            ) =>
              SliverList.separated(
                  itemBuilder: (context, int i) {
                    return _itemsCategoryProduct(
                      dto.data![i],
                    );
                  },
                  separatorBuilder: (context, int i) {
                    return AppGap.sbW8;
                  },
                  itemCount: dto.data!.length),
            _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
          };
        },
      );

  Widget _itemsCategoryProduct(CategoryProductDto items) =>  Container(
    width: double.infinity,
    height: AppGap.h250,
    // padding: EdgeInsets.all(AppGap.h10),
    margin: EdgeInsets.only(top:AppGap.h10),
    child: Column(

      children: [
        Row(
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: AppGap.w10),
              child: Text(AppStorage.nameCategoryAuction(items.category!),style: AppStyles.text7018(),),
            ),
            const Spacer(),
            SeenAllBtn(onTap: () {
              // RouteService.routeGoOnePage(const RecentlyViewedScreen(),);
            },),
          ],
        ),
        SizedBox(
          height: AppGap.h221,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
              itemBuilder: (context, int i) {
                return ItemCategoryProduct(
                  itemsDto: items.results![i],
                );
              },
              itemCount: items.results!.length),
        ),
      ],
    ),
  );

  Widget _items() => SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: AppGap.w5),
        sliver:
            BlocBuilder<AuctionCubit, AuctionState>(
              bloc: _cubit,
                buildWhen: (prv, state) => state is AuctionProductDataSuccess,
                builder: (context, state) {

          if (state is AuctionProductDataSuccess) {
            return SliverGrid.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: AppGap.w5,
                    mainAxisSpacing: AppGap.h5,
                    mainAxisExtent: AppGap.h255),
                itemBuilder: (context, index) {
                  return _item(state.auctionDto!.results![index]);
                },
                itemCount: state.auctionDto!.results!.length);
          }
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }),
      );

  Widget _item(AuctionItemsDto itemsDto) => InkWell(
        onTap: () => RouteService.routeGoOnePage(ProductDetailsScreen(
          code: itemsDto.code!,
          source: AppConstants.auctionShoppingSource,
        )),
        child: Container(
          width: AppGap.w144,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppGap.r8),
              topLeft: Radius.circular(AppGap.r8),
            ),
          ),
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
                           SizedBox(width: 4.w),
                          SvgPicture.asset(AppImages.icHammer, width: 16, height: 16,),
                           SizedBox(width: 6.w),
                          Text(itemsDto.bids!, style: AppStyles.text5012(color: AppColors.neutral800Color),),
                           SizedBox(width: 3.w),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(AppGap.w8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemsDto.name!,
                      style: AppStyles.text7016(color: AppColors.black03),
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
              )
            ],
          ),
        ),
      );
}
