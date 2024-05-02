import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/modules/home/widget/type_items.dart';

import '../../../components/resource/organisms/will_view.dart';
import '../../../domain/dtos/dashboard/quick/quick_dto.dart';
import '../../../util/app_gap.dart';

class ItemType extends StatelessWidget {
  const ItemType({super.key, required this.quickDto});

  final QuickDto quickDto;

  @override
  Widget build(BuildContext context) {
    return WillView(
      child: Container(
        height: AppGap.h194,
        padding: EdgeInsets.only(top: AppGap.h10),
        alignment: Alignment.center,
        color: AppColors.white,
        child: GridView.builder(
          primary: false,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => ItemTypeWidget(
            type: quickDto.results![index].name!,
            icon: quickDto.results![index].icon!,
            category: quickDto.results![index].url!.split("/").last,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            mainAxisExtent: AppGap.w70,
            crossAxisSpacing: AppGap.h5,
            mainAxisSpacing: AppGap.h5,
          ),
          itemCount: quickDto.results!.length,
        ),
      ),
    );
  }
}
