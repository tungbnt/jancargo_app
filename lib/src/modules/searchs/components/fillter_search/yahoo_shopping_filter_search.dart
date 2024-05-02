import 'package:flutter/material.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../../components/resource/molecules/app_button.dart';
import '../../bloc/yahoo_shopping_search/yahoo_shopping_search_cubit.dart';
import '../../widget/filter_by_price.dart';
import '../../widget/filter_default_radio.dart';

class YahooShoppingFilterSearch extends StatefulWidget {
  const YahooShoppingFilterSearch({super.key, required this.filterModel});

  final YahooShoppingFilterModel filterModel;

  @override
  State<YahooShoppingFilterSearch> createState() =>
      _YahooShoppingFilterSearchState();
}

class _YahooShoppingFilterSearchState extends State<YahooShoppingFilterSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
            child: Column(
              children: [
                FilterByPrice(
                  cubit: widget.filterModel.searchCubit,
                  priceFromCtrl: widget.filterModel.searchCubit.priceFromCtrl,
                  priceToCtrl: widget.filterModel.searchCubit.priceToCtrl,
                ),
                const Divider(
                  color: AppColors.neutral200Color,
                  thickness: 1,
                  height: 1,
                ),
                FilterDefaultRadio(
                  title: 'Điều kiện sản phẩm',
                  cubit: widget.filterModel.searchCubit,
                  filterModelForView:
                      widget.filterModel.conditionsFilterController,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: AppGap.h55,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppButton(
                        height: AppGap.h40,
                        width: AppGap.w163,
                        enable: true,
                        onPressed: () {
                          RouteService.pop();
                        },
                        color: AppColors.white,
                        textColor: AppColors.neutral800Color,
                        borderColor: AppColors.neutral200Color,
                        text: 'Đóng'),
                    AppButton(
                        height: AppGap.h40,
                        width: AppGap.w163,
                        enable: true,
                        onPressed: () {
                          RouteService.popBackResult();
                        },
                        text: 'Lọc'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
