import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jancargo_app/src/components/resource/organisms/custom_tab_bar.dart';
import 'package:jancargo_app/src/domain/services/dialog/dialog_service.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/manager_auction/bloc/auction_manager_cubit.dart';
import 'package:jancargo_app/src/modules/manager_auction/components/all_tab.dart';
import 'package:jancargo_app/src/modules/manager_auction/components/auctioning_tab.dart';
import 'package:jancargo_app/src/modules/manager_auction/components/end_of_session_tab.dart';
import 'package:jancargo_app/src/modules/manager_auction/components/last_hunting_tab.dart';
import 'package:jancargo_app/src/modules/manager_auction/components/paymented_tab.dart';
import 'package:jancargo_app/src/modules/manager_auction/components/success_auction_tab.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

class AuctionManagerScreen extends StatefulWidget {
  const AuctionManagerScreen({super.key});

  @override
  State<AuctionManagerScreen> createState() => _AuctionManagerScreenState();
}

class _AuctionManagerScreenState extends State<AuctionManagerScreen> {
  final AuctionManagerCubit _cubit = AuctionManagerCubit();
  final ValueNotifier<int> initialIndex = ValueNotifier(1);

  void _refreshAll()async{
    switch(initialIndex.value){
      case 0: _cubit.getAll();
      case 1: _cubit.getAuctioningTab();
      case 2: _cubit.getEndOffSession();
      case 3: _cubit.getLastHunting();
      case 4: _cubit.getPaymentedTab();
      case 5: _cubit.getSuccessAuction();
      default: await DialogService.showNotiBannerFailed(context, AppColors.white,
          'Đã có lỗi xảy ra!');
    }
  }

  void _arrangeTab()async{
    switch(initialIndex.value){
      case 0: _cubit.getAll(keyword: _cubit.controller.text,arrange: _cubit.filterModel
          .conditionsArrangeController.groupValue.value?.remoteValue);
      case 1: _cubit.getAuctioningTab(keyword: _cubit.controller.text,arrange: _cubit.filterModel
          .conditionsArrangeController.groupValue.value?.remoteValue);
      case 2: _cubit.getEndOffSession(keyword: _cubit.controller.text,arrange: _cubit.filterModel
          .conditionsArrangeController.groupValue.value?.remoteValue);
      case 3: _cubit.getLastHunting(keyword: _cubit.controller.text,arrange: _cubit.filterModel
          .conditionsArrangeController.groupValue.value?.remoteValue);
      case 4: _cubit.getPaymentedTab(keyword: _cubit.controller.text,arrange: _cubit.filterModel
          .conditionsArrangeController.groupValue.value?.remoteValue);
      case 5: _cubit.getSuccessAuction(keyword: _cubit.controller.text,arrange: _cubit.filterModel
          .conditionsArrangeController.groupValue.value?.remoteValue);
      default: await DialogService.showNotiBannerFailed(context, AppColors.white,
          'Đã có lỗi xảy ra!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral200Color,
      appBar: AppBar(
        backgroundColor: AppColors.yellow800Color,
        leading: null,
        title: Text('Đấu giá',style: AppStyles.text7018(),),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed:  _refreshAll,
                icon: SvgPicture.asset(
                  AppImages.icRefresh,
                ),
              ),
              IconButton(
                onPressed:  _arrangeTab,
                icon: SvgPicture.asset(
                  AppImages.icArrange,
                ),
              ),
              AppGap.sbW8,
            ],
          )
        ],
      ),
      body: DefaultTabController(
        length: 6,
        initialIndex: initialIndex.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocListener<AuctionManagerCubit, AuctionManagerState>(
              bloc: _cubit,
              listenWhen: (prv, state) => state is AuctionManagerSuccess,
              listener: (context, state) {
                setState(() {
                  _cubit.auctionManagerDto = state.auctionManagerDto;
                });
              },
              child: Container(
                color: AppColors.white,
                child: TabBar(
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: AppColors.primary700Color,
                  dividerColor: AppColors.neutral200Color,
                  tabAlignment: TabAlignment.start,
                  labelPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  indicatorWeight: 2,
                  dividerHeight: 2,
                  unselectedLabelColor: AppColors.neutral600Color,
                  labelColor: AppColors.primary700Color,
                  labelStyle: AppStyles.text7016(),
                  onTap: (int index) {
                    // gán dữ liệu
                    initialIndex.value = index;
                    if (index == 0) {
                      _cubit.getAll();
                    } else if (index == 1) {
                      _cubit.getAuctioningTab();
                    } else if (index == 2) {
                      _cubit.getLastHunting();
                    } else if (index == 3) {
                      _cubit.getEndOffSession();
                    } else if (index == 4) {
                      _cubit.getSuccessAuction();
                    } else if (index == 5) {
                      _cubit.getPaymentedTab();
                    }
                  },
                  tabs: [
                    _tabs('Tất cả', _cubit.auctionManagerDto?.statistic?.total),
                    _tabs('Đang đấu giá',
                        _cubit.auctionManagerDto?.statistic?.bidding),
                    _tabs('Săn phút chót',
                        _cubit.auctionManagerDto?.statistic?.hunting),
                    _tabs('kết thúc phiên',
                        _cubit.auctionManagerDto?.statistic?.finished),
                    _tabs('Đấu thành công',
                        _cubit.auctionManagerDto?.statistic?.successed),
                    _tabs('Đã thanh toán',
                        _cubit.auctionManagerDto?.statistic?.paid),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(children: [
                AllTab(
                  cubit: _cubit,
                ),
                AuctioningTab(
                  cubit: _cubit,
                ),
                LastHuntingTab(
                  cubit: _cubit,
                ),
                EndOfSession(
                  cubit: _cubit,
                ),
                SuccessAuctionTab(
                  cubit: _cubit,
                ),
                PaymentedTab(
                  cubit: _cubit,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabs(String nameTab, int? number) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nameTab,
            style: AppStyles.text5014(color: AppColors.neutral800Color),
          ),
          number != null
              ? Text(
                  '($number)',
                  style: AppStyles.text5014(color: AppColors.primary800Color),
                )
              : const SizedBox.shrink(),
        ],
      );
}
