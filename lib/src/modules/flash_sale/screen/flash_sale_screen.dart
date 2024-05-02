import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/domain/dtos/auction/category_home/category_home_dto.dart';
import 'package:slivers/widgets.dart';

import '../../../domain/dtos/dashboard/flash_sale/flash_sale_dto.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_gap.dart';
import '../../auction/components/item_type_category.dart';
import '../bloc/flash_sale_cubit.dart';
import '../widget/items_amazon_js_flash_sale.dart';
import '../widget/items_rakuten_flash_sale.dart';

class FlashSaleScreen extends StatefulWidget {
  const FlashSaleScreen({
    super.key,
    required this.dto,
  });

  final FlashSaleDto dto;

  @override
  State<FlashSaleScreen> createState() => _FlashSaleScreenState();
}

class _FlashSaleScreenState extends State<FlashSaleScreen> {
  final FlashSaleCubit _cubit = FlashSaleCubit();

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
          'Flash Sale',
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
                _itemsRakuten(),
                _itemsAmazonJs(),
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

  Widget _itemsRakuten() => ItemsRakutenFlashSale(
    dto: widget.dto,
  );

  Widget _itemsAmazonJs() => BlocBuilder<FlashSaleCubit, FlashSaleState>(
    bloc: _cubit,
    buildWhen: (prv, state) => state is FlashSaleAmazonJs,
    builder: (context, state) {
      if (state is FlashSaleAmazonJs) {
        return SliverToBoxAdapter(
          child: ItemsAmazonJsFlashSale(
            dto: state.amazonJsFlashSaleDto!,
          ),
        );
      }
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    },
  );
}
