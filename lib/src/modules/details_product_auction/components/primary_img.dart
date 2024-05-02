import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jancargo_app/src/components/resource/molecules/line_time.dart';
import 'package:jancargo_app/src/components/resource/molecules/shape_time_widget.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_convert.dart';
import '../../../util/app_gap.dart';
import 'btn_seen_detail.dart';
import 'images_carousel.dart';

class PrimaryImg extends StatefulWidget {
  const PrimaryImg({
    super.key,
    required this.images,
    required this.name,
     this.bid,
    required this.price,
    required this.endTime,
    required this.code,
     this.priceBuy,
    required this.url,
    required this.siteCode, this.imagesThum, required this.urlSite, required this.nameSite, required this.isFavorite, this.buy, this.isBid,  this.isLineTime = false,
  });

  final List<String>? images;
  final List<String>? imagesThum;

  final String name;
  final int price;
  final int? priceBuy;
  final String endTime;
  final String code;
  final String siteCode;
  final String url;
  final String urlSite;
  final String nameSite;
  final bool? buy;
  final bool? isBid;
  final int? bid;
  final bool isLineTime;
  final ValueNotifier<bool> isFavorite;

  @override
  State<PrimaryImg> createState() => _PrimaryImgState();
}

class _PrimaryImgState extends State<PrimaryImg> {
  CarouselController carouselController = CarouselController();
  ValueNotifier<bool> isFavorite = ValueNotifier(false);
  final ValueNotifier<int> indexC = ValueNotifier(0);
  List<String> list = [];

  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  @override
  Widget build(BuildContext context) {

    list = widget.images!.map((e) => e.split("?").first).toList();
    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          ValueListenableBuilder<int>(
              valueListenable: indexC,
              builder: (BuildContext context, int value, Widget? child) {
                return Stack(
                  children: [
                    AppCarouselImages(
                      carouselController: carouselController,
                      height: MediaQuery.of(context).size.height * 0.5,
                      // ignore: invalid_use_of_protected_member
                      imagesUrl: list,
                      alignment: Alignment.topCenter,
                      borderRadius: BorderRadius.zero,
                      autoPlay: false,
                      showIndicatorBottom: true,
                      getCurrentIndex: (index) {
                        indexC.value = index;
                        itemScrollController.scrollTo(index: index, duration: Duration(milliseconds: 300));
                      },
                    ),
                    if(widget.isLineTime)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ColoredBox(
                        color: AppColors.neutral300Color,
                        child: Row(
                          children: [
                            Expanded(
                              child: TimeWidget(
                                height: AppGap.h32,
                                  width: double.infinity,
                                  widget: SizedBox(
                                    height: AppGap.h32,
                                    child: LineAuctionTimer(
                                      dateString: widget.endTime,
                                    ),
                                  )),
                            ),
                            SizedBox(width: AppGap.w24),
                            SvgPicture.asset(AppImages.icHammer, width: 16.w, height: 16.h,),
                            SizedBox(width: 6.w),
                            Text(widget.bid.toString(), style: AppStyles.text5012(color: AppColors.neutral800Color),),
                            SizedBox(width: 3.w),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
          ValueListenableBuilder(
            valueListenable: indexC,
            builder: (BuildContext context, int value, Widget? child) {
              return SizedBox(
                height: AppGap.h90,
                // width: MediaQuery.of(context).size.width,
                child: ScrollablePositionedList.builder(
                  itemCount: widget.imagesThum!.length ?? 0,
                  itemScrollController: itemScrollController,
                  scrollOffsetController: scrollOffsetController,
                  itemPositionsListener: itemPositionsListener,
                  scrollOffsetListener: scrollOffsetListener,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => ImageCarousel(
                    currentIndex: indexC.value,
                    index: index,
                    imgs: widget.imagesThum ?? [],
                    borderColor: AppColors.primary700Color,
                    getCurrentIndex: (i) {
                      indexC.value = index;
                      carouselController.jumpToPage(index);
                    }, carouselController: carouselController,
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  widget.name,
                  style: AppStyles.text6016(color: AppColors.neutral900Color),maxLines: 3,
                ),
                AppGap.sbH5,
                  Text(
                    'Giá hiện tại',
                    style: AppStyles.text4012(color: AppColors.neutral900Color),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppConvert.convertAmountVn(widget.price),
                      style:
                          AppStyles.text7016(color: AppColors.primary700Color),
                    ),
                    AppGap.sbW12,
                    Text(
                      AppConvert.convertAmountJp(widget.price),
                      style:
                          AppStyles.text4014(color: AppColors.neutral400Color),
                    ),
                  ],
                ),
                if(widget.buy == true &&
                    widget.isBid == true)
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     'Giá mua ngay',
                     style: AppStyles.text4012(color: AppColors.neutral900Color),
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Text(
                         AppConvert.convertAmountVn(widget.priceBuy!),
                         style:
                         AppStyles.text7016(color: AppColors.primary700Color),
                       ),
                       AppGap.sbW12,
                       Text(
                         AppConvert.convertAmountJp(widget.priceBuy!),
                         style:
                         AppStyles.text4014(color: AppColors.neutral400Color),
                       ),
                     ],
                   ),
                 ],
               ),
                SeenDetailBtn(
                  name: widget.name,
                  code: widget.code,
                  price: widget.price,
                  endTime: widget.endTime,
                  thumbnails: widget.images!,
                  currency: "JPY",
                  url: widget.url,
                  siteCode: widget.siteCode,
                  urlSite: widget.urlSite,
                  nameSite: widget.nameSite,
                  isFavorite: widget.isFavorite,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
