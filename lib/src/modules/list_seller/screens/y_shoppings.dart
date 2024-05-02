import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_shop/search_shopping_dto.dart';
import 'package:jancargo_app/src/modules/detail_product_y_shopping/screens/detail_product_y_shopping.dart';
import 'package:jancargo_app/src/modules/list_seller/bloc/y_shopping/y_shopping_cubit.dart';

import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../components/resource/molecules/smart_refresher_custom.dart';
import '../../../components/resource/organisms/will_refresh_view.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_constants.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_convert.dart';
import '../../../util/app_gap.dart';

class YShoppings extends StatefulWidget {
  const YShoppings({super.key, required this.dto});

  final SearchShoppingDto dto;

  @override
  State<YShoppings> createState() => _YShoppingsState();
}

class _YShoppingsState extends State<YShoppings> {
  late SearchShoppingDto dto;
  late YShoppingCubit _cubit;

  @override
  void initState() {
    super.initState();
    dto = widget.dto;
    _cubit = YShoppingCubit();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColors.neutral300Color,
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
          'Y!Shopping',
          style: AppStyles.text7018(),
        ),
        centerTitle: true,
      ),
      body: WillRefreshView(
        child: _items(),
      ),
    );
  }

  Widget _items() => BlocListener<YShoppingCubit, YShoppingState>(
        bloc: _cubit,
        listener: (context, state) {
          if(state is YShoppingDataSuccess){
            dto.results!.addAll(state.dto!.results!);
          }
        },
        child: CustomSmartRefresher(
          controller: _cubit.refreshController,
          onLoading: () async {
            _cubit.load();
          },
          onRefresh: () async {
            _cubit.refreshList();
          },
          enablePullDown: true,
          enablePullUp: true,
          child: GridView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                  horizontal: AppGap.h5, vertical: AppGap.h40),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: AppGap.h5,
                  mainAxisSpacing: AppGap.h5,
                  mainAxisExtent: AppGap.h275),
              itemBuilder: (context, index) {
                return _item(dto.results![index]);
              },
              itemCount: dto.results!.length),
        ),
      );

  Widget _item(ItemsShoppingDto itemsDto) => InkWell(
    onTap: ()=>RouteService.routeGoOnePage(YShoppingDetailProduct(code: itemsDto.code!, source: AppConstants.yShoppingSource)),
    child: Ink(
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
                    imageDecoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(AppGap.r8),
                        topLeft: Radius.circular(AppGap.r8),
                      ),
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
                ],
              ),
              Text(
                itemsDto.name!,
                style: AppStyles.text7016(color: AppColors.black03),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(AppConvert.convertAmountVn(itemsDto.price!),
                  style: AppStyles.text7016(color: AppColors.primary700Color)),
              Text(AppConvert.convertAmountJp(itemsDto.price!),
                  style: AppStyles.text4014(color: AppColors.neutral400Color)),
            ],
          ),
        ),
  );
}
