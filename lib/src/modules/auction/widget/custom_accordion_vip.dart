import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jancargo_app/src/domain/services/dialog/dialog_service.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/general/constants/app_storage.dart';
import 'package:jancargo_app/src/util/app_convert.dart';

import '../../../components/resource/molecules/accordion.dart';
import '../../../components/resource/molecules/app_button.dart';
import '../../../domain/dtos/user/session/session_dto.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_gap.dart';
import '../bloc/auction_cubit.dart';

Widget _column(String title, String dec) {
  return SizedBox(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: AppStyles.text4014(color: AppColors.neutral400Color),
        ),
        Text(
          dec,
          style: AppStyles.text6014(color: AppColors.neutral800Color),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

Widget _columnContent(String title, String dec) {
  return SizedBox(
    width: AppGap.w136,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: AppStyles.text4014(color: AppColors.neutral400Color),
        ),
        SizedBox(
          width: AppGap.w136,
          child: Text(
            dec,
            style: AppStyles.text4014(color: AppColors.neutral800Color),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

class CustomAccordionVip extends StatelessWidget {
  const CustomAccordionVip({super.key, required this.dto, required this.wallet, required this.cubit});
  final SessionUserDto dto;
  final ValueNotifier<int> wallet;
  final AuctionListCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Accordion(
      title: AppStrings.of(context).memberVip,
      iconTitle: dto.vip! ? SvgPicture.asset(AppImages.icAdd) : null,
      headerBackgroundColor: AppColors.white,
      titleStyle: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      toggleIconOpen: Icons.keyboard_arrow_down_outlined,
      toggleIconClose: Icons.keyboard_arrow_up_sharp,
      headerIconColor: Colors.black,
      accordionElevation: 0,
      showContent: dto.vip! ? false : true,
      widgetItems: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dto.vip!
              ? _itemVipUser(
            context,
            dto.activeVip!.code!,
            'Tối đa ${dto.activeVip!.maxQuote} phiên đấu giá cùng thời điểm',
            dto.activeVip!.price!,
          )
              : Text(
            "*Bạn phải là thành viên VIP mới được đấu giá",
            style: AppStyles.text4012(color: AppColors.primary800Color),
          ),
          AppGap.sbH5,
          ValueListenableBuilder(
            valueListenable: wallet,
            builder: (context, _, __) {
              return AppButton(
                enable: wallet.value >= 0,
                width: double.infinity,
                height: AppGap.h40,
                text: "Nâng cấp VIP",
                radius: AppGap.r8,
                textColor: AppColors.neutral800Color,
                icon: AppImages.icVip,
                borderColor: AppColors.yellow800Color,
                onPressed: () async{
                await DialogService.openDialog(
                    _UpdateToVIPDialog(
                      walletAmount: wallet,
                      cubit: cubit,
                    ),
                    barrierDismissible: true,
                  ).then((selectedVipIndex) {
                    if (selectedVipIndex != null) {
                      final vipItems = AppStorage.itemsVip;

                      // reset lại tất cả để tránh việc có 2 cái đều được chọn
                      for (int i = 0; i < vipItems.length; i++) {
                        final item = vipItems[i];
                        item['isChecked'] = false;
                      }

                      final selectedVipItem = vipItems[selectedVipIndex];
                      selectedVipItem['isChecked'] = true;
                    }
                    return selectedVipIndex;
                  });

                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _itemVipUser(BuildContext context, String title, String content, int price) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _column(AppStrings.of(context).vipPackage, title),
        _columnContent(AppStrings.of(context).content, content),
        _column(
          'Giá',
          AppConvert.convertVn(
            price,
          ),
        ),
      ].expand((e) => [e, AppGap.sbW12]).toList(),
    );
  }
}

class _UpdateToVIPDialog extends StatefulWidget {
  const _UpdateToVIPDialog({super.key, required this.walletAmount, required this.cubit});

  final ValueNotifier<int> walletAmount;
  final AuctionListCubit cubit;

  @override
  State<_UpdateToVIPDialog> createState() => __UpdateToVIPDialogState();
}

class __UpdateToVIPDialogState extends State<_UpdateToVIPDialog> {
  final vipItems = AppStorage.itemsVip;

  final ValueNotifier<int> selectedVipIndex = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < vipItems.length; i++) {
      final item = vipItems[i];
      if (item['isChecked'] == true) {
        selectedVipIndex.value = i;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.white,
          height: AppGap.h308,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppGap.sbW12,
                  Text(
                    AppStrings.of(context).memberVip,
                    style: AppStyles.text7018(),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context, selectedVipIndex.value),
                    icon: SvgPicture.asset(AppImages.icX),
                  )
                ],
              ),
              Flexible(child: vips()),
            ],
          ),
        ),
        Positioned(
          bottom: AppGap.h32 + AppGap.h40,
          right: 0,
          left: 0,
          child: ValueListenableBuilder(
            valueListenable: selectedVipIndex,
            builder: (context, value, __) {
              num missingAmount = widget.walletAmount.value - vipItems[value]['price'];

              return Container(
                height: AppGap.h40,
                margin: EdgeInsets.symmetric(horizontal: AppGap.w10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppGap.r8),
                  color: AppColors.primary500Color,
                ),
                child: Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: AppStyles.text4012(color: AppColors.white),
                        children: [
                          TextSpan(
                            text: "Số dư không đủ để không đủ để kích hoạt VIP. ",
                            style: AppStyles.text4012(color: AppColors.white),
                          ),
                          const TextSpan(text: "Vui lòng nạp thêm"),
                          TextSpan(
                            text: " ${AppConvert.convertVn(int.parse(missingAmount.toString()))} Nạp tiền ngay -->",
                            style: AppStyles.text4012(color: AppColors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
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
                  widget.cubit.activeVip(AppStorage.itemsVip[selectedVipIndex.value]['vip']);
              },
              text: "Nâng cấp VIP",
              radius: AppGap.r8,
              icon: AppImages.icVip,
            ),
          ),
        ),
      ],
    );
  }

  Widget vips() {
    return ListView.builder(
      itemCount: vipItems.length,
      itemBuilder: (context, index) {
        return _itemVip(index, context);
      },
    );
  }

  Widget _itemVip(int index, BuildContext context) {
    final item = vipItems[index];
    final title = item['vip'] as String;
    final content = item['content'] as String;
    final price = item['price'] as int;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (index == 0) Divider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: AppGap.h14, left: AppGap.w10),
              child: _checkBox(context, index),
            ),
            _column(AppStrings.of(context).vipPackage, title),
            _columnContent(AppStrings.of(context).content, content),
            _column('Giá', AppConvert.convertVn(price).replaceAll('VND', 'đ'),),
          ].expand((e) => [e, AppGap.sbW12]).toList(),
        ),
        if (index == 0) const Divider(),
      ],
    );
  }

  Widget _checkBox(BuildContext context, int index) {
    return ValueListenableBuilder(
      valueListenable: selectedVipIndex,
      builder: (context, value, __) {
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
              value: selectedVipIndex.value == index,
              onChanged: (value) {
                selectedVipIndex.value = index;
              },
            ),
          ),
        );
      },
    );
  }
}
