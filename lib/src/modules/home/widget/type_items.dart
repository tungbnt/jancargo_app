import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jancargo_app/src/app_manager.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';

import '../../../general/constants/app_colors.dart';
import '../../../util/app_gap.dart';
import '../../searchs/screens/searchs_screens.dart';

class ItemTypeWidget extends StatelessWidget {
  const ItemTypeWidget({super.key, required this.type, required this.icon, required this.category});

  final String type;
  final String icon;
  final String category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()async{
        AppManager.appSession.saveCodeCategory(type.replaceAll("<br />", "").replaceAll("<br/>", ""));
        RouteService.routeGoOnePage( SearchsScreens(category: type.replaceAll("<br />", "").replaceAll("<br/>", ""),categoryId: category,),);
      },
      child: SizedBox(
        width: AppGap.w70,
        child: Column(
          children: [
            Container(
              height: AppGap.h48,
              width: AppGap.w48,
              padding: EdgeInsets.all(AppGap.w8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.neutral50Color,
                border: Border.all(color: AppColors.neutral300Color),
                borderRadius: BorderRadius.all(Radius.circular(AppGap.r8),),
              ),
              child: SvgPicture.network("https://jancargo.com/$icon"),
            ),
            Text(
              type.replaceAll("<br />", "\n").replaceAll("<br/>", "\n"),
              style: AppStyles.text4012(color: AppColors.black03),
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
