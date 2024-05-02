import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:jancargo_app/src/components/resource/molecules/app_button.dart';
import 'package:jancargo_app/src/components/resource/molecules/app_carousel_image.dart';
import 'package:jancargo_app/src/domain/dtos/auction_manager/auction_manager_dto.dart';
import 'package:jancargo_app/src/domain/services/dialog/dialog_service.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/details_product_auction/screens/details_product_screen.dart';
import 'package:jancargo_app/src/modules/manager_auction/widget/widget_item_auctioning_manager.dart';
import 'package:jancargo_app/src/modules/manager_auction/widget/widget_timer_auction.dart';
import 'package:jancargo_app/src/modules/web_view/screen/web_view.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

class WidgetItemAuctionManager extends StatefulWidget {
  const WidgetItemAuctionManager({super.key, required this.item, this.getCurrentIndex});

  final ItemsAuctionManagerDto item;
  final ValueSetter<ItemsAuctionManagerDto>? getCurrentIndex;


  @override
  State<WidgetItemAuctionManager> createState() =>
      _WidgetItemAuctionManagerState();
}

class _WidgetItemAuctionManagerState extends State<WidgetItemAuctionManager> {
  int timeLeft = 0;

  @override
  void initState() {
    super.initState();
    _time();
  }

  void _time() {
//thời gian còn lại lên
    timeLeft = AppConvert.convertStringToSecond(widget.item.endTime!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: AppGap.h10,),
      color: AppColors.white,
      child: Column(
        children: [
          components(),
          infoItem(),
          _infoPrice(context),
          _btn(),
        ].expand((e) => [e, AppGap.sbH5]).toList(),
      ),
    );
  }

  Widget components() {
    return Padding(
      padding:
          EdgeInsets.only(left: AppGap.w10, top: AppGap.h10, right: AppGap.w10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              switch (widget.item.status) {
                3 => Text('Đã thanh toán',style: AppStyles.text4012(),),
                2 => Text('Đấu giá thành công',style: AppStyles.text4012(),),
                _ => widget.item.finished!
                    ? Text(
                        'Đã hết thời gian',
                        style: AppStyles.text4012(),
                      )
                    : Row(
                        children: [
                          Text(
                            'Kết thúc trong',
                            style: AppStyles.text4012(),
                          ),
                          WidgetTimerAuction(
                            dateString: widget.item.endTime!,
                          ),
                        ],
                      ),
              }
            ],
          ),
          InkWell(
            onTap: (){
              RouteService.routeGoOnePage(ProductDetailsScreen(
                code: widget.item.code!,
                source: AppConstants.auctionShoppingSource,
              ),);
            },
            child: Row(
              children: [
                Text(
                  'Chi tiết',
                  style: AppStyles.text4012(),
                ),
                SvgPicture.asset(AppImages.icArrowight),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget infoItem() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: AppGap.w106,
          height: AppGap.h90,
          margin: EdgeInsets.symmetric(horizontal: AppGap.w10),
          decoration: BoxDecoration(
            color: AppColors.neutral200Color,
            borderRadius: BorderRadius.all(
              Radius.circular(AppGap.r8),
            ),
          ),
          child: Stack(
            children: [
              AppCarouselImages(
                fit: BoxFit.cover,
                height: AppGap.h90,
                // ignore: invalid_use_of_protected_member
                imagesUrl: widget.item.images!,
                alignment: Alignment.topCenter,
                borderRadius: BorderRadius.circular(AppGap.r8),
                autoPlay: false,
                showIndicatorBottom: false,
                imageDecoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppGap.r8),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(top: 1.h),
                  decoration: BoxDecoration(
                    color: widget.item.winner! || widget.item.quoteCode != null ? AppColors.greenColor.withOpacity(0.3) : AppColors.primary800Color.withOpacity(0.6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppGap.r8),
                      topRight: Radius.circular(AppGap.r8),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    widget.item.status! > 1
                        ? "Đặt giá thành công"
                        : (widget.item.winner! || widget.item.quoteCode != null
                            ? 'Bạn đặt giá cao nhất'
                            : (widget.item.mode == 'now'
                                ? "Có người đặt giá cao hơn"
                                : (widget.item.finished! || timeLeft <= 0
                                    ? 'Hết giờ săn'
                                    : 'Đang săn phút chót'))),
                    style: AppStyles.text4010(color: AppColors.white),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
               Text(widget.item.name!,style: AppStyles.text4014(color: AppColors.neutral800Color),),
              _customRow('Người bán', widget.item.sellerId!),
              _customRow('Dẫn đầu', 'widget.item.'),
              _customRow('Số lượng', widget.item.qty.toString()),
              _customRow('Thời gian đặt',AppConvert.convertStringToTimeandDateTime(widget.item.updatedDate!)),
            ],
          ),
        )
      ],
    );
  }

  Widget _infoPrice(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
          vertical: AppGap.h5,
        ),
        decoration: BoxDecoration(
          color: AppColors.greenColor.withOpacity(0.35),
          border: const Border.symmetric(
            horizontal: BorderSide(
              color: AppColors.neutral300Color,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _customColumn('Giá bạn đặt', widget.item.price!, AppColors.greenColor),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _customColumn(
                    'Giá hiện tại',widget.item.tax != null ? (widget.item.currentPrice! - widget.item.tax!) :  widget.item.currentPrice!, AppColors.primary800Color),
               if(widget.item.tax != null)
                _customColumn(
                    'Giá tính thuế(10%)',widget.item.currentPrice!, AppColors.neutral800Color),
              ],
            ),
          ],
        ),
      );

  Widget _btn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AppButton(
          onPressed: () async{
            Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
            String isToken = hiveBox.get(AppConstants.ACCESS_TOKEN);
            String encodedString = Uri.encodeComponent('/account/quotes/track/${widget.item.code}?view=app');
            var url = "https://m.jancargo.com/redirect?access_token=$isToken&next=$encodedString";
            await RouteService.routeGoOnePage(WebViewScreen(url: url,title: "Tra cứu vận đơn",),);
          },
          text: "Tra cứu đơn",
          width: AppGap.w136,
          height: AppGap.h40,
          radius: AppGap.r4,
          color: AppColors.yellow800Color,
          textColor: AppColors.neutral800Color,
          borderColor: AppColors.yellow800Color,
          textSize: 14.sp,
        ),
        AppGap.sbW8,
        AppButton(
          onPressed: () async{
            await DialogService.openDialog(const RemoveSessionAuctionDialog()).then((value) {
              if(value != null && value){
                widget.getCurrentIndex?.call(widget.item);
              }
            });
          },
          text: "Xoá đấu giá",
          width: AppGap.w136,
          height: AppGap.h40,
          radius: AppGap.r4,
          color: AppColors.neutral300Color,
          textColor: AppColors.neutral800Color,
          borderColor: AppColors.neutral300Color,
          textSize: 14.sp,
        ),
        AppGap.sbW8,
      ],
    );
  }

  Widget _customRow(String title, String content) => Row(
        children: [
          Text('$title: ',style: AppStyles.text4012(),),
          Text(content,style: AppStyles.text5012(color: AppColors.neutral800Color),),
        ],
      );

  Widget _customColumn(String title, int price, Color colorText) => Column(
        children: [
          Text(title,style: AppStyles.text4012(color: AppColors.neutral400Color),),
          Row(
            children: [
              Text(
                AppConvert.convertAmountVn(price) ,
                style: AppStyles.text6014(color: colorText),
              ),
              Text(
                AppConvert.convertAmountJp(price) ,
                style: AppStyles.text5012(color: AppColors.neutral600Color),
              ),
            ],
          ),
        ],
      );
}
