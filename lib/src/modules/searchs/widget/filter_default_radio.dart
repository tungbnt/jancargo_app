import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jancargo_app/src/components/resource/molecules/radio_button.dart';

import '../bloc/filter_search/filter_search_cubit.dart';
import 'fillter_search_bottomsheet.dart';

class FilterDefaultRadio extends StatefulWidget {
  const FilterDefaultRadio({
    Key? key,
    required this.title,
    required this.filterModelForView, required this.cubit,
  }) : super(key: key);

  final String title;
  final FilterSearchCubit cubit;
  final FilterDefaultRadioController filterModelForView;

  @override
  State<FilterDefaultRadio> createState() => _FilterDefaultRadioState();
}

class _FilterDefaultRadioState extends State<FilterDefaultRadio> {
  @override
  Widget build(BuildContext context) {
    final options = widget.filterModelForView.options;
    return ValueListenableBuilder(
      valueListenable: widget.filterModelForView.isOptionsVisible,
      builder: (context, isOptionsVisible, __) {
        return FilterComponents(
          title: widget.title,
          showOptions: isOptionsVisible,
          showClearButton: ValueNotifier(false),
          onClearButtonPress: widget.filterModelForView.clearFilter,
          onVisibleButtonPress: widget.filterModelForView.toogleOptionsVisibility,
          hasSelectedOption: widget.filterModelForView.hasSelectedOption,
          children: [
            for (int i = 0; i < options.length; i++)
              ValueListenableBuilder(
                valueListenable: widget.filterModelForView.groupValue,
                builder: (_, groupValue, ___) {
                  return CustomRadioListTile<RadioBoxModel>(
                    title: options[i].displayName,
                    value: options[i],
                    groupValue: groupValue,
                    onSelected: widget.filterModelForView.selectOption,
                  );
                },
              ),
          ],
        );
      },
    );
  }
}

class FilterDefaultRadioController {
  FilterDefaultRadioController(
      this.options, {
        RadioBoxModel? selectedOption,
      }) {
    selectOption(selectedOption);
  }

  final List<RadioBoxModel> options;

  final ValueNotifier<bool> _isOptionsVisible = ValueNotifier(true);
  ValueListenable<bool> get isOptionsVisible => _isOptionsVisible;

  final ValueNotifier<RadioBoxModel?> _groupValue = ValueNotifier(null);
  ValueListenable<RadioBoxModel?> get groupValue => _groupValue;

  final ValueNotifier<bool> _hasSelectedOption = ValueNotifier(false);
  ValueListenable<bool> get hasSelectedOption => _hasSelectedOption;

  /*
  String getSelectedParams() {
    final idSelectedList = optionsList.where((element) => element.status.value).map((e) => e.data!['id']).toList();
    return idSelectedList.isEmpty ? "" : "${id}_${idSelectedList.join(', ')}";
  }

  getSelectedFilterName() {
    final filledCategory = optionsList.where((element) => element.status.value).map((e) => e.data!["name"]);
    return filledCategory;
  }
  */

  clearFilter() {
    selectOption(null);
  }

  void selectOption(RadioBoxModel? model) {
    _groupValue.value = model;
    _hasSelectedOption.value = model != null;
  }

  void toogleOptionsVisibility() {
    _isOptionsVisible.value = !isOptionsVisible.value;
  }
}
