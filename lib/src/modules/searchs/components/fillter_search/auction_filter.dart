import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jancargo_app/src/app_manager.dart';
import 'package:jancargo_app/src/components/resource/molecules/primary_text_field.dart';
import 'package:jancargo_app/src/components/resource/molecules/radio_button.dart';
import 'package:jancargo_app/src/domain/dtos/auction/auction_search/auction_search_dto.dart';
import 'package:jancargo_app/src/domain/services/dialog/dialog_service.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/searchs/widget/checkbox_title_search.dart';
import 'package:jancargo_app/src/modules/searchs/widget/widget_filter_producer_search.dart';
import 'package:jancargo_app/src/modules/searchs/widget/widget_selected_title.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../../components/resource/molecules/app_button.dart';
import '../../bloc/auction_search/auction_search_cubit.dart';
import '../../bloc/rakuten_search/rakuten_search_cubit.dart';
import '../../widget/filter_by_price.dart';
import '../../widget/filter_by_price_now.dart';
import '../../widget/filter_by_price_present.dart';
import '../../widget/filter_radio_horizontal.dart';

class AuctionFilterSearch extends StatefulWidget {
  const AuctionFilterSearch({super.key, required this.auctionSearchFiltersDto, required this.count, required this.cubit});

  final List<AuctionSearchFilterDto> auctionSearchFiltersDto;
  final int count;
  final AuctionSearchCubit cubit;

  @override
  State<AuctionFilterSearch> createState() => _AuctionFilterSearchState();
}

class _AuctionFilterSearchState extends State<AuctionFilterSearch> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 500,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 4,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${AppConvert.convertNumber(widget.count)} sản phẩm',
                        style: AppStyles.text6016(color: AppColors.neutral900Color),
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: widget.cubit.isRemoveFilter,
                      builder: (context,value,__) {
                        return widget.cubit.isRemoveFilter.value ?  GestureDetector(
                          onTap: () async{
                            // xoá hết cả dữ liệu của bộ lọc
                            await widget.cubit.removeDataFilter();
                            widget.cubit..discardTempSelectedBrandAuction()..load(
                              '',
                              widget.cubit.controller!.value.text,
                            );

                          },
                          child: Text(
                            'Xoá bộ lọc',
                            style: AppStyles.text6014(color: AppColors.primary700Color),
                          ),
                        )
                        : SizedBox.shrink();
                      }
                    ),
                    GestureDetector(
                      onTap: () => RouteService.pop(),
                      child: SizedBox(
                        width: 32.w,
                        height: 32.h,
                        child: SvgPicture.asset(AppImages.icX),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, thickness: 1),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...widget.auctionSearchFiltersDto.map((e) {
                        return switch (e) {
                          OtherOptionsAuctionSearchFilterDto() => _OtherSelectedFilter(itemOther: e),
                          CategoryAuctionSearchFilterDto() => _CategoryFilter(
                            itemCategory: e,
                          ),
                          ProducerAuctionSearchFilterDto() => _ProducerFilter(
                            itemProducer: e,
                          ),
                          ProductPriceAuctionSearchFilterDto() => _ProductPriceFilter(
                            itemProduct: e,
                          ),
                          ProductStatusAuctionSearchFilterDto() => _ProductStatusFilter(
                            itemProductStatus: e,
                          ),
                          SellerAuctionSearchFilterDto() => _SellerFilter(
                            itemSeller: e,
                          ),
                          _ => const SizedBox.shrink(),
                        };
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: BlocBuilder(
            bloc: widget.cubit,
            builder: (context, state) {
              if (state is! AuctionSearchLoading) {
                return const SizedBox.shrink();
              }

              return Container(
                color: AppColors.white.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(color: AppColors.yellow800Color,),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _OtherSelectedFilter extends StatelessWidget {
  const _OtherSelectedFilter({required this.itemOther});

  final OtherOptionsAuctionSearchFilterDto itemOther;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppGap.sbH10,
              Text(
                itemOther.header!,
                style: AppStyles.text6014(color: AppColors.neutral800Color),
              ),
              AppGap.sbH10,
              ...itemOther.filters!
                  .expand((e) => [e, ...?e.filters])
                  .map((e) => CheckboxTitleSearch(
                item: e,
              ))
                  .expand((e) => [e, AppGap.sbH5]),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}

class _CategoryFilter extends StatelessWidget {
  const _CategoryFilter({required this.itemCategory});

  final CategoryAuctionSearchFilterDto itemCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                itemCategory.header!,
                style: AppStyles.text6014(color: AppColors.neutral800Color),
              ),
              AppGap.sbH5,
              ...itemCategory.filters!
                  .expand((e) => [e, ...?e.filters])
                  .map((e) => WidgetSelectedTitle(
                item: e,
              ))
                  .expand((e) => [e, AppGap.sbH5]),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}

class _ProducerFilter extends StatelessWidget {
  const _ProducerFilter({required this.itemProducer});

  final ProducerAuctionSearchFilterDto itemProducer;

  @override
  Widget build(BuildContext context) {
    final bool hasCheckedItem = itemProducer.filters![0].checked.value == true;
    context.read<AuctionSearchCubit>().brandIds = itemProducer.selected!;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
          child: hasCheckedItem
              ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
              Text(
                itemProducer.header!,
                style: AppStyles.text6014(color: AppColors.neutral800Color),
              ),
                AppGap.sbH10,
              ...itemProducer.filters!
                  .map(
                    (e) => CheckboxTitleSearch(
                  item: e,
                ),
              )
                  .expand((e) => [e, AppGap.sbH5]),
            ],
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                itemProducer.header!,
                style: AppStyles.text6014(color: AppColors.neutral800Color),
              ),
              AppGap.sbH10,
              ...itemProducer.filters!
                  .expand((e) => [e, ...?e.filters])
                  .map(
                    (e) => WidgetSelectedTitle(
                  item: e,
                ),
              )
                  .expand((e) => [e, AppGap.sbH5]),
            ],
          ),
        ),
        // if ( itemProducer. != null)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppGap.w8),
          child: AppButton(
            enable: true,
            color: AppColors.white,
            height: AppGap.h24,
            borderColor: AppColors.neutral300Color,
            radius: AppGap.r4,
            onPressed: () {
              final cubit = context.read<AuctionSearchCubit>();

              // show dialog producer
              DialogService.openDialog(
                BlocProvider.value(
                  value: cubit,
                  child:  WidgetFilterProducerSearch(
                    urlApi: itemProducer.fetchDataUrl!,
                    selectedBrandIDs: itemProducer.selected!,
                    // urlApi:
                    // "/api/auction/search-brand?p=laptop&va=laptop&b=1&n=50&page=1&is_postage_mode=1&dest_pref_code=13&exflg=1&brand_id=100465&keyword=laptop&size=50&query=laptop",
                  ),
                ),
              ).then(
                    (value) async{
                      if(value) {
                       await  cubit.load('', cubit.controller!.value.text,true);
                       cubit.discardTempSelectedBrandAuction();
                      }

                },
              );
            },
            text: 'Nhiều hơn',
            textColor: AppColors.neutral800Color,
          ),
        ),
        const Divider(),
      ],
    );
  }
}

class _ProductPriceFilter extends StatefulWidget {
  const _ProductPriceFilter({required this.itemProduct});

  final ProductPriceAuctionSearchFilterDto itemProduct;

  @override
  State<_ProductPriceFilter> createState() => _ProductPriceFilterState();
}

class _ProductPriceFilterState extends State<_ProductPriceFilter> {
  final NumberFormat _numberFormat = NumberFormat.decimalPattern('vi');

  @override
  Widget build(BuildContext context) {


    var cubit = context.read<AuctionSearchCubit>();
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.itemProduct.header!,
                style: AppStyles.text6014(color: AppColors.neutral800Color),
              ),
              AppGap.sbH10,
              ...widget.itemProduct.filters!
                  .map(
                    (e) {
                      final newName = '${e.label} ~ ${AppConvert.convertAmountVn(e.maxPrice!)}'; // Tạo giá trị mới cho label
                      final updatedItem = AuctionSearchFilterItemDto(isActive: ValueNotifier(false), checked: ValueNotifier(false),url: e.url,maxPrice: e.maxPrice,params: e.params,isChildren: e.isChildren,count: e.count,label: newName,);
                      return WidgetSelectedTitle(
                  item: updatedItem,
                      callBack: (items){
                          cubit.priceToCtrl!.value.text = AppConvert.convertNumber(items.maxPrice!*(AppManager.appSession.exchange ?? 176)).replaceAll(',', '.');
                          print('số tiền được chọn tiền nhật: ${items.maxPrice!} tiền việt: ${items.maxPrice!*(AppManager.appSession.exchange ?? 176)}');
                          cubit.auctionSearchFilterItemDto = items;
                      },
                );
                    },
              )
                  .expand((e) => [e, AppGap.sbH5]),
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: AppGap.w10,vertical: AppGap.h5,),child:Column(children: [
          Row(
            children: [
              Expanded(
                child: PrimaryTextField(
                  onChanged: (value) {
                    // cubit.onChangeFilter();
                  },
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      symbol: null,
                      name: "",
                      locale: "vi",
                      decimalDigits: 0,
                    ),
                  ],
                  controller:  cubit.priceFromCtrl!.value,
                  hintText: 'Từ (VNĐ)',
                  keyboardType: TextInputType.number,
                  onSubmit: (value) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                ),
              ),
              Container(
                width: 25,
                height: 1,
                color: AppColors.neutral200Color,
              ),
              Expanded(
                child: PrimaryTextField(
                  onChanged: (value) {
                    // cubit.onChangeFilter();
                  },
                  controller: cubit.priceToCtrl!.value,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
                    TextInputFormatter.withFunction(
                          (oldValue, newValue) {
                        try {
                          final int parsedValue = int.parse(newValue.text.replaceAll(',', '.'));
                          final newText = _numberFormat.format(parsedValue);
                          return TextEditingValue(
                            text: newText,
                            selection: TextSelection.collapsed(offset: newText.length),
                          );
                        } catch (e) {
                          print(e);
                        }
                        return newValue;
                      },
                    ),
                  ],
                  hintText: 'Đến (VNĐ)',
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          AppGap.sbH5,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ValueListenableBuilder(
                valueListenable: cubit.priceFromCtrl!.value,
                builder: (context, value, child) {
                  return ( value.text.isNotEmpty && value.text != '')
                  ? Text(
                    AppConvert.convertVnAmountJp(value.text == '' ? 0 : int.parse(value.text.replaceAll(',', '').replaceAll('.', ''))),
                  ) : const SizedBox.shrink();
                },
              ),
              ValueListenableBuilder(
                valueListenable: cubit.priceToCtrl!.value,
                builder: (context, value, child) {
                  return (value.text.isNotEmpty && value.text != '')
                  ? Text(
                    AppConvert.convertVnAmountJp(value.text == '' ? 0 : int.parse(value.text.replaceAll(',', '').replaceAll('.', ''))),
                  )
                  : const SizedBox.shrink();
                },
              ),
            ],
          ),
        ],),),
        AppGap.sbH5,
        ValueListenableBuilder(
            valueListenable: cubit.selectedValue,
            builder: (context,_,__) {
              return Padding(
                padding:  EdgeInsets.only(right: AppGap.w10,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomRadioListTile<int>(
                      title: 'Giá hiện tại',
                      value: 0,
                      groupValue: cubit.selectedValue.value,
                      onSelected:(int index){
                        cubit.selectedValue.value = index;
                      },
                    ),
                    CustomRadioListTile<int>(
                      title: 'Giá mua ngay',
                      value: 1,
                      groupValue: cubit.selectedValue.value,
                      onSelected:(int index){
                        cubit.selectedValue.value = index;
                      },
                    ),
                ],
                            ),
              );
          }
        ),
        AppGap.sbH5,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppGap.w8),
          child: AppButton(
            enable: true,
            color: AppColors.white,
            height: AppGap.h24,
            borderColor: AppColors.neutral300Color,
            radius: AppGap.r4,
            onPressed: () {
              final cubit = context.read<AuctionSearchCubit>();
              //
              // var priceFrom = AppConvert.convertVnAmountJp(cubit.priceFromCtrl!.value.text == '' ? 0 : int.parse(cubit.priceFromCtrl!.value.text.replaceAll(',', '').replaceAll('.', '')));
              // var priceTo = AppConvert.convertVnAmountJp(cubit.priceToCtrl!.value.text == '' ? 0 : int.parse(cubit.priceToCtrl!.value.text.replaceAll(',', '').replaceAll('.', '')));
              // if(priceFrom > priceTo){
              //   return DialogService.showNotiBannerInfo(context, 'Số')
              // }

              var param = cubit.auctionSearchFilterItemDto!.params;
              cubit.load('', cubit.controller!.value.text,cubit.selectedBrandAuction.isNotEmpty ? true : false,param,cubit.selectedValue.value == 0 ? 'currentprice': 'bidorbuyprice');
              cubit.isRemoveFilter.value = true;
            },
            text: 'Thu hẹp kết quả với giá trên',
            textSize: 12.sp,
            textColor: AppColors.neutral800Color,
          ),
        ),
        const Divider(),
      ],
    );
  }
}

class _ProductStatusFilter extends StatelessWidget {
  const _ProductStatusFilter({required this.itemProductStatus});

  final ProductStatusAuctionSearchFilterDto itemProductStatus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                itemProductStatus.header!,
                style: AppStyles.text6014(color: AppColors.neutral800Color),
              ),
              AppGap.sbH10,
              ...itemProductStatus.filters!
                  .expand((e) => [e, ...?e.filters])
                  .map(
                    (e) => CheckboxTitleSearch(
                  item: e,
                ),
              )
                  .expand((e) => [e, AppGap.sbH5]),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}

class _SellerFilter extends StatelessWidget {
  const _SellerFilter({required this.itemSeller});

  final SellerAuctionSearchFilterDto itemSeller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                itemSeller.header!,
                style: AppStyles.text6014(color: AppColors.neutral800Color),
              ),
              AppGap.sbH10,
              ...itemSeller.filters!
                  .expand((e) => [e, ...?e.filters])
                  .map(
                    (e) => CheckboxTitleSearch(
                  item: e,
                ),
              )
                  .expand((e) => [e, AppGap.sbH5]),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
