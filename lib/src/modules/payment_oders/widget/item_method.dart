import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../domain/dtos/user/warehouse/warehouse_dto.dart';
import '../../../general/constants/app_styles.dart';

class ItemMethod extends StatelessWidget {
  const ItemMethod({super.key, required this.dto, this.onTap, required this.isSelected});
  final ShipModeDto dto;
  final bool isSelected;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppGap.h78,
        padding: EdgeInsets.symmetric(horizontal: AppGap.w10,vertical: AppGap.h16),

        decoration: BoxDecoration(
          border: Border.all(width: 1, color: isSelected ? AppColors.yellow800Color : AppColors.neutral200Color),
          borderRadius: BorderRadius.all(Radius.circular(AppGap.r8)),
          color: isSelected ? AppColors.yellow50Color  : AppColors.white,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                  width: 20,
                  margin: EdgeInsets.symmetric(vertical: AppGap.w3),
                  padding: EdgeInsets.all(AppGap.w3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: isSelected ? AppColors.yellow800Color : AppColors.neutral200Color ),
                  ),
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:  isSelected ? AppColors.yellow800Color  : AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
            AppGap.sbW8,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dto.label!,style: AppStyles.text5014(color: AppColors.neutral900Color),),
                Text('Dự kiến: ${dto.description!}',style: AppStyles.text5012(color: AppColors.neutral500Color),),
              ],
            ),
            AppGap.sbW8,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dto.priceEst != null ? dto.priceEst! : '',style: AppStyles.text5014(color: AppColors.primary800Color),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
