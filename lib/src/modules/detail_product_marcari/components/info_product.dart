import 'package:flutter/material.dart';
import 'package:jancargo_app/src/domain/dtos/detail_product/detail_marcari/detail_marcari_dto.dart';
import 'package:jancargo_app/src/domain/dtos/detail_product/rakuten_detail/rakuten_detail_dto.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../general/app_strings/app_strings.dart';
import '../../../general/constants/app_colors.dart';

class InfoProduct extends StatefulWidget {
  const InfoProduct({super.key,  required this.dto});
  final MarcariDetailDto dto;

  @override
  State<InfoProduct> createState() => _InfoProductState();
}

class _InfoProductState extends State<InfoProduct> {
  String condition = '';

  @override
  void initState() {
    super.initState();
    _condition(widget.dto.product!.condition!.name!).then((_) {});
  }

  Future<void> _condition(String name) async {
    switch (name) {
      case "新品、未使用":
        condition = AppStrings.of(context).newUnused;
        break;

      case "目立った傷や汚れなし":
        condition = AppStrings.of(context).almostNew;
        break;

      case "やや傷や汚れあり":
        condition = AppStrings.of(context).scratchesAndDirtNotAttention;
        break;

      case "傷や汚れあり":
        condition = AppStrings.of(context).scratchesAndDirt;
        break;
      case "全体的に状態が悪い":
        condition = AppStrings.of(context).badCondition;
        break;
      default:
        condition;
    }
  }
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
          _itemRow(AppStrings.of(context).goodsCondition,AppStrings.of(context).quantity,condition,AppStrings.of(context).unlimited,context),
          _itemRow('Nhãn hiệu','Kích thước',condition,widget.dto.product!.size?.name ?? "Đang cập nhật",context),
          _itemRow(AppStrings.of(context).domesticTaxes,AppStrings.of(context).domesticShippingFee,AppStrings.of(context).taxIncluded, widget.dto.product!.shippingPayer!.id! == 2 ? AppStrings.of(context).sellerBearsTheFee : AppStrings.of(context).undefined,context),
          // _item(context,String title,String description)
        ],
      ),
    );
  }

  Widget _title()=> Padding(
    padding:  EdgeInsets.symmetric(vertical: AppGap.h10),
    child: Text(
      AppStrings.of(context).productInformation,style: AppStyles.text7018(),
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
