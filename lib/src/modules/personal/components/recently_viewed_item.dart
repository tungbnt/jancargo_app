import 'package:flutter/material.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/modules/detail_product_marcari/screens/detail_product_marcari.dart';
import 'package:jancargo_app/src/modules/detail_product_y_shopping/screens/detail_product_y_shopping.dart';

import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../domain/dtos/dashboard/recently_viewed/recently_viewed_dto.dart';
import '../../../general/app_strings/app_strings.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_storage.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_convert.dart';
import '../../../util/app_gap.dart';
import '../../detail_product_rakuten/screens/detail_product_rakuten.dart';
import '../../details_product_auction/screens/details_product_screen.dart';

class RecentlyViewItem extends StatefulWidget {
  const RecentlyViewItem({super.key, required this.item});
  final RecentlyViewedDto item;
  @override
  State<RecentlyViewItem> createState() => _RecentlyViewItemState();
}

class _RecentlyViewItemState extends State<RecentlyViewItem> {
  ValueNotifier<String> name = ValueNotifier('Đang cập nhật');

  @override
  void initState() {
    super.initState();
    nameStore();
  }

  void nameStore() async {
    name.value = await AppStorage.nameStore(widget.item.source!);
  }

 void _onpPageDetail(){
    switch (widget.item.source!) {
      case 'RAK_JP':
        RouteService.routeGoOnePage(RakutenDetailProductScreen(code: widget.item.productId!, source: widget.item.source!,));
        break;

      case 'YAC_JP':
        RouteService.routeGoOnePage(ProductDetailsScreen(code: widget.item.productId!, source: widget.item.source!,));
        break;

      case 'MER_JP':
        RouteService.routeGoOnePage(MarcariDetailProduct(code: widget.item.productId!, source: widget.item.source!,));
        break;
      case 'YSP_JP':
        RouteService.routeGoOnePage(YShoppingDetailProduct(code: widget.item.productId!, source: widget.item.source!,));
        break;

      default:
        RouteService.routeGoOnePage(ProductDetailsScreen(code: widget.item.productId!, source: widget.item.source!,));
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onpPageDetail,
      child: Container(
        color: AppColors.white,
        child: Column(
          children: [
            _title(),
            _itemProd(),
            _btn(),
          ],
        ),
      ),
    );
  }

  Widget _title() => ValueListenableBuilder(
      valueListenable: name,
      builder: (context, value, Widget? child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
          child: Row(
            children: [
              Text(
                name.value,
                style: AppStyles.text7018(),
              ),
              const Spacer(),
            ],
          ),
        );
      });

  Widget _itemProd() => Padding(
    padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
    child: Column(
      children: [
        Row(
          children: [

            Container(
              width: AppGap.w90,
              height: AppGap.h78,
              margin: EdgeInsets.symmetric(horizontal: AppGap.w10),
              decoration: BoxDecoration(
                color: AppColors.neutral200Color,
                borderRadius: BorderRadius.all(
                  Radius.circular(AppGap.r8),
                ),
              ),
              child: AppCarouselImages(
                fit: BoxFit.cover,
                height: AppGap.h78,
                // ignore: invalid_use_of_protected_member
                imagesUrl: widget.item.images!,
                alignment: Alignment.topCenter,
                borderRadius: BorderRadius.circular(AppGap.r8),
                autoPlay: false,
                showIndicatorBottom: false,
                imageDecoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.circular(AppGap.r8))),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: AppGap.w195,
                  child: Text(
                    widget.item.productName!,
                    style: AppStyles.text5014(
                        color: AppColors.neutral800Color),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
                AppGap.sbH5,
                Text('${AppStrings.of(context).nation}: Nhật Bản',
                    style: AppStyles.text4012(
                        color: AppColors.neutral600Color)),
                AppGap.sbH5,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      AppConvert.convertAmountVn(widget.item.price!),
                      style: AppStyles.text4016(
                          color: AppColors.primary800Color),
                    ),
                    AppGap.sbW8,
                    Text(AppConvert.convertAmountJp(widget.item.price!),
                        style: AppStyles.text4012(
                            color: AppColors.neutral600Color)),
                  ],
                ),
              ],
            )
          ],
        ),
        const Divider(),
      ],
    ),
  );

  Widget _btn() => Padding(
    padding: EdgeInsets.only(
      left: AppGap.w10,
      bottom: AppGap.h16,
      right: AppGap.w10,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppConvert.convertStringDateTime(widget.item.createdDate!),
          style: AppStyles.text4012(),
        ),
        ValueListenableBuilder(
          builder: (context, value, Widget? child) {
            return switch (name.value) {
              'YAC_JP' => _btnCustom((){},'Đấu giá', AppColors.yellow800Color,
                  AppColors.yellow800Color),
              _ => Row(
                children: [
                  _btnCustom(() {


                  },'Thêm giỏ hàng', AppColors.white,
                      AppColors.neutral800Color),
                  AppGap.sbW8,
                  _btnCustom((){},'Mua ngay', AppColors.yellow800Color,
                      AppColors.yellow800Color),
                ],
              ),
            };
          },
          valueListenable: name,
        )
      ],
    ),
  );

  Widget _btnCustom(void Function()? onTap,String name, Color btnColors, Color borderColors) =>
      InkWell(
        onTap: onTap,
        child: Container(
          width: AppGap.w90,
          height: AppGap.h32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: btnColors,
              borderRadius: BorderRadius.circular(AppGap.r4),
              border: Border.all(width: 1, color: borderColors)),
          child: Text(
            name,
            style: AppStyles.text4012(color: AppColors.neutral800Color),
            textAlign: TextAlign.center,
          ),
        ),
      );
}
