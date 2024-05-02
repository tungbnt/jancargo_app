import 'package:flutter/material.dart';
import 'package:jancargo_app/src/domain/dtos/detail_product/detail/detail_dto.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../app_manager.dart';
import '../../../general/app_strings/app_strings.dart';
import '../../../general/constants/app_colors.dart';
import '../bloc/detail_product_cubit.dart';

class InfoProduct extends StatelessWidget {
  const InfoProduct({super.key, required this.cubit, required this.detailDto});
  final DetailProductCubit cubit ;
  final DetailDto detailDto;


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
          _itemRow(AppStrings.of(context).goodsCondition,AppStrings.of(context).quantity,detailDto.condition!,detailDto.qty!.toString(),context),
          _itemRow(AppStrings.of(context).startTime,AppStrings.of(context).endTime,detailDto.startDate!,detailDto.endDate!,context),
          _itemRow(AppStrings.of(context).moreMatchTime,AppStrings.of(context).finishSoon,detailDto.autoExtension!  ? 'Có' : 'Không',detailDto.earlyClose!  ? 'Có' : 'Không',context),
          _itemRow(AppStrings.of(context).toReturn,AppStrings.of(context).contractorAuthentication,detailDto.returnable!  ? 'Có' : 'Không',detailDto.bidderVerification!  ? 'Có' : 'Không',context),
          _itemRow(AppStrings.of(context).ratingRestrictions,AppStrings.of(context).auctionCode,detailDto.biderRestriction!  ? 'Có' : 'Không',detailDto.code!.toString(),context,hasDivider: false),
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
        Text(title,style: AppStyles.text4010()),
        AppGap.sbW12,
        Text(description,style: AppStyles.text5012()),
      ],
    ),
  );
}
