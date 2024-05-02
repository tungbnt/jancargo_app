import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jancargo_app/src/domain/dtos/auction/category_home/category_home_dto.dart';
import 'package:slivers/widgets.dart';

import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../domain/dtos/dashboard/flash_sale/flash_sale_dto.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_constants.dart';
import '../../../general/constants/app_images.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_convert.dart';
import '../../../util/app_gap.dart';
import '../../auction/components/item_type_category.dart';
import '../../detail_product_rakuten/screens/detail_product_rakuten.dart';
import '../bloc/flash_sale_cubit.dart';
import '../widget/items_amazon_js_flash_sale.dart';
import '../widget/items_rakuten_flash_sale.dart';

class BigDayScreen extends StatefulWidget {
  const BigDayScreen({
    super.key,
    required this.dto,
  });

  final FlashSaleDto dto;

  @override
  State<BigDayScreen> createState() => _BigDayScreenState();
}

class _BigDayScreenState extends State<BigDayScreen> {
  final FlashSaleCubit _cubit = FlashSaleCubit();

  @override
  void initState() {
    super.initState();
    _cubit.fetchCategory();
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
          'Giá sốc hôm nay',
          style: AppStyles.text7018(),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<FlashSaleCubit, FlashSaleState>(
        bloc: _cubit,
        buildWhen: (prv, state) =>
        state is FlashSaleDataSuccess || state is FlashSaleLoading,
        builder: (context, state) {
          if (state is FlashSaleLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is FlashSaleDataSuccess) {
            return CustomScrollView(
              slivers: [
                _items(),
                _categoryHome(),
                SliverToBoxAdapter(child: AppGap.sbH40),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _categoryHome() => BlocBuilder<FlashSaleCubit, FlashSaleState>(
      bloc: _cubit,
      buildWhen: (prv, state) => state is FlashSaleCategory,
      builder: (context, state) {
        return switch (state) {
          FlashSaleCategory(categoryHomeDto: final CategoryHomeDto dto) =>
              SliverContainer(
                decoration: const BoxDecoration(color: AppColors.white),
                padding: EdgeInsets.symmetric(vertical: AppGap.h10),
                margin: EdgeInsets.symmetric(vertical: AppGap.h10),
                sliver: SliverGroup(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.only(
                          left: AppGap.w10, bottom: AppGap.h10, top: AppGap.h5),
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

  Widget _items() => SliverContainer(
    padding:  EdgeInsets.symmetric(
        horizontal: AppGap.w8,vertical: AppGap.h10),
    margin:  EdgeInsets.symmetric(
        vertical: AppGap.h10),
    decoration: BoxDecoration(color: AppColors.white),
    sliver: SliverGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Row(
            children: [
              Image.asset(AppImages.imgRakuten,height: 24.h,width: 24.w,),
              AppGap.sbW8,
              Text("Rakuten | Săn deal",style: AppStyles.text4014(color: AppColors.neutral400Color),)
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: AppGap.sbH10,
        ),
        SliverGrid.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: AppGap.h5,
              mainAxisSpacing: AppGap.h5,
              mainAxisExtent: AppGap.h275),
          itemCount: widget.dto.data!.length,
          itemBuilder: (context, index) => _item(widget.dto.data![index]),
        ),
      ],
    ),
  );

  Widget _item(ItemSaleDto itemsDto) => InkWell(
    onTap: () => RouteService.routeGoOnePage(RakutenDetailProductScreen(code: itemsDto.code!,source: AppConstants.rakutenSource,)),
    child: Ink(
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
                height: AppGap.h188,
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
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 30,
                  height: 30,
                  margin: EdgeInsets.all(AppGap.h10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,

                  ),
                  child: Image.asset(AppImages.imgRakuten,height: 24.h,width: 24.w,),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(AppGap.w3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemsDto.name!,
                  style: AppStyles.text4014(color: AppColors.black03),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(AppConvert.convertAmountVn(itemsDto.price!),
                    style: AppStyles.text7016(
                        color: AppColors.primary700Color)),
                // Text(AppConvert.convertAmountJp(itemsDto.price!),
                //     style: AppStyles.text4014(
                //         color: AppColors.neutral400Color)),
              ],
            ),
          )
        ],
      ),
    ),
  );

}
