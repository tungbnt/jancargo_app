import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jancargo_app/src/components/resource/molecules/app_button.dart';
import 'package:jancargo_app/src/components/resource/molecules/spin_field_btn.dart';
import 'package:jancargo_app/src/data/object_request_api/auction/auction_off/auction_off_request.dart';
import 'package:jancargo_app/src/data/object_request_api/auction/price_auction/price_auction_request.dart';
import 'package:jancargo_app/src/domain/dtos/auction/price/price_dto.dart';
import 'package:jancargo_app/src/domain/dtos/auction_manager/auction_manager_dto.dart';
import 'package:jancargo_app/src/domain/dtos/info_product/info_product_dto.dart';
import 'package:jancargo_app/src/domain/services/dialog/dialog_service.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/general/utils/model_func_utils.dart';
import 'package:jancargo_app/src/modules/auction/bloc/auction_cubit.dart';
import 'package:jancargo_app/src/modules/auction/components/item_auction.dart';
import 'package:jancargo_app/src/modules/auction/components/time_auction.dart';
import 'package:jancargo_app/src/modules/auction/components/wallet.dart';
import 'package:jancargo_app/src/modules/auction/widget/ship_custom.dart';
import 'package:jancargo_app/src/modules/auth/login/screens/login_screen.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

class ResetBidScreen extends StatefulWidget {
  const ResetBidScreen({super.key, required this.dto, required this.request});

  final ItemsAuctionManagerDto dto;
  final PriceRequest request;

  @override
  State<ResetBidScreen> createState() => _ResetBidScreenState();
}

class _ResetBidScreenState extends State<ResetBidScreen> {
  final AuctionListCubit _cubit = AuctionListCubit();
  FeeDetailsDto shipPay = const FeeDetailsDto();
  FeeDetailsDto shipService = const FeeDetailsDto();
  FeeDetailsDto shipInland = const FeeDetailsDto();

  ValueNotifier<int> wallet = ValueNotifier(0);
  ValueNotifier<bool> isVip = ValueNotifier(false);
  ValueNotifier<int> priceInitial = ValueNotifier(0);
  ValueNotifier<bool> isPriceInitial = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _cubit.getAuction(widget.request, widget.dto.code!, now: true);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral200Color,
      extendBody: true,
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: AppColors.white,
        leading: InkWell(
          highlightColor: Colors.transparent,
          onTap: () => RouteService.pop(),
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.black03,
          ),
        ),
        title: Text(
          'Đặt lại giá đấu sản phẩm',
          style: AppStyles.text7018(),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
          if (priceInitial.value < 1000) {
            isPriceInitial.value = true;
          } else {
            isPriceInitial.value = false;
          }
        },
        child: BlocBuilder<AuctionListCubit, AuctionState>(
          bloc: _cubit,
          buildWhen: (prv, state) =>
              state is AuctionDataSuccess || state is AuctionLoading,
          builder: (context, state) {
            if (state is AuctionLoading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            if (state is AuctionDataSuccess) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: AppGap.h10),
                  child: Column(
                    children: [
                      _timeAuction(),
                      _itemAuction(),
                      _priceAuction(),
                      _wallet(),
                      _ship(),
                    ].expand((e) => [e, AppGap.sbH10]).toList(),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      bottomNavigationBar: _containerRules(),
    );
  }

  Widget _timeAuction() => const TimeAuction();

  Widget _itemAuction() => ItemAuctionScreen(
        price: widget.dto.price!,
        name: widget.dto.name!,
        images: widget.dto.images!,
        percent: 0.0,
        // percent: double.parse(widget.dto.percent!.replaceAll("%", "")),
      );

  Widget _priceAuction() {
    return BlocConsumer<AuctionListCubit, AuctionState>(
      bloc: _cubit,
      listener: (context, state) {
        if (state is GetPriceProductAuctionDataSuccess) {
          priceInitial.value = state.priceAuction!;
        }
      },
      listenWhen: (prv, state) => state is GetPriceProductAuctionDataSuccess,
      buildWhen: (prv, state) => state is GetPriceProductAuctionDataSuccess,
      builder: (context, state) {
        if (state is GetPriceProductAuctionDataSuccess) {
          return Container(
            color: AppColors.white,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Giá đấu của bạn'),
                AppGap.sbH5,
                ValueListenableBuilder(
                    valueListenable: isPriceInitial,
                    builder: (context, _, __) {
                      return SpinFieldButton.borderAll(
                        style: AppStyles.text5014(
                            color: AppColors.neutral800Color),
                        onChanged: (int i) {
                          priceInitial.value = i;
                        },
                        initialValue: priceInitial.value,
                        maxValue: 10000000,
                        minValue: priceInitial.value,
                      );
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('1Y = 168 VNĐ'),
                    ValueListenableBuilder(
                        valueListenable: priceInitial,
                        builder: (context, value, __) {
                          return Text(
                              AppConvert.convertAmountVn(priceInitial.value));
                        }),
                  ],
                )
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _wallet() => BlocConsumer<AuctionListCubit, AuctionState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is GetTranAuctionDataSuccess) {
            wallet.value = state.tranDto!.total!;
          }
        },
        listenWhen: (prv, state) => state is GetTranAuctionDataSuccess,
        buildWhen: (prv, state) => state is GetTranAuctionDataSuccess,
        builder: (context, state) {
          if (state is GetTranAuctionDataSuccess) {
            return Column(
              children: [
                Wallet(
                  number: state.tranDto!.total!,
                ),
                Container(
                  color: AppColors.white,
                  padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Đang đấu:'),
                          Text('Tổng tiền:'),
                        ],
                      ),
                      AppGap.sbH5,
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppGap.w10, vertical: AppGap.h5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              AppGap.r4,
                            ),
                          ),
                          border: Border.all(color: AppColors.yellow700Color),
                          color: AppColors.yellow700Color.withOpacity(0.3),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Tổng tiền:'),
                                Text('Tổng tiền:'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('111111'),
                              ],
                            )
                          ],
                        ),
                      ),
                      AppGap.sbH5,
                    ],
                  ),
                )
              ],
            );
          }
          return const SizedBox.shrink();
        },
      );

  Widget _ship() => BlocBuilder<AuctionListCubit, AuctionState>(
      bloc: _cubit,
      buildWhen: (prv, state) => state is GetPriceAuctionDataSuccess,
      builder: (context, state) {
        if (state is GetPriceAuctionDataSuccess) {
          var data = state.dto!.data![0].feeDetails!;

          /// Sử dụng phương thức `firstWhere` để lọc ra danh sách các phần tử thỏa mãn điều kiện
          shipPay = data.firstWhere((e) => e.code == 'phi-thanh-toan',
              orElse: () => const FeeDetailsDto(foreignCurrency: 0));
          shipService = data.firstWhere((e) => e.code == 'phi-dich-vu',
              orElse: () => const FeeDetailsDto(foreignCurrency: 0));
          shipInland = data.firstWhere(
              (e) => e.code == 'phi-van-chuyen-quoc-te',
              orElse: () => const FeeDetailsDto(foreignCurrency: 0));

          return CustomShip(
            shipService: shipService.foreignCurrency.toString() == 'null' ||
                    shipService.foreignCurrency == 0
                ? '0'
                : shipService.foreignCurrency.toString(),
            shipPay: shipPay.foreignCurrency.toString() == 'null' ||
                    shipPay.foreignCurrency == 0
                ? '0'
                : shipPay.foreignCurrency.toString(),
            shipInland: shipInland.foreignCurrency == 0 ||
                    shipInland.foreignCurrency.toString() == 'null'
                ? '0'
                : shipInland.foreignCurrency.toString(),
          );
        } else {
          // Xử lý trường hợp không tìm thấy bất kỳ phần tử nào thỏa mãn điều kiện
          const Text('Không tìm thấy phí nào.');
        }

        return const SizedBox.shrink();
      });

  Widget _containerRules() => BlocListener<AuctionListCubit, AuctionState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is SetPriceAuctionNoteSuccess) {
            priceInitial.value = priceInitial.value + 200;
            DialogService.showNotiBannerInfo(
                context, 'Đấu giá không thành công');
          }
        },
        child: BlocBuilder<AuctionListCubit, AuctionState>(
            bloc: _cubit,
            buildWhen: (prv, state) => state is AuctionDataSuccess,
            builder: (context, state) {
              if (state is AuctionDataSuccess) {
                return ValueListenableBuilder(
                    valueListenable: wallet,
                    builder: (context, value, _) {
                      return _ContainerRules(
                        checkActive:
                            (value >= widget.dto.price!) ? true : false,
                        checkVip: isVip.value,
                        cubit: _cubit,
                        dto: widget.dto,
                        priceAuction: priceInitial,
                      );
                    });
              }
              return const SizedBox.shrink();
            }),
      );
}

class _ContainerRules extends StatefulWidget {
  const _ContainerRules(
      {super.key,
      required this.checkActive,
      required this.cubit,
      required this.priceAuction,
      required this.dto,
      required this.checkVip});

  final bool checkActive;
  final bool checkVip;

  final AuctionListCubit cubit;
  final ItemsAuctionManagerDto dto;
  final ValueNotifier<int> priceAuction;

  @override
  State<_ContainerRules> createState() => _ContainerRulesState();
}

class _ContainerRulesState extends State<_ContainerRules> {
  ValueNotifier<bool> isActive = ValueNotifier(false);
  late ItemsAuctionManagerDto dto;

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
        images: dto.images,
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
        saleId: ''));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppGap.h90,
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
              builder: (context, value, __) {
                return BlocListener<AuctionListCubit, AuctionState>(
                  bloc: widget.cubit,
                  listenWhen: (prv, state) =>
                      state is SetPriceAuctionSuccess ||
                      state is SetPriceAuctionLoading ||
                      state is SetPriceFailedSuccess,
                  listener: (context, state) async {
                    if (state is SetPriceAuctionSuccess) {
                      await RouteService.pop();
                      await RouteService.pop();
                      DialogService.showNotiBannerInfo(
                          context, 'Đấu giá thành công');
                    } else if (state is SetPriceAuctionLoading) {
                      openDialogBox(
                          context,
                          const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.yellow800Color,
                            ),
                          ),
                          isBarrierDismissible: true);
                    } else if (state is SetPriceFailedSuccess) {
                      RouteService.pop();
                      DialogService.showNotiBannerInfo(
                          context, 'Đã có lỗi xảy ra!');
                    } else if (state is SetPriceAuctionNoteSuccess) {
                      RouteService.pop();
                      DialogService.showNotiBannerInfo(
                          context, 'Đấu giá không thành công');
                    }
                  },
                  child: ValueListenableBuilder(
                      valueListenable: isActive,
                      builder: (context, value, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: AppGap.w10,),
                                child: AppButton(
                                  enable: value && widget.checkActive,
                                  height: AppGap.h32,
                                  onPressed: () => _btnAuctionOff(),
                                  text: "Đặt giá ngay",
                                ),
                              ),
                            ),
                            Expanded(
                              child: AppButton(
                                  enable: value && widget.checkActive,
                                  height: AppGap.h32,
                                  onPressed: () => _btnAuctionOff(),
                                  text: 'Đặt giá sẵn'),
                            ),
                          ],
                        );
                      }),
                );
              })
        ],
      ),
    );
  }
}
