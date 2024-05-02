import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

class AppInput extends StatelessWidget {
  final TextEditingController? controller;
  final Function()? onTap;
  final String? label;
  final TextStyle? textStyle;
  final TextStyle? errorStyle;
  final String? placeholder;
  final String? initialValue;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final TextAlign textAlign;
  final AutovalidateMode? autoValidateMode;
  final EdgeInsets? scrollPadding;
  final bool? enable;
  final int? errorMaxLines;
  final int? maxLine;
  final Function(String value)? onChange;
  final double? height;
  final double? labelSize;
  final bool isObscure;
  final Widget? prefixIcon;

  AppInput(
      {Key? key,
      this.maxLine,
      this.controller,
      this.placeholder,
      this.label,
      this.textStyle =
          const TextStyle(color: AppColors.neutral400Color, fontSize: 16),
      this.enable = true,
      this.isPassword = false,
      this.validator,
      this.inputType,
      this.maxLength,
      this.inputFormatters,
      this.autoValidateMode,
      this.scrollPadding,
      this.errorStyle,
      this.onChange,
      this.textAlign = TextAlign.start,
      this.errorMaxLines,
      this.onTap,
      this.height,
      this.isObscure = false,
      this.labelSize,
      this.prefixIcon, this.initialValue})
      : super(key: key);
  final StreamController<bool> streamControllerObscure = StreamController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Padding(
                padding: EdgeInsets.only(bottom: labelSize != null ? 8 : 16.0),
                child: Text(label!,
                    style: TextStyle(
                        color: AppColors.neutral400Color,
                        fontSize: labelSize ?? 18,
                        fontWeight: FontWeight.bold)),
              )
            : const SizedBox(),
        StreamBuilder<bool>(
            stream: streamControllerObscure.stream,
            builder: (context, snapshot) {
              bool? isObscure = snapshot.data ?? isPassword;
              return Stack(
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: height ?? double.infinity,
                    ),
                    alignment: Alignment.bottomCenter,
                    child: TextFormField(
                      maxLines: maxLine ?? null,
                      controller: controller,
                      initialValue: initialValue,
                      onTap: onTap,
                      keyboardType: inputType,
                      inputFormatters: inputFormatters,
                      maxLength: maxLength,
                      textAlign: textAlign,
                      obscureText: isObscure,
                      validator: validator,
                      enabled: enable,
                      autovalidateMode: autoValidateMode,
                      scrollPadding: scrollPadding ?? const EdgeInsets.all(20),
                      onChanged: onChange,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                        prefixIcon: prefixIcon,
                        counterText: '',
                        hintText: placeholder ?? '',
                        errorStyle: errorStyle,
                        hintStyle: textStyle,
                        border: InputBorder.none,
                        errorMaxLines: errorMaxLines,
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.neutral400Color),
                            borderRadius: BorderRadius.circular(8)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.neutral400Color),
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.neutral400Color),
                            borderRadius: BorderRadius.circular(8)),
                        errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.neutral400Color),
                            borderRadius: BorderRadius.circular(8)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppColors.neutral400Color),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                  isPassword
                      ? Positioned(
                          top: AppGap.h14,
                          right: AppGap.w10,
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                streamControllerObscure.sink.add(!isObscure);
                              },
                              child: SvgPicture.asset(!isObscure
                                  ? AppImages.icEye2
                                  : AppImages.icEyeOff),
                            ),
                          ),
                        )
                      : Container()
                ],
              );
            }),
      ],
    );
  }
}
