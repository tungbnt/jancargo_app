import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jancargo_app/src/components/resource/molecules/radio_button.dart';
import 'package:remixicon/remixicon.dart';

import '../../../components/resource/molecules/secondary_button.dart';
import '../../../components/resource/organisms/will_unfocus_form_scope.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_gap.dart';
import '../bloc/filter_search/filter_search_cubit.dart';
import 'fillter_search_bottomsheet.dart';

class FilterRadioHorizontal extends StatefulWidget {
  const FilterRadioHorizontal({
    Key? key,
    required this.title,
    required this.filterModelForView, required this.cubit,
  }) : super(key: key);

  final String title;
  final FilterSearchCubit cubit;
  final FilterRadioHorizontalController filterModelForView;

  @override
  State<FilterRadioHorizontal> createState() => _FilterRadioHorizontalState();
}

class _FilterRadioHorizontalState extends State<FilterRadioHorizontal> {
  @override
  Widget build(BuildContext context) {
    final options = widget.filterModelForView.options;
    return ValueListenableBuilder(
      valueListenable: widget.filterModelForView.isOptionsVisible,
      builder: (context, isOptionsVisible, __) {
        return FilterRadioComponents(
          title: widget.title,
          showOptions: isOptionsVisible,
          showClearButton: ValueNotifier(false),
          onClearButtonPress: widget.filterModelForView.clearFilter,
          onVisibleButtonPress: widget.filterModelForView.toogleOptionsVisibility,
          hasSelectedOption: widget.filterModelForView.hasSelectedOption,
          children: Row(children: [
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
          ],),
        );
      },
    );
  }
}

class FilterRadioHorizontalController {
  FilterRadioHorizontalController(
      this.options, {
        RadioBoxModel? selectedOption,
      }) {
    selectOption(selectedOption);
  }

  final List<RadioBoxModel> options;

  final ValueNotifier<bool> _isOptionsVisible = ValueNotifier(false);
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


class FilterSearchBottomSheet extends StatefulWidget {
  const FilterSearchBottomSheet({super.key, this.widgetCustom});
  final Widget? widgetCustom;

  @override
  State<FilterSearchBottomSheet> createState() => _FilterSearchBottomSheetState();
}

class _FilterSearchBottomSheetState extends State<FilterSearchBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return WillUnfocusFormScope(
      child: SizedBox(
        height: 500,
        child: Material(
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SingleChildScrollView(
              child: widget.widgetCustom!,
            ),
          ),
        ),
      ),
    );

    /*
    return WillUnfocusFormScope(
      child: SizedBox(
        height: 500,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(AppStrings.of(context).cart),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
          ),
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            child: Container(
              child: widget.widgetCustom!,
            ),
          ),
        ),
      ),
    );
    */
  }
}

class FilterRadioComponents extends StatelessWidget {
  const FilterRadioComponents({
    Key? key,
    required this.title,
    required this.showClearButton,
    required this.onClearButtonPress,
    required this.showOptions,
    required this.onVisibleButtonPress,
    this.hasSelectedOption,
    required this.children,
  }) : super(key: key);

  final String title;

  final ValueListenable<bool>? showClearButton;
  final VoidCallback onClearButtonPress;

  final bool showOptions;
  final VoidCallback onVisibleButtonPress;

  final ValueListenable<bool>? hasSelectedOption;

  final Widget children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        bottom: 18,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: AppStyles.text6016(),
                ),
              ),
              const Spacer(),
              if (hasSelectedOption != null || showClearButton!.value == true)
                ValueListenableBuilder(
                  valueListenable: showClearButton!,
                  builder: (context, visible, child) => Visibility(
                    visible: visible,
                    child: child!,
                  ),
                  child: SecondaryButton(
                    onPressed: onClearButtonPress,
                    text: 'Xoá',
                  ),
                ),
              AppGap.sbW12,
              InkWell(
                onTap: onVisibleButtonPress,
                child: Icon(
                  showOptions == true ? Remix.subtract_line : Remix.add_line,
                ),
              ),
            ],
          ),
          if (hasSelectedOption != null)
            ValueListenableBuilder(
              valueListenable: hasSelectedOption!,
              builder: (context, visible, child) => Visibility(
                visible: visible,
                child: child!,
              ),
              child: AppGap.sbH10,
            ),
          if (showOptions) children,
        ],
      ),
    );
  }
}

class AppRadioButton extends StatelessWidget {
  const AppRadioButton({
    super.key,
    required this.onSelect,
    required this.options,
    required this.selectedOption,
    this.activeColor,
    this.checkColor,
    this.itemPadding,
    this.hasDivider = false,
  });

  final Color? activeColor;
  final Color? checkColor;

  final EdgeInsetsGeometry? itemPadding;
  final ValueSetter<RadioBoxModel> onSelect;
  final List<RadioBoxModel> options;
  final RadioBoxModel? selectedOption;
  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < options.length; i++)
          Row(
            children: [
              CustomRadioListTile<RadioBoxModel>(
                title: options[i].displayName,
                value: options[i],
                groupValue: selectedOption,
                onSelected: onSelect,
              ),
              // if (hasDivider)
              //   const Divider(
              //     color: AppColors.neutral200Color,
              //     thickness: 1,
              //     height: 1,
              //   ),
            ],
          ),
      ],
    );
  }
}