import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:remixicon/remixicon.dart';

import '../../../util/app_gap.dart';

typedef InputButtonTapCallback<T> = FutureOr<T?> Function();
typedef InputButtonLabelGetter<T> = String Function(T value);

// class InputButton<T> extends StatefulWidget {
//   const InputButton({
//     super.key,
//     required this.tapCallback,
//     this.initialValue,
//     this.hintText,
//     this.labelGetter,
//     this.label,
//   });
//
//   final InputButtonTapCallback<T> tapCallback;
//   final T? initialValue;
//   final String? hintText;
//   final InputButtonLabelGetter<T>? labelGetter;
//   final String? label;
//
//   @override
//   State<InputButton<T>> createState() => _InputButtonState<T>();
// }
//
// class _InputButtonState<T> extends State<InputButton<T>> {
//   T? _value;
//
//   @override
//   void initState() {
//     super.initState();
//     _value = widget.initialValue;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () async {
//         _value = await Future.value(widget.tapCallback());
//         setState(() {});
//       },
//       child: Ink(
//         padding: const EdgeInsets.symmetric(vertical: 11),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//         ).copyWith(
//           border: Border(
//             bottom: BorderSide(
//               color: AppColors.neutral300Color,
//             ),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(widget.label ?? "", style: AppStyles.text4012()),
//             AppGap.sbH10,
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     // ignore: null_check_on_nullable_type_parameter
//                     _value == null
//                         ? widget.hintText ?? ''
//                         : widget.labelGetter?.call(_value!) ??
//                             _value.toString(),
//                     style: AppStyles.text4014(),
//                   ),
//                 ),
//                 AppGap.sbW20,
//                 Icon(
//                   Remix.arrow_right_s_line,
//                   size: 20,
//                   color: AppColors.neutral300Color,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// class InputFieldButton<T> extends StatefulWidget {
//   const InputFieldButton({
//     super.key,
//     required this.tapCallback,
//     required this.data,
//     this.hintText,
//     this.labelGetter, required Function(dynamic value) validator,
//   });
//
//   final InputButtonTapCallback<T> tapCallback;
//   final ValueNotifier<T?> data;
//   final String? hintText;
//   final InputButtonLabelGetter<T>? labelGetter;
//
//   @override
//   State<InputFieldButton<T>> createState() => _InputFieldButtonState<T>();
// }
//
// class _InputFieldButtonState<T> extends State<InputFieldButton<T>> {
//
//   T? get _value => widget.data.value;
//
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return InkWell(
//       onTap: () async {
//         widget.data.value = await Future.value(widget.tapCallback());
//         setState(() {});
//       },
//       child: Ink(
//         padding: const EdgeInsets.symmetric(vertical: 11),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//         ).copyWith(
//           border: Border(
//             bottom: BorderSide(
//               color:AppColors.greenColor,
//             ),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     _value == null
//                         ? widget.hintText ?? ''
//                         // ignore: null_check_on_nullable_type_parameter
//                         : widget.labelGetter?.call(_value!) ?? _value.toString(),
//                     style: AppStyles.text5012(),
//                   ),
//                 ),
//                 // AppGap.w20,
//                 Icon(
//                   Remix.arrow_down_s_fill,
//                   size: 20,
//                   color: AppColors.greenColor,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


class InputFieldButton<T> extends FormField<String> {
  InputFieldButton({
    Key? key,
    required FutureOr<T?> Function(BuildContext context) tapCallback,
    String? hintText,
    required this.data,
    required this.labelGetter,
    bool isFromOtherScreen = true,
    void Function(String?)? onSaved,
    String? Function(String?)? validator,
    AutovalidateMode? autoValidateMode,
    this.iconData,
  }) : super(
          key: key,
          initialValue: labelGetter(data.value),
          onSaved: onSaved,
          validator: validator,
          autovalidateMode: autoValidateMode,
          builder: (FormFieldState<String> field) {
            late final inputDecorationTheme =
                Theme.of(field.context).inputDecorationTheme;
            late final inputEnabledBorderThemeColor =
                inputDecorationTheme.enabledBorder?.borderSide.color;
            late final inputFocusedErrorBorderThemeColor =
                inputDecorationTheme.focusedErrorBorder?.borderSide.color;
            const fallbackColor = AppColors.neutral300Color;

            final borderColor = (field.hasError
                    ? inputFocusedErrorBorderThemeColor
                    : inputEnabledBorderThemeColor) ??
                fallbackColor;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();

                    data.value = await Future.value(tapCallback(field.context));
                    field.didChange(labelGetter(data.value));
                    field.validate();
                  },
                  child: Ink(
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ).copyWith(
                      border: Border(
                        bottom: BorderSide(color: borderColor),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            field.value?.isNotEmpty == true
                                ? field.value!
                                : data.value != null
                                    ? labelGetter(data.value)
                                    : hintText ?? '',
                            style: AppStyles.text4014(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Icon(
                          iconData ?? Remix.arrow_down_s_fill,
                          size: 20,
                          color: AppColors.neutral300Color,
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: field.hasError,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      field.errorText ?? '',
                      style: AppStyles.text4014(),
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
            );
          },
        );

  final ValueNotifier<T?> data;
  final IconData? iconData;

  final InputButtonLabelGetter<T?> labelGetter;

  @override
  FormFieldState<String> createState() => _InputFieldButtonState<T>();
}

class _InputFieldButtonState<T> extends FormFieldState<String> {
  InputFieldButton<T> get _field => super.widget as InputFieldButton<T>;

  @override
  void initState() {
    super.initState();

    _field.data.addListener(_handleDataChange);
    _handleDataChange();
  }

  @override
  void didUpdateWidget(InputFieldButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    final field = _field;
    if (field.data != oldWidget.data) {
      oldWidget.data.removeListener(_handleDataChange);
      _handleDataChange();
      field.data.addListener(_handleDataChange);
    }
  }

  @override
  void dispose() {
    _field.data.removeListener(_handleDataChange);
    super.dispose();
  }

  void _handleDataChange() {
    final field = _field;
    final value = field.data.value;
    if (value != null) {
      setValue(field.labelGetter(value));
    }
  }
}
