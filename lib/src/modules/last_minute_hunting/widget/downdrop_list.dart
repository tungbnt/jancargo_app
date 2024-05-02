import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';

import '../../../components/widget/dropdown_textfield.dart';

class DropDownList extends StatelessWidget {
  const DropDownList({super.key, this.controller, this.onTap, this.height});

  final TextEditingController? controller;
  final Function()? onTap;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: height ?? double.infinity,
      ),
      alignment: Alignment.bottomCenter,
      child: DropDownTextField(
        initialValue:  '1 phút trước khi kết thúc phiên',
        controller: controller,
        clearOption: false,
        dropdownColor: AppColors.white,
        textFieldDecoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          counterText: '',
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primary800Color),
              borderRadius: BorderRadius.circular(8)),
          disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.neutral400Color),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.neutral400Color),
              borderRadius: BorderRadius.circular(8)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.neutral400Color),
              borderRadius: BorderRadius.circular(8)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.neutral400Color),
              borderRadius: BorderRadius.circular(8)),
        ),
        // enableSearch: true,
        // dropdownColor: Colors.green,
        searchDecoration:
            const InputDecoration(hintText: "enter your custom hint text here"),
        validator: (value) {
          if (value == null) {
            return "Required field";
          } else {
            return null;
          }
        },
        dropDownItemCount: 7,

        dropDownList: const [
          DropDownValueModel(name: '1 phút trước khi kết thúc phiên', value: "value1"),
          DropDownValueModel(
            name: '2 phút trước khi kết thúc phiên',
            value: "value2",
          ),
          DropDownValueModel(name: '3 phút trước khi kết thúc phiên', value: "value3"),
          DropDownValueModel(
            name: '4 phút trước khi kết thúc phiên',
            value: "value4",
          ),
          DropDownValueModel(name: '5 phút trước khi kết thúc phiên', value: "value5"),
          DropDownValueModel(name: '6 phút trước khi kết thúc phiên', value: "value6"),
          DropDownValueModel(name: '7 phút trước khi kết thúc phiên', value: "value7"),

        ],
        onChanged: (val) {},
      ),
    );
  }
}
