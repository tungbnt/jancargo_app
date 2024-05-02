import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jancargo_app/src/domain/dtos/auction/auction_search/auction_search_dto.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/auction_search/auction_search_cubit.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

class WidgetSelectedTitle extends StatelessWidget {
  const WidgetSelectedTitle({super.key, required this.item, this.callBack});
  final AuctionSearchFilterItemDto item;
  final ValueSetter<AuctionSearchFilterItemDto>? callBack;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: item.isActive,
        builder: (_, value, __) {
          return GestureDetector(
              onTap: () async{
                if (item.isActive.value) return;
                item.isActive.value = !item.isActive.value;
                  callBack?.call(item);
                context
                    .read<AuctionSearchCubit>()
                    .load('', context.read<AuctionSearchCubit>().controller!.value.text,false, item.params,);
                // show xoá bộ lọc
                context.read<AuctionSearchCubit>().isRemoveFilter.value = true;

              },
              child: Row(
                children: [
                  if (item.isChildren == true) AppGap.sbW12,
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.h,
                    ),
                    child: Text(
                      item.label ?? '',
                      style: AppStyles.text4014(color: value ? AppColors.primaryColor : AppColors.neutral800Color),
                    ),
                  ),
                  if (item.count != 0)
                    Text(
                      '(${AppConvert.convertNumber(item.count ?? 0)})',
                      style: AppStyles.text4010(color: value ? AppColors.primaryColor : AppColors.neutral800Color),
                    ),
                ],
              ));
        });
  }
}
