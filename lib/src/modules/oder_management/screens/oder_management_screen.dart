import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/components/resource/organisms/custom_tab_bar.dart';
import 'package:jancargo_app/src/modules/oder_management/bloc/oder_management_cubit.dart';

import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_styles.dart';
import '../components/cancelled.dart';
import '../components/created_tiket.dart';
import '../components/delivering.dart';
import '../components/oder_all.dart';
import '../components/processing.dart';
import '../components/purchase.dart';
import '../components/success_delivery.dart';
import '../components/transport.dart';
import '../components/watting_for_pay.dart';

class OderManagement extends StatefulWidget {
  const OderManagement({super.key, this.isCurrentTab = 0});

  final int? isCurrentTab;

  @override
  State<OderManagement> createState() => _OderManagementState();
}

class _OderManagementState extends State<OderManagement> {
  final OderManagementCubit _cubit = OderManagementCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.yellow800Color,
        centerTitle: true,
        title: const Text('Quản lý đơn hàng'),
        elevation: 0,
      ),
      backgroundColor: AppColors.neutral200Color,
      body: SingleChildScrollView(
        child: Column(
          children: [
            DefaultTabController(
              length: 9,
              initialIndex: widget.isCurrentTab ?? 0,
              child: Column(
                children: [
                  BlocListener<OderManagementCubit, OderManagementState>(
                    bloc: _cubit,
                    listenWhen: (prv,state)=> state is OderManagementWaitForPaySuccess,
                    listener: (context, state) {
                      if(state is OderManagementWaitForPaySuccess){
                        setState(() {
                          _cubit.optionDto = state.managementDto!.options!;
                        });
                      }
                    },
                    child: Container(
                      color: AppColors.white,
                      child: TabBar(
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: AppColors.primary700Color,
                        dividerColor: AppColors.neutral200Color,
                        labelPadding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        indicatorWeight: 2,
                        dividerHeight: 2,
                        tabAlignment: TabAlignment.start,
                        unselectedLabelColor: AppColors.neutral600Color,
                        labelColor: AppColors.primary700Color,
                        labelStyle: AppStyles.text7016(),
                        onTap: (index) {

                        },
                        tabs: [
                          _tabs('Tất cả',_cubit.optionDto.total),
                          _tabs('Chờ thanh toán', _cubit.optionDto.waitForPay),
                          _tabs('Mua hàng', _cubit.optionDto.bought),
                          _tabs('Vận chuyển', _cubit.optionDto.transport),
                          _tabs('Đang xử lý',_cubit.optionDto.processing),
                          _tabs('Đã tạo phiếu', _cubit.optionDto.invoiceCreated),
                          _tabs('Đang giao hàng', _cubit.optionDto.deliveryInProgress),
                          _tabs('Giao hàng thành công', _cubit.optionDto.deliverySuccessful),
                          _tabs('Đơn bị huỷ', _cubit.optionDto.canceled),
                        ],
                      ),
                    ),
                  ),
                  FlexibleTabBarView(
                    physics: NeverScrollableScrollPhysics(),
                      children: [
                    OderAll(
                      cubit: _cubit,
                    ),
                    WattingForPay(
                      cubit: _cubit,
                    ),
                    Purchase(
                      cubit: _cubit,
                    ),
                    Transport(
                      cubit: _cubit,
                    ),
                    Processing(
                      cubit: _cubit,
                    ),
                    CreatedTicket(
                      cubit: _cubit,
                    ),
                    Delivering(
                      cubit: _cubit,
                    ),
                    SuccessDelivery(
                      cubit: _cubit,
                    ),
                    Cancelled(
                      cubit: _cubit,
                    ),
                  ])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabs(String nameTab, int? number) =>
      Row(
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
