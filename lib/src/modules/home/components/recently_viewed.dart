import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jancargo_app/src/domain/dtos/dashboard/recently_viewed/recently_viewed_dto.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_storage.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/detail_product_marcari/screens/detail_product_marcari.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../components/resource/molecules/amount_of_money.dart';
import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../components/resource/molecules/btn_seen_all.dart';
import '../../../components/resource/organisms/will_view.dart';
import '../../../general/app_strings/app_strings.dart';
import '../../detail_product_rakuten/screens/detail_product_rakuten.dart';
import '../../detail_product_y_shopping/screens/detail_product_y_shopping.dart';
import '../../details_product_auction/screens/details_product_screen.dart';
import '../../list_seller/screens/recently_vieweds.dart';
import '../../personal/screens/recently_viewed/recently_viewed_screen.dart';

class RecentlyViewed extends StatefulWidget {
  const RecentlyViewed({super.key, required this.dto});

  final RecentlyDto dto;

  @override
  State<RecentlyViewed> createState() => _RecentlyViewedState();
}

class _RecentlyViewedState extends State<RecentlyViewed> {
  void _onpPageDetail(RecentlyViewedDto item) {
    switch (item.source!) {
      case 'RAK_JP':
        RouteService.routeGoOnePage(RakutenDetailProductScreen(
          code: item.productId!,
          source: item.source!,
        ));
        break;

      case 'YAC_JP':
        RouteService.routeGoOnePage(ProductDetailsScreen(
          code: item.productId!,
          source: item.source!,
        ));
        break;

      case 'MER_JP':
        RouteService.routeGoOnePage(MarcariDetailProduct(
          code: item.productId!,
          source: item.source!,
        ));
        break;
      case 'YSP_JP':
        RouteService.routeGoOnePage(YShoppingDetailProduct(
          code: item.productId!,
          source: item.source!,
        ));
        break;

      default:
        RouteService.routeGoOnePage(ProductDetailsScreen(
          code: item.productId!,
          source: item.source!,
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillView(
      child: Container(
          color: AppColors.white,
          padding: EdgeInsets.symmetric(vertical: AppGap.h10),
          margin: EdgeInsets.only(bottom: AppGap.h10),
          child: Column(
            children: [
              _title(context),
              AppGap.sbH10,
              _items(),
            ],
          )),
    );
  }

  Widget _title(BuildContext context) => Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
            child: Text(
              AppStrings.of(context).recentlyViewed,
              style: AppStyles.text7018(),
            ),
          ),
          const Spacer(),
          SeenAllBtn(
            onTap: () => RouteService.routeGoOnePage(
              const RecentlyViewedScreen(),
            ),
          ),
        ],
      );

  Widget _items() => SizedBox(
        height: AppGap.h235,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
            itemBuilder: (context, index) {
              return _item(widget.dto.result![index]);
            },
            separatorBuilder: (context, i) {
              return AppGap.sbW8;
            },
            itemCount: widget.dto.result!.length),
      );

  Widget _item(RecentlyViewedDto dto) {
    var ic = AppStorage.icStore(dto.source!);
    return GestureDetector(
      onTap: () => _onpPageDetail(dto),
      child: SizedBox(
        width: AppGap.w144,
        child: Column(
          children: [
            Stack(
              children: [
                AppCarouselImages(
                  height: AppGap.h144,
                  // ignore: invalid_use_of_protected_member
                  imagesUrl: [dto.images![0]],
                  alignment: Alignment.topCenter,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(AppGap.r8),
                    topLeft: Radius.circular(AppGap.r8),
                  ),
                  autoPlay: false,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: AppGap.w20, top: AppGap.h16),
                    child: Image.asset(ic,height: 24.h,width: 24.w,),
                  ),
                ),
              ],
            ),
            Text(
              dto.productName!,
              style: AppStyles.text7016(color: AppColors.black03),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            AmountOfMoney(
              amountOfMoney: dto.price!,
              icon: '',
              code: dto.source!,
              isFavorite: ValueNotifier(false),
              currency: dto.currencyUnit!,
              endTime: dto.createdDate!,
              image: dto.images![0],
              name: dto.productName!,
              price: dto.price!,
              siteCode: dto.id!,
              url: dto.productUrl!,
            ),
          ],
        ),
      ),
    );
  }
}
