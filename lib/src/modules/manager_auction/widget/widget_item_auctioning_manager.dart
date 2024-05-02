import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jancargo_app/src/components/resource/molecules/app_button.dart';
import 'package:jancargo_app/src/components/resource/molecules/app_carousel_image.dart';
import 'package:jancargo_app/src/data/object_request_api/auction/price_auction/price_auction_request.dart';
import 'package:jancargo_app/src/domain/dtos/auction_manager/auction_manager_dto.dart';
import 'package:jancargo_app/src/domain/services/dialog/dialog_service.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/details_product_auction/screens/details_product_screen.dart';
import 'package:jancargo_app/src/modules/manager_auction/bloc/auction_manager_cubit.dart';
import 'package:jancargo_app/src/modules/manager_auction/widget/widget_timer_auction.dart';
import 'package:jancargo_app/src/modules/reset_bid/screen/reset_bid_screen.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

class WidgetItemAuctioningManager extends StatefulWidget {
  const WidgetItemAuctioningManager(
      {super.key,
      required this.item,
      required this.cubit,
      this.getCurrentIndex});

  final ItemsAuctionManagerDto item;
  final AuctionManagerCubit cubit;
  final ValueSetter<ItemsAuctionManagerDto>? getCurrentIndex;

  @override
  State<WidgetItemAuctioningManager> createState() =>
      _WidgetItemAuctioningManagerState();
}

class _WidgetItemAuctioningManagerState
    extends State<WidgetItemAuctioningManager> {
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
      margin: EdgeInsets.only(bottom: AppGap.h10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppGap.r8),
          topLeft: Radius.circular(AppGap.r8),
        ),
        color: AppColors.white,
      ),
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
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: AppGap.w10, vertical: AppGap.h5),
      decoration: BoxDecoration(
        color: AppColors.yellow800Color,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppGap.r8),
          topLeft: Radius.circular(AppGap.r8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              WidgetTimerAuction(
                dateString: widget.item.endTime!,
              ),
              AppGap.sbW8,
              SvgPicture.asset(
                AppImages.icBid,
                height: 20,
                width: 20,
              ),
              AppGap.sbW8,
              Text(
                widget.item.bids.toString(),
                style: AppStyles.text6016(color: AppColors.neutral800Color),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              RouteService.routeGoOnePage(
                ProductDetailsScreen(
                  code: widget.item.code!,
                  source: AppConstants.auctionShoppingSource,
                ),
              );
            },
            child: Row(
              children: [
                Text(
                  'Chi tiết',
                  style: AppStyles.text4012(color: AppColors.neutral800Color),
                ),
                SvgPicture.asset(
                  AppImages.icArrowight,
                  height: AppGap.h10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget infoItem() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
          child: const Divider(),
        ),
        Row(
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
                      padding: EdgeInsets.symmetric(horizontal: AppGap.w3),
                      decoration: BoxDecoration(
                        color: (widget.item.winner! ||
                                widget.item.quoteCode != null)
                            ? AppColors.greenColor.withOpacity(0.6)
                            : AppColors.primary800Color.withOpacity(0.3),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppGap.r8),
                          topRight: Radius.circular(AppGap.r8),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        widget.item.status! > 1
                            ? "Đặt giá thành công"
                            : (widget.item.winner! ||
                                    (widget.item.quoteCode != null)
                                ? 'Bạn đặt giá cao nhất'
                                : (widget.item.mode == 'now'
                                    ? "Có người đặt giá cao hơn"
                                    : (widget.item.finished! || timeLeft <= 0
                                        ? 'Hết giờ săn'
                                        : 'Đang săn phút chót'))),
                        style: AppStyles.text4010(color: AppColors.white,height: 0),
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
                  Text(
                    widget.item.name!,
                    style: AppStyles.text4014(color: AppColors.neutral800Color),
                  ),
                  _customRow('Người bán', widget.item.sellerId!),
                  _customRow('Dẫn đầu',  widget.item.status! > 1
                      ? "Đặt giá thành công"
                      : (widget.item.winner! ||
                      (widget.item.quoteCode != null)
                      ? 'Bạn đặt giá cao nhất'
                      : (widget.item.mode == 'now'
                      ? "Có người đặt giá cao hơn"
                      : (widget.item.finished! || timeLeft <= 0
                      ? 'Hết giờ săn'
                      : 'Đang săn phút chót'))),),
                  _customRow('Số lượng', widget.item.qty.toString()),
                  _customRow(
                      'Thời gian đặt',
                      AppConvert.convertStringToTimeandDateTime(
                          widget.item.updatedDate!)),
                ],
              ),
            )
          ],
        ),
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
                _customColumn(
                    'Giá bạn đặt', widget.item.price!, AppColors.greenColor),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _customColumn('Giá hiện tại', widget.item.currentPrice!,
                    AppColors.primary800Color),
                // _customColumn(
                //     'Giá bạn đặt', 123214124, 0, AppColors.neutral800Color),
              ],
            ),
          ],
        ),
      );

  Widget _btn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
            onTap: () {
              widget.cubit.updateDataItem(widget.item.code!);
            },
            child: SvgPicture.asset(
              AppImages.icRefresh,
              color: AppColors.neutral800Color,
            )),
        BlocListener<AuctionManagerCubit, AuctionManagerState>(
          bloc: widget.cubit,
          listener: (context, state) {
            // TODO: implement listener}
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppButton(
                onPressed: () {
                  RouteService.routeGoOnePage(ResetBidScreen(
                    dto: widget.item,
                    request: PriceRequest(
                      items: [
                        PriceAuctionRequest(
                            qty: widget.item.qty!,
                            tax: widget.item.tax,
                            price: widget.item.price)
                      ],
                    ),
                  ));
                },
                text: "Đặt đấu giá",
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
                onPressed: () async {
                  await DialogService.openDialog(
                          const RemoveSessionAuctionDialog())
                      .then((value) {
                    if (value != null && value) {
                      widget.getCurrentIndex?.call(widget.item!);
                    }
                  });
                },
                text: "Xoá đấu giá",
                width: AppGap.w136,
                height: AppGap.h40,
                radius: AppGap.r4,
                color: AppColors.primary800Color,
                textColor: AppColors.white,
                borderColor: AppColors.primary800Color,
                textSize: 14.sp,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _customRow(String title, String content) => Row(
        children: [
          Text(
            '$title: ',
            style: AppStyles.text4012(),
          ),
          Text(
            content,
            style: AppStyles.text5012(color: AppColors.neutral800Color),
          ),
        ],
      );

  Widget _customColumn(String title, int content, Color colorText) => Column(
        children: [
          Text(
            title,
            style: AppStyles.text4012(color: AppColors.neutral400Color),
          ),
          Row(
            children: [
              Text(
                AppConvert.convertAmountVn(content),
                style: AppStyles.text6014(color: colorText),
              ),
              Text(
                AppConvert.convertAmountJp(content ?? 0),
                style: AppStyles.text4012(color: colorText),
              ),
            ],
          ),
        ],
      );
}

class RemoveSessionAuctionDialog extends StatefulWidget {
  const RemoveSessionAuctionDialog({
    super.key,
  });

  @override
  State<RemoveSessionAuctionDialog> createState() =>
      _RemoveSessionAuctionDialogState();
}

class _RemoveSessionAuctionDialogState
    extends State<RemoveSessionAuctionDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      color: AppColors.white,
      padding: EdgeInsets.symmetric(
        horizontal: AppGap.w20,
      ),
      child: Column(
        children: [
          AppGap.sbH20,
          Row(
            children: [
              SvgPicture.asset(AppImages.icX),
              Text(
                'Xoá phiên bản đấu giá này?',
                style: AppStyles.text4014(),
              ),
            ],
          ),
          Text(
            'Sau khi xoá,bạn vẫn có thể thắng phiên đấu này nếu nhà bán huỷ giá thầu của các tài khoản có giá đấu cao hơn. Trong trường hợp này,chúng tôi sẽ tự động lên đơn hàng cho bạn!',
            style: AppStyles.text4012(),
            softWrap: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildBtn('Không', AppColors.neutral800Color,
                  onTap: () => RouteService.pop()),
              AppGap.sbW8,
              _buildBtn('Có', AppColors.primary300Color,
                  onTap: () => RouteService.popBackResult()),
            ],
          )
        ].expand((e) => [e, AppGap.sbH10]).toList(),
      ),
    );
  }

  Widget _buildBtn(String textBtn, Color color,
          {required void Function() onTap}) =>
      InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: AppGap.w5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(AppGap.r4),
            ),
            border: Border.all(color: color),
          ),
          child: Text(
            textBtn,
            style: AppStyles.text4014(color: color),
          ),
        ),
      );
}
