import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/helper/widget_iterable_collection_extension.dart';

import '../../../components/models/order_status_model_item.dart';
import '../../../components/resource/molecules/counting_indicator.dart';
import '../../../domain/dtos/oder_management/oder_management_dto.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_images.dart';
import '../../../util/app_gap.dart';
import '../../oder_management/screens/oder_management_screen.dart';
_handleTapButtonOrder() {

}
class OrderStates extends StatelessWidget {
  const OrderStates({super.key,  this.dto});
  final OptionDto? dto;

  @override
  Widget build(BuildContext context) {


    final List<OrderStatusModelActionItem> actionItems = [
      OrderStatusModelActionItem(
        titleLangKey: 'Tất cả',
        icon: AppImages.icWaittingForPay,
          onTap: ()=>RouteService.routeGoOnePage( const OderManagement(isCurrentTab: 0,)),
        count: ValueNotifier(0),

      ),
      OrderStatusModelActionItem(
        titleLangKey: 'Mua hàng',
        icon: AppImages.icPurchase,
        onTap: ()=>RouteService.routeGoOnePage( const OderManagement(isCurrentTab: 2,)),
        count:  ValueNotifier(dto?.purchase ?? 0),
      ),
      OrderStatusModelActionItem(
        titleLangKey: 'Vận chuyển',
        icon: AppImages.icTransport,
        onTap: ()=>RouteService.routeGoOnePage( const OderManagement(isCurrentTab: 3,)),
        count:  ValueNotifier(dto?.transport ?? 0),
      ),
      OrderStatusModelActionItem(
        titleLangKey: 'Tạo phiếu',
        icon: AppImages.icCreatedTicket,
        onTap: ()=>RouteService.routeGoOnePage( const OderManagement(isCurrentTab: 5,)),
        count:  ValueNotifier(dto?.invoiceCreated ?? 0),
      ),
      OrderStatusModelActionItem(
        titleLangKey: 'Giao hàng',
        icon: AppImages.icCreatedTicket,
        onTap: ()=>RouteService.routeGoOnePage( const OderManagement(isCurrentTab: 6,)),
        count:  ValueNotifier(dto?.deliveryInProgress ?? 0),
      ),
    ];

    return Padding(
      padding: EdgeInsets.zero,
      child: Row(
        children: actionItems
            .map<Widget>(
              (e) => Expanded(
            child: InkWell(
              onTap: e.onTap,
              child: Column(
                children: [
                  AppGap.sbH10,
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SvgPicture.asset(e.icon, color: AppColors.neutral800Color),
                      Positioned(
                        top: -6,
                        right: -6,
                        child: ValueListenableBuilder(
                          valueListenable: e.count!,
                          builder: (context,value,_) {
                            return Visibility(
                              visible: e.count!.value > 0,
                              child: CountingIndicator(
                                count: e.count!,
                                dimension: 16,
                              ),
                            );
                          }
                        ),
                      ),
                    ],
                  ),
                  AppGap.sbH10,
                  Text(
                    e.titleLangKey,
                    style: AppStyles.text4010(color: AppColors.neutral800Color),
                  ),
                  AppGap.sbH10,
                ],
              ),
            ),
          ),
        ).separateWith(AppGap.sbW8).toList(),
      ),
    );
  }
}