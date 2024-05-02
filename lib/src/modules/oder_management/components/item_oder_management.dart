import 'package:el_tooltip/el_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:jancargo_app/src/app_manager.dart';
import 'package:jancargo_app/src/components/resource/molecules/app_button.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/general/constants/app_enum.dart';
import 'package:jancargo_app/src/modules/web_view/screen/web_view.dart';

import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../domain/dtos/oder_management/oder_management_dto.dart';
import '../../../general/app_strings/app_strings.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_convert.dart';
import '../../../util/app_gap.dart';

class ItemOderManagement extends StatelessWidget {
  const ItemOderManagement({super.key, required this.dto});

  final DataOderManagementDto dto;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _titleOder(),
      _infoItem(context), _total(context),
      _btn(),
      // _buildToolTip()
    ]
    );
  }

  Widget _buildToolTip()=>ElTooltip(
    child:  Text( AppConvert.convertNumberVn(
        ((dto.totalCurrency! * AppManager.appSession.exchange!).toDouble() + dto.feePayment!.toDouble() + dto.feeService!.toDouble() + dto.feeShip!.toDouble()).toInt() ?? dto.totalCCurrency!),
        style:  AppStyles.text4014(color: AppColors.primary800Color)),
    padding: EdgeInsets.zero,
    showModal: false,
    showChildAboveOverlay: false,
   color: AppColors.neutral100Color,
    content: Container(
      width: 135.w,

      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(left: 8.w,right: 8.w,top: 10.h),
            child: Text('CHI TIẾT TIỀN HÀNG',),
          ),
          _divider(),
          Text('CHI TIẾT TIỀN HÀNG',),
          Text('CHI TIẾT TIỀN HÀNG',),
          Text('CHI TIẾT TIỀN HÀNG',),
        ],
      ),
    ),
    position: ElTooltipPosition.bottomEnd,
  );
  //     Column(
  //   children: [
  //     Text('CHI TIẾT TIỀN HÀNG',),
  //     _divider(),
  //   ],
  // );

  // Widget titleRow()=>

  Widget _total(BuildContext context) => Column(
        children: [
          _divider(),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: AppGap.w8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _textSpan(
                    "${AppStrings.of(context).time}: ",
                    AppConvert.convertStringDateTime(dto.createdDate!),
                    AppStyles.text4012(color: AppColors.neutral500Color),
                    AppStyles.text4012(color: AppColors.neutral500Color)),
                // _buildToolTip(),
                _textSpan(
                    "${AppStrings.of(context).intoMoney}: ",
                    AppConvert.convertNumberVn(
                        ((dto.totalCurrency! * AppManager.appSession.exchange!).toDouble() + dto.feePayment!.toDouble() + dto.feeService!.toDouble() + dto.feeShip!.toDouble()).toInt() ?? dto.totalCCurrency!),
                    AppStyles.text4014(color: AppColors.neutral800Color),
                    AppStyles.text4014(color: AppColors.primary800Color)),
              ],
            ),
          ),
          _divider(),
        ],
      );

  Widget _btn() {
    switch (dto.statusId) {
      // case 1:
      //   return AppButton(
      //     onPressed: (){}, text: "Xem chi tiết",width: AppGap.w136,height: AppGap.h40,radius: AppGap.r4,
      //   );
      // case 2:
      // case 3:
      // case 4:
      //   if (dto.paymentStatus == 'unpaid' && dto.paymentPercent! > 0) {
      //     return AppButton(onPressed: (){}, text: Status.getTextByValue(dto.statusId),width: AppGap.w136,height: AppGap.h40,radius: AppGap.r4,);
      //   }
      //   break;
      // case 13:
      //   return AppButton(onPressed: (){}, text: Status.getTextByValue(dto.statusId),width: AppGap.w136,height: AppGap.h40,radius: AppGap.r4,);
      default:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AppButton(
              onPressed: () async{
                Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
                String isToken = hiveBox.get(AppConstants.ACCESS_TOKEN);
                await RouteService.routeGoOnePage(WebViewScreen(url: "https://m.jancargo.com/redirect?access_token=$isToken&next=/account/quote/${dto.code}?view=app",title: "Chi tiết đơn",),);
              },
              text: "Xem chi tiết",
              width: AppGap.w136,
              height: AppGap.h40,
              radius: AppGap.r4,
              color: AppColors.white,
              textColor: AppColors.neutral800Color,
              borderColor: AppColors.neutral800Color,
            ),
            AppGap.sbW8,
            AppButton(
              onPressed: () async{
                Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
                String isToken = hiveBox.get(AppConstants.ACCESS_TOKEN);
                String encodedString = Uri.encodeComponent('/account/quotes/track/${dto.code}?view=app');
                var url = "https://m.jancargo.com/redirect?access_token=$isToken&next=$encodedString";
                await RouteService.routeGoOnePage(WebViewScreen(url: url,title: "Tra cứu vận đơn",),);

              },
              text: "Tra cứu đơn",
              width: AppGap.w136,
              height: AppGap.h40,
              radius: AppGap.r4,
              color: AppColors.white,
              textColor: AppColors.neutral800Color,
              borderColor: AppColors.neutral800Color,
            ),
            AppGap.sbW8,
          ],
        );
    }
    return const SizedBox.shrink();
  }

  Widget _textSpan(String title, String description, TextStyle titleStyle,
          TextStyle descriptionStyle) =>
      RichText(
        text: TextSpan(
          children: [
            TextSpan(text: title, style: titleStyle),
            TextSpan(
              text: description,
              style: descriptionStyle,
            ),
          ],
        ),
      );

  Widget _divider() => const Divider();

  Widget _titleOder(){
    switch (dto.statusId) {
    case 1:
      return _tag( dto.code!,Status.getTextByValue(dto.statusId),AppColors.greenColor);
    case 2:
    case 3:
    case 4:
      if (dto.paymentStatus == 'unpaid' && dto.paymentPercent! > 0) {
        return _tag( dto.code!,Status.getTextByValue(dto.statusId),AppColors.neutral300Color);
      }
      break;
    case 13:
      return _tag( dto.code!,Status.getTextByValue(dto.statusId),AppColors.primary800Color);
    default: return _tag( dto.code!,Status.getTextByValue(dto.statusId),AppColors.neutral300Color);
    }
    return const SizedBox.shrink();
  }

  Widget _infoItem(BuildContext context) => Row(
        children: [
          Column(
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
                child: AppCarouselImages(
                  fit: BoxFit.cover,
                  height: AppGap.h90,
                  // ignore: invalid_use_of_protected_member
                  imagesUrl: [dto.imageRoot!],
                  alignment: Alignment.topCenter,
                  borderRadius: BorderRadius.circular(AppGap.r8),
                  autoPlay: false,
                  showIndicatorBottom: false,
                  imageDecoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.circular(AppGap.r8))),
                ),
              ),
            ],
          ),
          SizedBox(
            height: AppGap.h110,
            width: AppGap.w232,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: AppGap.w195,
                  child: Text(
                    dto.name!,
                    style: AppStyles.text5014(color: AppColors.neutral800Color),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: false,
                  ),
                ),
                Row(
                  children: [
                    Text(
                        '${AppStrings.of(context).nation}: ${dto.currency == 'JPY' ? 'Nhật Bản' : 'Mỹ'}',
                        style: AppStyles.text4012(
                            color: AppColors.neutral600Color)),
                    const Spacer(),
                    Text('x${dto.quality}',
                        style: AppStyles.text4012(
                            color: AppColors.neutral600Color)),
                    AppGap.sbW8,
                  ],
                ),
                AppGap.sbH10,
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      AppConvert.convertNumberVn(dto.price!),
                      style:
                          AppStyles.text4014(color: AppColors.neutral700Color),
                    ),
                    AppGap.sbW8,
                  ],
                ),
                AppGap.sbH10,
              ],
            ),
          ),
        ],
      );

  Widget _tag(String idOder,String status,Color colorStatus)=>Padding(
    padding:  EdgeInsets.symmetric(horizontal: AppGap.w8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(idOder,style: AppStyles.text6014(color: AppColors.neutral800Color),)
          ],
        ),
        Row(
            children: [
              Text(status,style: AppStyles.text6014(color: colorStatus,),),
            ],
        )
      ],
    ),
  );
}
