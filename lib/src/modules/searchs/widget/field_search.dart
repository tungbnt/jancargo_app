import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jancargo_app/src/components/resource/molecules/input.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/util/app_gap.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../bloc/yahoo_shopping_search/yahoo_shopping_search_cubit.dart';

class FieldSearch extends StatefulWidget {
  FieldSearch({
    super.key,
    required this.onChange,
    this.controller,
    this.filterSheetBuilder,
    this.arrangeSheetBuilder,
    this.valueFilter,
    this.valueArrange,
    this.constraintsHeightBottomSheet = false,
  });

  final ValueSetter<String> onChange;
  final TextEditingController? controller;
  final WidgetBuilder? filterSheetBuilder;
  final WidgetBuilder? arrangeSheetBuilder;
  final ValueSetter<bool>? valueFilter;
  final ValueSetter<bool>? valueArrange;
  final bool? constraintsHeightBottomSheet;

  @override
  State<FieldSearch> createState() => _FieldSearchState();
}

class _FieldSearchState extends State<FieldSearch> {
  late final TextEditingController _controller =
      widget.controller ?? TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding:
          EdgeInsets.symmetric(horizontal: AppGap.w10, vertical: AppGap.h5),
      margin: EdgeInsets.only(bottom: AppGap.h10),
      color: AppColors.white,
      child: Row(
        children: [
          SizedBox(
            width: widget.filterSheetBuilder == null &&
                    widget.arrangeSheetBuilder == null
                ? 340.w
                : (widget.filterSheetBuilder != null &&
                        widget.arrangeSheetBuilder == null
                    ? 300.w
                    : 274.w),
            child: AppInput(
              placeholder: _controller.text.isEmpty
                  ? 'Tìm kiếm sản phẩm'
                  : (_controller.text != "" ? '' : 'Tìm kiếm sản phẩm'),
              controller: widget.controller,
              maxLine: 1,
              prefixIcon: SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: Center(
                      child: SvgPicture.asset(
                    AppImages.icSearchSmall,
                    color: AppColors.neutral400Color,
                    height: 20.h,
                    width: 20.w,
                    fit: BoxFit.contain,
                  ))),
              onChange: widget.onChange,
            ),
          ),
          if (widget.filterSheetBuilder != null) AppGap.sbW12,
          if (widget.arrangeSheetBuilder != null)
            GestureDetector(
              onTap: () {
                showCupertinoModalBottomSheet(
                  enableDrag: false,
                  context: context,
                  builder: widget.arrangeSheetBuilder!,
                ).then((value) {
                  if (value != true) return;
                  widget.valueArrange?.call(value);
                });
              },
              child: SvgPicture.asset(AppImages.icArrange),
            ),
          if (widget.arrangeSheetBuilder != null) AppGap.sbW12,
          if (widget.filterSheetBuilder != null)
            GestureDetector(
              onTap: () {
                widget.constraintsHeightBottomSheet == false
                    ? showCupertinoModalBottomSheet(
                        enableDrag: false,
                        context: context,
                        builder: widget.filterSheetBuilder!,
                      ).then((value) {
                        if (value != true) return;
                        widget.valueFilter?.call(value);
                      })
                    : showModalBottomSheet(
                        context: context,

                        constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height * .0,
                            maxHeight: MediaQuery.of(context).size.height * .3),
                        isScrollControlled: false,
                        builder: widget.filterSheetBuilder!,
                      ).then((value) {
                        if (value != true) return;
                        widget.valueFilter?.call(value);
                      });
              },
              child: SvgPicture.asset(AppImages.icFilter),
            ),
        ],
      ),
    );
  }
}
