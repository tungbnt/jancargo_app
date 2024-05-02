import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jancargo_app/src/components/resource/molecules/primary_text_field.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/filter_search/filter_search_cubit.dart';
import 'package:jancargo_app/src/modules/searchs/widget/fillter_search_bottomsheet.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../../components/resource/molecules/app_button.dart';
import '../../bloc/rakuten_search/rakuten_search_cubit.dart';
import '../../widget/filter_by_price.dart';

class RakutenFilterSearch extends StatefulWidget {
  const RakutenFilterSearch({super.key, required this.filterModel});

  final RakutenFilterModel filterModel;

  @override
  State<RakutenFilterSearch> createState() => _RakutenFilterSearchState();
}

class _RakutenFilterSearchState extends State<RakutenFilterSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(

        child: Column(
          children: [
            FilterByPriceRakuten(
              cubit: widget.filterModel.searchCubit,
              priceFromCtrl: widget.filterModel.searchCubit.priceFromCtrl,
              priceToCtrl: widget.filterModel.searchCubit.priceToCtrl,
            ),
            AppGap.sbW50,
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppButton(
                          height: AppGap.h40,
                          width: AppGap.w163,
                          enable: true,
                          onPressed: () {
                            RouteService.pop();
                          },
                          color: AppColors.white,
                          textColor: AppColors.neutral800Color,
                          borderColor: AppColors.neutral200Color,
                          text: 'Đóng'),
                      AppButton(
                          height: AppGap.h40,
                          width: AppGap.w163,
                          enable: true,
                          onPressed: () {
                            RouteService.popBackResult();
                          },
                          text: 'Lọc'),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),);
  }
}

class FilterByPriceRakuten extends StatelessWidget {
  const FilterByPriceRakuten({
    super.key,
    required this.cubit,
    required this.priceFromCtrl,
    required this.priceToCtrl,
  });

  final FilterSearchCubit cubit;
  final TextEditingController priceFromCtrl;
  final TextEditingController priceToCtrl;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: cubit.showPriceFilter,
      builder: (context, showPriceFilter, __) {
        return FilterComponents(
          title: "Lọc theo giá",
          onClearButtonPress: cubit.clearPrice,
          onVisibleButtonPress: () {

          },
          showOptions: true,
          showClearButton:
          cubit.currentIndexStack.value == 0 ? cubit.showDelete : cubit.showDeleteOnResult,
          children: [
            if (cubit.showPriceFilter.value)
            // '${controller.priceFromCtrl.text} VND - ${controller.priceFromCtrl.text} VND',
              Row(
                children: [
                  ValueListenableBuilder(
                    valueListenable: priceFromCtrl,
                    builder: (context, value, child) {
                      return Text(
                        '${AppConvert.convertAmountVn(value.text == '' ? 0 : int.parse(value.text.replaceAll(',', '')))} VND',
                      );
                    },
                  ),
                  const Text(' - '),
                  ValueListenableBuilder(
                    valueListenable: priceToCtrl,
                    builder: (context, value, child) {
                      return Text(
                        '${AppConvert.convertAmountVn(value.text == '' ? 0 : int.parse(value.text.replaceAll(',', '')))} VND',
                      );
                    },
                  ),
                ],
              ),
            Row(
              children: [
                Expanded(
                  child: PrimaryTextField(
                    onChanged: (value) {
                      cubit.onChangeFilter();
                    },
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                        symbol: null,
                        name: "",
                        locale: "ja",
                        decimalDigits: 0,
                      ),
                    ],
                    controller: priceFromCtrl,
                    hintText: 'Giá từ ¥',
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
                      cubit.onChangeFilter();
                    },
                    controller: priceToCtrl,
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                        symbol: null,
                        name: "",
                        locale: "ja",
                        decimalDigits: 0,
                      ),
                    ],
                    hintText: 'Giá đến ¥',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
