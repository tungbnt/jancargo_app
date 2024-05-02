import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../../auction/components/container_rules.dart';
import '../../auction/components/item_auction.dart';
import '../../auction/components/time_auction.dart';
import '../../auction/components/wallet.dart';
import '../../auction/widget/custom_accordion_vip.dart';
import '../../auction/widget/ship_custom.dart';

class NowAuctionScreen extends StatefulWidget {
  const NowAuctionScreen({super.key, required this.request, required this.dto});

  final PriceRequest request;
  final InfoProductDto dto;

  @override
  State<NowAuctionScreen> createState() => _NowAuctionScreenState();
}

class _NowAuctionScreenState extends State<NowAuctionScreen> {
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
    _cubit.getAuction(widget.request, widget.dto.code!,now: true);
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
          'Đặt giá mua ngay',
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
    percent: double.parse(widget.dto.percent!.replaceAll("%", "")),
  );

  Widget _vip() => BlocConsumer<AuctionListCubit, AuctionState>(
      bloc: _cubit,
      listener: (context,state)async{
        if(state is ActiveVipProductDataSuccess){
          return await AppLoading.openSpinkit(context);
        }else{
          if(state is ActiveVipProductDataSuccess){
            isVip.value = true;
          }else  if(state is GetSessionAfterVipAuctionDataSuccess){
            DialogService.hideDialog();
          }
        }
      },
      listenWhen: (prv, state) => state is ActiveVipProductDataSuccess || state is ActiveVipProductLoading || state is GetSessionAuctionDataSuccess || state is GetSessionAfterVipAuctionDataSuccess,
      buildWhen: (prv, state) => state is GetSessionAuctionDataSuccess,
      builder: (context,state) {
        if(state is GetSessionAuctionDataSuccess){
          isVip.value = state.sessionDto!.data!.vip!;
          return  CustomAccordionVip(dto: state.sessionDto!.data!,wallet: wallet,cubit: _cubit,);
        }
        if(state is GetSessionAfterVipAuctionDataSuccess){
          isVip.value = state.sessionDto!.data!.vip!;
          return  CustomAccordionVip(dto: state.sessionDto!.data!,wallet: wallet,cubit: _cubit,);
        }
        return const SizedBox.shrink();
      }
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
            color: AppColors.primary800Color,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                 Text('Giá mua ngay',style: AppStyles.text6014(color: AppColors.white),),
                 Text(AppConvert.convertAmountJp(priceInitial.value),style: AppStyles.text6020(color: AppColors.white),),
                 Text(AppConvert.convertAmountVn(priceInitial.value),style: AppStyles.text6014(color: AppColors.white),),
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
