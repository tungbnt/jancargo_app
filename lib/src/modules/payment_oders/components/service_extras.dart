import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jancargo_app/src/domain/dtos/user/service_extras/service_extras_dto.dart';
import 'package:jancargo_app/src/domain/services/dialog/dialog_service.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/payment_oders/bloc/payment_oders_cubit.dart';
import 'package:jancargo_app/src/util/app_convert.dart';

import '../../../components/resource/molecules/app_button.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_images.dart';
import '../../../util/app_gap.dart';
import '../bloc/payment_order_item.dart';

class ServiceExtras extends StatefulWidget {
  const ServiceExtras({
    super.key,
    required this.cubit,
    required this.item,
  });

  final PaymentOdersCubit cubit;
  final PaymentOrderItem item;

  @override
  State<ServiceExtras> createState() => _ServiceExtrasState();
}

class _ServiceExtrasState extends State<ServiceExtras> {
  late ServiceExtrasDto? serviceExtrasDto = widget.cubit.serviceExtrasDto;

  @override
  Widget build(BuildContext context) {
    final Widget child;

    if (serviceExtrasDto == null) {
      child = const SizedBox.shrink();
    } else {
      child = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          await DialogService.openDialog(
            _UpdateToServiceExtrasDialog(
              item: widget.item,
              serviceExtrasDto: serviceExtrasDto!,
            ),
            barrierDismissible: true,
          );
          widget.cubit.isActivePay(20000);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dịch vụ GTGT',
                  style: AppStyles.text5014(color: AppColors.neutral800Color),
                ),
                const Icon(Icons.navigate_next_outlined)
              ],
            ),
          ),
        ),
      );
    }

    return BlocListener(
      bloc: widget.cubit,
      listener: (context, state) {
        if (state is GetServiceExtrasPaymentOdersDataSuccess) {
          setState(() {
            serviceExtrasDto = state.serviceExtrasDto;
          });
        }
      },
      child: child,
    );
  }
}

class _UpdateToServiceExtrasDialog extends StatefulWidget {
  const _UpdateToServiceExtrasDialog({
    super.key,
    required this.item,
    required this.serviceExtrasDto,
  });

  final PaymentOrderItem item;
  final ServiceExtrasDto serviceExtrasDto;

  @override
  State<_UpdateToServiceExtrasDialog> createState() => _UpdateToServiceExtrasDialogState();
}

class _UpdateToServiceExtrasDialogState extends State<_UpdateToServiceExtrasDialog> {
  final ValueNotifier<int> selectedVipIndex = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.serviceExtrasDto.data!.length; i++) {
      bool item = widget.serviceExtrasDto.data![i].selectedService.value;
      if (i == 0) {
        item = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.white,
          height: 400.h,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppGap.sbW12,
                  Text(
                    "Dịch vụ GTGT",
                    style: AppStyles.text7018(),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: SvgPicture.asset(AppImages.icX),
                  )
                ],
              ),
              Flexible(child: vips()),
            ],
          ),
        ),
        // Positioned(
        //   bottom: AppGap.h32 + AppGap.h40,
        //   right: 0,
        //   left: 0,
        //   child: ValueListenableBuilder(
        //     valueListenable: selectedVipIndex,
        //     builder: (context, value, __) {
        //       // num missingAmount = widget.walletAmount.value - widget.serviceExtrasDto!.data![widget.items!.selectedService.value];
        //
        //       return Container(
        //         height: AppGap.h40,
        //         margin: EdgeInsets.symmetric(horizontal: AppGap.w10),
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(AppGap.r8),
        //           color: AppColors.primary500Color,
        //         ),
        //         child: Column(
        //           children: [
        //             RichText(
        //               textAlign: TextAlign.center,
        //               text: TextSpan(
        //                 style: AppStyles.text4012(color: AppColors.white),
        //                 children: [
        //                   TextSpan(
        //                     text: "Số dư không đủ để không đủ để kích hoạt VIP. ",
        //                     style: AppStyles.text4012(color: AppColors.white),
        //                   ),
        //                   const TextSpan(text: "Vui lòng nạp thêm"),
        //                   TextSpan(
        //                     text: " ${AppConvert.convertVn(int.parse(missingAmount.toString()))} Nạp tiền ngay -->",
        //                     style: AppStyles.text4012(color: AppColors.white),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       );
        //     },
        //   ),
        // ),
        Positioned(
          bottom: AppGap.h14,
          right: 0,
          left: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
            child: AppButton(
              enable: true,
              width: double.infinity,
              onPressed: () {

                Navigator.pop(context);
              },
              text: "Áp Dụng",
              radius: AppGap.r8,
            ),
          ),
        ),
      ],
    );
  }

  Widget vips() {
    return ListView.builder(
      itemCount: widget.serviceExtrasDto.data!.length,
      itemBuilder: (context, index) {
        return _itemVip(widget.serviceExtrasDto.data![index], index, context);
      },
    );
  }

  Widget _itemVip(ItemsServiceExtrasDto item, int index, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // if (index > 0) const Divider(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _checkBox(context, index),
              _row(item.name!, item.price!),
            ],
          ),
        ),
        if (index < widget.serviceExtrasDto.data!.length - 1) const Divider(),
      ],
    );
  }

  Widget _row(String title, int price) {
    return SizedBox(
      child: title.contains('Gói')
          ? Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                title,
                style: AppStyles.text4014(color: AppColors.neutral400Color),
              ),
              Text(
                AppConvert.convertVn(price),
                style: AppStyles.text6014(color: AppColors.neutral800Color),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      )
          : Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            title,
            style: AppStyles.text4014(color: AppColors.neutral400Color),
          ),
          Text(
            AppConvert.convertVn(price),
            style: AppStyles.text6014(color: AppColors.neutral800Color),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _checkBox(BuildContext context, int index) {
    final serviceExtras = widget.serviceExtrasDto.data!;
    final serviceExtra = serviceExtras[index];

    return ValueListenableBuilder(
      valueListenable: widget.item.selectedServiceExtras,
      builder: (context, selectedServiceExtras, __) {
        return Align(
          key: Key(index.toString()),
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 24.w,
            height: 24.h,
            child: Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.r),
              ),
              side: const BorderSide(color: AppColors.neutral300Color, width: 2),
              activeColor: AppColors.yellow700Color,
              value: widget.item.isServiceExtraSelected(serviceExtra),
              onChanged: (value) {
                widget.item.toogleServiceExtraSelection(serviceExtra);
                // if (serviceExtra.name!.contains('Gói') == true) {
                // }
              },
            ),
          ),
        );
      },
    );
  }
}
