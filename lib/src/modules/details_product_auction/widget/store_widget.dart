import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jancargo_app/src/domain/dtos/detail_product/detail/detail_dto.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';

import '../../../components/resource/molecules/cached_network_shaped_image.dart';
import '../../../general/constants/app_images.dart';
import '../../../util/app_gap.dart';
import '../../seller/screen/saller_auction_screen.dart';

class StoreWidget extends StatelessWidget {
  const StoreWidget(
      {super.key,
      required this.url,
      required this.name,
      required this.totalRate,
      required this.percent, required this.code, this.detailsStore});

  final String url;
  final String name;
  final String code;
  final String totalRate;
  final String percent;
  final DetailSellerDto? detailsStore;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> RouteService.routeGoOnePage(SallerAuctionScreen(
        sellerId: code!,
        sellerName: name,
      ),),
      child: Container(
        color: AppColors.white,
        padding: EdgeInsets.symmetric(vertical: AppGap.h5),
        child: Column(
          children: [
            Stack(
              children: [
                Row(
                  children: [
                    Container(
                      height: AppGap.h68,
                      width: AppGap.w68,
                      margin: EdgeInsets.symmetric(horizontal: AppGap.w10),
                      decoration: const BoxDecoration(
                         shape: BoxShape.circle),
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.all(Radius.circular(AppGap.r100)),
                        child: CachedNetworkRectangleImage(
                          width: 64,
                          height: 64,
                          imageDecoration: const BoxDecoration(
                              shape: BoxShape.circle
                          ),
                          imageUrl: url ?? "",
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          errorWidget: Container(
                            decoration: BoxDecoration(border: Border.all(color: AppColors.neutral200Color), shape: BoxShape.circle),
                            child: SvgPicture.asset(
                              AppImages.icX,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: AppStyles.text5014(color: AppColors.neutral900Color),
                        ),
                        Text('$totalRate đánh giá',
                            style:
                                AppStyles.text4012(color: AppColors.neutral800Color)),
                        rateWidget(percent),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  bottom: AppGap.h20,
                  right: AppGap.w10,
                  child:   Row(
                    children: [Text('Chi tiết',style: AppStyles.text5012(color: AppColors.primary800Color),), const Icon(Icons.navigate_next,color: AppColors.primary800Color)],
                  ),)
              ],
            ),
            rateContainer(),
          ],
        ),
      ),
    );
  }

  Widget rateContainer() => Column(
        children: [
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              evaluate(false, 'Tốt', (detailsStore!.good!.total?.round() ?? 0.0).toString()),
              evaluate(true, 'Bình Thường',  (detailsStore!.normal!.total?.round() ?? 0.0).toString()),
              evaluate(false, 'Không tốt', (detailsStore!.bad!.total?.round() ?? 0.0).toString()),
            ],
          )
        ],
      );

  Widget evaluate(bool isDivider, String statusRate, String number) => Row(
        children: [
          isDivider == true
              ? Container(
            width: 1.0,
            height: 20,
            margin: EdgeInsets.symmetric(
                vertical: AppGap.h5, horizontal: AppGap.w24),
            // Chiều rộng của thanh dọc
            color: AppColors.primary50Color, // Màu sắc của thanh dọc
          )
              : const SizedBox.shrink(),
          Column(
            children: [
              Text(
                statusRate,
                style: AppStyles.text4010(),
              ),
              Text(
                number.isEmpty ? '0.0' : number,
                style: AppStyles.text5012(color: AppColors.neutral800Color),
              ),
            ],
          ),
          isDivider == true
              ? Container(
                  width: 1.0,
                  height: 20,
                  margin: EdgeInsets.symmetric(
                      vertical: AppGap.h5, horizontal: AppGap.w24),
                  // Chiều rộng của thanh dọc
                  color: AppColors.primary50Color, // Màu sắc của thanh dọc
                )
              : const SizedBox.shrink()
        ],
      );

  Widget rateWidget(String percent) => Container(
        padding: EdgeInsets.symmetric(horizontal: AppGap.w8),
        decoration: BoxDecoration(
            color: double.parse(percent.replaceAll("%", "")) < 99.0 ? AppColors.primary800Color : AppColors.greenColor,
            borderRadius: BorderRadius.all(Radius.circular(AppGap.r4),),),
        child: Text(
          '${percent.replaceAll("%", "")}% đánh giá uy tín',
          style: AppStyles.text5012(color: AppColors.neutral50Color),
        ),
      );
}
