import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jancargo_app/src/domain/dtos/auction/auction_search/auction_search_dto.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/auction_search/auction_search_cubit.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

class CheckboxTitleSearch extends StatelessWidget {
  const CheckboxTitleSearch({super.key, required this.item,});
  final AuctionSearchFilterItemDto item;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        item.checked.value = !item.checked.value;
        context.read<AuctionSearchCubit>().load('', context.read<AuctionSearchCubit>().controller!.value.text,false,item.params);
        context.read<AuctionSearchCubit>().isRemoveFilter.value = true;
      },
      child: Row(
        children: [
          if(item.isChildren ==true)
            AppGap.sbW12,
          ValueListenableBuilder(
            valueListenable: item.checked,
            builder: (context,isChecked,__) {
              return SizedBox(
                width: 24.w,
                height: 24.h,
                child: Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  side: const BorderSide(color: AppColors.neutral300Color, width: 1),
                  activeColor: AppColors.primary700Color,
                  value: isChecked,
                  onChanged: (value) {
                    item.checked.value = !item.checked.value;
                    context.read<AuctionSearchCubit>().load('', context.read<AuctionSearchCubit>().controller!.value.text,false,item.params);
                  },
                ),
              );
            }
          ),
          AppGap.sbW8,
          Text(item.label!,style: AppStyles.text4012(color: AppColors.neutral800Color),),
        ],
      ),
    );
  }
}
