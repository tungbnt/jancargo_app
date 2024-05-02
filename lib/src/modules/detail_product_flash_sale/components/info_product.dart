import 'package:flutter/material.dart';
import 'package:jancargo_app/src/app_manager.dart';
import 'package:jancargo_app/src/domain/dtos/detail_product/rakuten_detail/rakuten_detail_dto.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../general/constants/app_colors.dart';

class InfoProduct extends StatelessWidget {
  const InfoProduct({super.key,  required this.dto});
  final RakutenDetailItemDto dto;


  @override
  Widget build(BuildContext context) {
    return  Container(
      color: AppColors.white,
      width: double.infinity,
      padding: EdgeInsets.all(AppGap.w10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          _itemRow(AppStrings.of(context).goodsCondition,AppStrings.of(context).quantity,dto.availability == 1 ? AppStrings.of(context).stocking : AppStrings.of(context).outOfStock,AppStrings.of(context).unlimited,context),
          _itemRow(AppStrings.of(context).domesticTaxes,AppStrings.of(context).domesticShippingFee,AppStrings.of(context).undefined,AppStrings.of(context).undefined,context),
        ],
      ),
    );
  }

  Widget _title()=> Padding(
    padding:  EdgeInsets.symmetric(vertical: AppGap.h10),
    child: Text(
      AppStrings.of(AppManager.globalKeyRootMaterial.currentContext!).productInformation,style: AppStyles.text7018(),
    ),
  );

  Widget _itemRow(String title1,String title2,String description1,String description2,BuildContext context,{bool hasDivider = true}) {
    return Column(
    children: [
      Row(
        children: [
          _item( context, title1, description1),
          _item( context, title2, description2),
        ],
      ),
      hasDivider ? const Divider() :AppGap.sbH10,
    ],
  );
  }

  Widget _item(BuildContext context,String title,String description)=> SizedBox(
    width: (MediaQuery.of(context).size.width/2) - AppGap.w20,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: AppStyles.text4014()),
        AppGap.sbW12,
        Text(description,style: AppStyles.text7016()),
      ],
    ),
  );
}
