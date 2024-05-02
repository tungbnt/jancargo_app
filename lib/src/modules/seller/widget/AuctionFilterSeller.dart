
import 'package:flutter/material.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../components/resource/molecules/app_button.dart';
import '../../searchs/widget/filter_by_price_now.dart';
import '../../searchs/widget/filter_by_price_present.dart';
import '../../searchs/widget/filter_radio_horizontal.dart';
import '../bloc/auction/seller_auction_cubit.dart';



class AuctionFilterSeller extends StatefulWidget {
  const AuctionFilterSeller({super.key, required this.filterModel});

  final AuctionFilterSellerModel filterModel;

  @override
  State<AuctionFilterSeller> createState() =>
      _AuctionFilterSellerState();
}

class _AuctionFilterSellerState extends State<AuctionFilterSeller> {
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
                AppGap.sbH10,
                FilterByPricePresent(
                  cubit: widget.filterModel.searchCubit,
                  priceFromCtrl: widget.filterModel.searchCubit.priceFromCtrl,
                  priceToCtrl: widget.filterModel.searchCubit.priceToCtrl,
                ),
                FilterByPriceNow(
                  cubit: widget.filterModel.searchCubit,
                  priceFromCtrl: widget.filterModel.searchCubit.priceFromCtrl,
                  priceToCtrl: widget.filterModel.searchCubit.priceToCtrl,
                ),
                FilterRadioHorizontal(
                  title: 'Điều kiện sản phẩm',
                  cubit: widget.filterModel.searchCubit,
                  filterModelForView:
                  widget.filterModel.conditionsFilterController,
                ),
                FilterRadioHorizontal(
                  title: 'Người bán',
                  cubit: widget.filterModel.searchCubit,
                  filterModelForView:
                  widget.filterModel.conditionsStoreFilterController,
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
