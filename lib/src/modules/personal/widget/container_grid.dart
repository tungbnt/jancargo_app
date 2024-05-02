import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../domain/models/request/model_widget.dart';

class ContainerGrid extends StatelessWidget {
  const ContainerGrid({super.key, required this.model,});
  final ModelWidget model;


  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: model.onTap,
      child: Container(
        height: AppGap.h78,
        decoration: BoxDecoration(
          color: model.color ?? AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(AppGap.r8))
        ),
        child: Row(
          children: [
            Padding(
              padding:  EdgeInsets.only(left: AppGap.w24,right:  AppGap.w10,),
              child: SvgPicture.asset(model.icon),
            ),
            Text(model.text)
          ],
        ),
      ),
    );
  }
}
