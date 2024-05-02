import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/app_manager.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';
import 'package:jancargo_app/src/modules/auction/bloc/auction_cubit.dart';
import 'package:jancargo_app/src/util/app_convert.dart';

import '../../../components/resource/molecules/app_loading.dart';
import '../../../components/resource/molecules/spin_field_btn.dart';
import '../../../data/object_request_api/auction/price_auction/price_auction_request.dart';
import '../../../domain/dtos/auction/price/price_dto.dart';
import '../../../domain/dtos/info_product/info_product_dto.dart';
import '../../../domain/services/dialog/dialog_service.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_gap.dart';
import '../components/container_rules.dart';
import '../components/item_auction.dart';
import '../components/time_auction.dart';
import '../components/wallet.dart';
import '../widget/custom_accordion_vip.dart';
import '../widget/ship_custom.dart';

class AuctionScreen extends StatefulWidget {
  const AuctionScreen({super.key, required this.request, required this.dto});

  final PriceRequest request;
  final InfoProductDto dto;

  @override
  State<AuctionScreen> createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
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
    _cubit.getAuction(widget.request, widget.dto.code!);
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
          AppStrings.of(context).setPriceAuction,
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
                      _vip(),
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
        images: widget.dto.thumbnails!,
        percent: double.parse(widget.dto.percent?.replaceAll("%", "") ?? ""),
      );

  Widget _vip() => BlocConsumer<AuctionListCubit, AuctionState>(
      bloc: _cubit,
      listener: (context, state) async {
        if (state is ActiveVipProductLoading) {
          return await AppLoading.openSpinkit(context);
        } else {
          if (state is ActiveVipProductDataSuccess) {
            isVip.value = true;
            DialogService.hideDialog();
            DialogService.showNotiBannerSuccess(
                context, 'Nâng cấp VIP thành công!');
          } else if (state is GetSessionAfterVipAuctionDataSuccess) {
            DialogService.hideDialog();
          }else if(state is ActiveVipProductNoSuccess){
            DialogService.hideDialog();
            DialogService.showNotiBannerInfo(
                context, 'Nâng cấp VIP không thành công!');
          }else if(state is ActiveVipProductFailed){
            DialogService.hideDialog();
            DialogService.showNotiBannerFailed(
                context,AppColors.primary300Color, 'Đã có lỗi xảy!');
          }
        }
      },
      listenWhen: (prv, state) =>
          state is ActiveVipProductDataSuccess ||
          state is ActiveVipProductLoading ||
          state is GetSessionAuctionDataSuccess ||
          state is GetSessionAfterVipAuctionDataSuccess ||
          state is ActiveVipProductNoSuccess ||
          state is ActiveVipProductFailed,
      buildWhen: (prv, state) => state is GetSessionAuctionDataSuccess,
      builder: (context, state) {
        if (state is GetSessionAuctionDataSuccess) {
          isVip.value = state.sessionDto!.data!.vip!;
          return CustomAccordionVip(
            dto: state.sessionDto!.data!,
            wallet: wallet,
            cubit: _cubit,
          );
        }
        if (state is GetSessionAfterVipAuctionDataSuccess) {
          isVip.value = state.sessionDto!.data!.vip!;
          return CustomAccordionVip(
            dto: state.sessionDto!.data!,
            wallet: wallet,
            cubit: _cubit,
          );
        }
        return const SizedBox.shrink();
      });

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
                     Text('1Y = ${AppManager.appSession.exchange!} VNĐ'),
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
            return Wallet(
              number: state.tranDto!.total!,
              callBack: () =>
                  _cubit.getAuction(widget.request, widget.dto.code!),
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
                      return ContainerRules(
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
