import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import '../../../components/resource/molecules/primary_text_field.dart';
import '../bloc/filter_search/filter_search_cubit.dart';
import 'fillter_search_bottomsheet.dart';

class FilterByPricePresent extends StatelessWidget {
  const FilterByPricePresent({
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
          title: "Giá đấu hiện tại",
          onClearButtonPress: cubit.clearPrice,
          onVisibleButtonPress: () {
            cubit.showPriceFilter.value = !cubit.showPriceFilter.value;
          },
          showOptions: showPriceFilter,
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
                    hintText: '0 ¥',
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
                    hintText: '0 ¥',
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
