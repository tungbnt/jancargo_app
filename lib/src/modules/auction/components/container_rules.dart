import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jancargo_app/src/data/object_request_api/auction/auction_off/auction_off_request.dart';
import 'package:jancargo_app/src/domain/services/dialog/dialog_service.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';
import 'package:jancargo_app/src/modules/auction/bloc/auction_cubit.dart';

import '../../../components/resource/molecules/app_button.dart';
import '../../../components/resource/molecules/app_loading.dart';
import '../../../domain/dtos/info_product/info_product_dto.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_styles.dart';
import '../../../general/utils/model_func_utils.dart';
import '../../../util/app_gap.dart';
import '../../auth/login/screens/login_screen.dart';

class ContainerRules extends StatefulWidget {
  const ContainerRules(
      {super.key,
      required this.checkActive,
      required this.cubit,
      required this.priceAuction,
      required this.dto, required this.checkVip});

  final bool checkActive;
  final bool checkVip;

  final AuctionListCubit cubit;
  final InfoProductDto dto;
  final ValueNotifier<int> priceAuction;

  @override
  State<ContainerRules> createState() => _ContainerRulesState();
}

class _ContainerRulesState extends State<ContainerRules> {
  ValueNotifier<bool> isActive = ValueNotifier(false);
  late InfoProductDto dto;

  @override
  void initState() {
    super.initState();
    dto = widget.dto;
  }

  void _btnAuctionOff() {
    widget.cubit.auctionOff(AuctionOffRequest(
      tax: dto.tax!.toString(),
      price: widget.priceAuction.value.toString(),
      bids: dto.bids,

      images: dto.thumbnails,
      name: dto.name,
      code: dto.code,
      endTime: dto.endTime,
      shipMode: "AIR-HAN",
      currency: "JPY",
      exchangeRate: "178",
      url: dto.url,
      shippingCharges: "0",
      serviceExtra: ["BASIS"],
      paymentMethods: [
        "simple",
        "PayPay（残高）",
        "PayPay（クレジット）※旧あと払い",
        "credit_card",
        "paypay_bank",
        "transfer",
        "convenient_store_payment"
      ],
      sellerId: dto.sellerId,
      partial: "0",
      mode: "now",
      lastMinuteToBid: null,
      qty: "1",
      reputationLevel: "LOW",
      saleId: ''
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppGap.h90,
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 28.w,
                height: 28.h,
                child: Checkbox(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r)),
                  side: const BorderSide(
                      color: AppColors.neutral300Color, width: 2),
                  activeColor: AppColors.yellow700Color,
                  value: isActive.value,
                  onChanged: ((value) {
                    setState(() {
                      isActive.value = !isActive.value;
                    });
                  }),
                ),
              ),
              AppGap.sbW8,
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: AppStyles.text4012(color: AppColors.neutral600Color),
                    children: [
                      const TextSpan(text: "Đồng ý với "),
                      TextSpan(
                        text: AppStrings.of(context).termsAndPolicies,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => RouteService.routePushReplacementPage(
                                const LoginScreen(),
                              ),
                        style: AppStyles.text4012(
                            color: AppColors.primary800Color),
                      ),
                      const TextSpan(text: " của Jancargo"),
                    ]),
              ),
            ],
          ),
          ValueListenableBuilder(
            valueListenable: widget.priceAuction,
            builder: (context,value,__) {
              return BlocListener<AuctionListCubit, AuctionState>(
                bloc: widget.cubit,
                listenWhen: (prv,state)=> state is SetPriceAuctionSuccess || state is SetPriceAuctionLoading || state is SetPriceFailedSuccess,
                listener: (context, state) async{
                    if(state is SetPriceAuctionSuccess){
                     await RouteService.pop();
                     await RouteService.pop();
                      DialogService.showNotiBannerInfo(context, 'Đấu giá thành công');
                    }else if(state is SetPriceAuctionLoading){
                      openDialogBox(
                          context,
                          const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.yellow800Color,
                            ),
                          ),
                          isBarrierDismissible: true);
                    }else if(state is SetPriceFailedSuccess){
                      RouteService.pop();
                      DialogService.showNotiBannerInfo(context, 'Đã có lỗi xảy ra!');
                    }else if(state is SetPriceAuctionNoteSuccess){
                      RouteService.pop();
                      DialogService.showNotiBannerInfo(context, 'Đấu giá không thành công');
                    }
                },
                child: ValueListenableBuilder(
                  valueListenable: isActive,
                  builder: (context,value,_) {
                    return AppButton(
                        enable: value && widget.checkActive && widget.checkVip,
                        onPressed: () => _btnAuctionOff(),
                        text: AppStrings.of(context).setPrice);
                  }
                ),
              );
            }
          )
        ],
      ),
    );
  }
}
