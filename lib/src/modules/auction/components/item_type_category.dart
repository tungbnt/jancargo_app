import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';

import '../../../app_manager.dart';
import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../components/resource/molecules/cached_network_shaped_image.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_images.dart';
import '../../../util/app_gap.dart';
import '../../searchs/screens/searchs_screens.dart';

class ItemTypeCategoryWidget extends StatelessWidget {
  const ItemTypeCategoryWidget({super.key, required this.type, required this.icon, required this.categoryId,});

  final String type;
  final String icon;
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppManager.appSession.saveCodeCategory(type.replaceAll("<br />", "").replaceAll("<br/>", ""));
        RouteService.routeGoOnePage( SearchsScreens(category: type,categoryId: categoryId,));
      },
      child: SizedBox(

        child: Column(
          children: [
            Container(
                height: AppGap.h48,
                width: AppGap.w48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.neutral50Color,
                  border: Border.all(color: AppColors.neutral300Color),
                  borderRadius: BorderRadius.all(Radius.circular(AppGap.r8)),
                ),
                child:ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(AppGap.r8)),
                  child: CachedNetworkRectangleImage(
                    imageUrl: "https://jancargo.com/$icon",
                    fit:BoxFit.fill,
                    alignment: Alignment.center,
                    errorWidget: Image.asset(
                      AppImages.capcha,
                    ),
                  ),
                )

            ),
            Text(
              type,
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
