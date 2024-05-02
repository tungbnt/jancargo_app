import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:jancargo_app/src/util/app_gap.dart';
import 'package:remixicon/remixicon.dart';

const Color kSpinButtonColor = Color(0xFFECEDF0);

typedef WillChangedCallback = Future<bool> Function();

class SpinFieldButton extends StatefulWidget {
  const SpinFieldButton({
    super.key,
    this.initialValue = 0,
    this.minValue = 0,
    this.maxValue,
    required this.style,
    required this.border,
    required this.onChanged,
    this.onWillMin,
    this.onWillIncrease,
    this.getCurrentIndex,
  })  : assert(initialValue >= minValue),
        assert(maxValue == null || maxValue > minValue);

  const SpinFieldButton.borderAll({
    super.key,
    this.initialValue = 0,
    this.minValue = 0,
    this.maxValue,
    required this.style,
    required this.onChanged,
    this.onWillMin,
    this.onWillIncrease,
    this.getCurrentIndex,
  })  : assert(initialValue >= minValue),
        assert(maxValue == null || maxValue > minValue),
        border = const Border.fromBorderSide(
          BorderSide(color: kSpinButtonColor),
        );

  const SpinFieldButton.borderBottomOnly({
    super.key,
    this.initialValue = 0,
    this.minValue = 0,
    this.maxValue,
    required this.style,
    required this.onChanged,
    this.onWillMin,
    this.onWillIncrease,
    this.getCurrentIndex,
  })  : assert(initialValue >= minValue),
        assert(maxValue == null || maxValue > minValue),
        border = const Border(
          bottom: BorderSide(color: kSpinButtonColor),
        );

  final int initialValue;
  final int minValue;
  final int? maxValue;
  final TextStyle style;
  final BoxBorder border;
  final ValueSetter<int> onChanged;
  final ValueSetter<int>? getCurrentIndex;

  /// If the callback returns a Future that resolves to false,
  /// [SpinFieldButton] will decrease its value to [minValue]
  final WillChangedCallback? onWillMin;

  /// If the callback returns a Future that resolves to true,
  /// [SpinFieldButton] will increase its value
  final WillChangedCallback? onWillIncrease;

  @override
  State<SpinFieldButton> createState() => _SpinFieldButtonState();
}

class _SpinFieldButtonState extends State<SpinFieldButton> {
  late int _value;
  late final TextEditingController _inputController;

  bool isLessMin = false;

  final inputFormatter = YenInputFormatter();

  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
    final formatedText = inputFormatter.format(_value.toString());
    _inputController = TextEditingController(text: formatedText);
    focusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(covariant SpinFieldButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _value = widget.initialValue;
    _updateInputController();
  }

  void _updateInputController() {
    final value = _value.toString();
    final formatedText = inputFormatter.format(value);
    _inputController.value = TextEditingValue(
      text: formatedText,
      selection: TextSelection.fromPosition(TextPosition(offset: formatedText.length)),
    );
  }

  void _handleInputControllerChanged(String value) {
    final String input = value.replaceAll(',', '').trim();

    final int? inputValue = int.tryParse(input);
    if (inputValue == null || inputValue < widget.minValue) {
      isLessMin = true;
    }

    /*
    if (inputValue == null || inputValue < widget.minValue) {
      _value = widget.minValue;
      final formatedText = inputFormatter.format(widget.minValue.toString());
      _inputController.value = TextEditingValue(
        text: formatedText,
        selection: const TextSelection.collapsed(offset: 1, affinity: TextAffinity.downstream),
      );

      widget.onChanged(_value);
    } else {
      _tryUpdateValue(input, inputValue);
    }
    */

    _tryUpdateValue(input, inputValue ?? widget.minValue);
  }

  void _tryUpdateValue(String input, int inputValue) {
    if (inputValue == widget.minValue && widget.onWillMin != null) {
      widget.onWillMin!.call().then((value) {
        if (value == false) {
          _updateValue(input, inputValue);
        }
      });
    } else {
      _updateValue(input, inputValue);
    }
  }

  void _updateValue(String input, int inputValue) {
    _value = inputValue;

    final formatedText = inputFormatter.format(input);
    _inputController.value = TextEditingValue(
      text: inputFormatter.format(input),
      selection: TextSelection.fromPosition(TextPosition(offset: formatedText.length)),
    );

    widget.onChanged(_value);
  }

  void _handleFocusChange() {
    if (focusNode.hasFocus) return;

    final String input = _inputController.text.replaceAll(',', '').trim();

    final int? inputValue = int.tryParse(input);
    if (inputValue == null || inputValue < widget.minValue) {
      isLessMin = true;
    }

    if (inputValue == null || inputValue < widget.minValue) {
      _value = widget.minValue;
      final formatedText = inputFormatter.format(widget.minValue.toString());
      _inputController.value = TextEditingValue(
        text: formatedText,
        selection: const TextSelection.collapsed(offset: 1, affinity: TextAffinity.downstream),
      );

      widget.onChanged(_value);
    }
  }

  @override
  void dispose() {
    focusNode.removeListener(_handleFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = 32 * MediaQuery.of(context).textScaleFactor;

    final divider = SizedBox(
      height: height,
      child: !widget.border.isUniform
          ? null
          : const VerticalDivider(
        color: kSpinButtonColor,
        width: 1.1,
        thickness: 1.1,
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        border: widget.border,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Button(
            key: const Key('subtract'),
            onTap: () {
              if (_value == widget.minValue) return;

              final newVal = _value - 1;

              _tryUpdateValue(
                newVal.toString(),
                newVal,
              );
            },
            iconData: Remix.subtract_line,
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: AppGap.w208,
            child: TextField(
              controller: _inputController,
              style: widget.style,
              focusNode: focusNode,
              inputFormatters: [
                inputFormatter,
                // CurrencyTextInputFormatter(
                //   symbol: null,
                //   name: "",
                //   locale: "ja",
                //   decimalDigits: 0,
                //   enableNegative: false,
                //   customPattern: "#,###",
                // ),
              ],
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              keyboardType: const TextInputType.numberWithOptions(
                signed: false,
                decimal: false,
              ),
              textAlign: TextAlign.center,
              onChanged: _handleInputControllerChanged,
            ),
          ),
          const SizedBox(width: 8),
          _Button(
            key: const Key('add'),
            onTap: () async {
              if ((await widget.onWillIncrease?.call() ?? true) == false) return;

              if (widget.maxValue != null && _value + 1 > widget.maxValue!) return;

              _value++;
              _updateInputController();
              widget.onChanged(_value);
            },
            iconData: Remix.add_line,
          ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    super.key,
    required this.onTap,
    required this.iconData,
  });

  final VoidCallback onTap;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
      BoxDecoration(color: AppColors.neutral100Color, borderRadius: BorderRadius.all(Radius.circular(AppGap.r4))),
      margin: EdgeInsets.symmetric(horizontal: AppGap.w10, vertical: AppGap.h5),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(iconData, size: 20),
        ),
      ),
    );
  }
}

/// A [TextInputFormatter] that formats the input to the japanese yen format
/// when [enableYenMark] is true, it's add the ￥ at the start of the input.
/// the default [maxLength] is set to 12.
/// the default output format is 900,000,000,000
class YenInputFormatter extends TextInputFormatter {
  final int maxLength;
  final bool enableYenMark;

  YenInputFormatter({
    this.maxLength = 12,
    this.enableYenMark = false,
  });

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueLength = newValue.text.length;

    if (newValueLength == 0) {
      return newValue;
    }

    if (newValueLength > maxLength) {
      return oldValue;
    }

    final newText = StringBuffer();

    if (enableYenMark) {
      newText.write('￥');
    }

    newText.write(_addSeparator(newValue.text));

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  String _addSeparator(String value) {
    value = value.replaceAll(',', '').trim();
    var formattedValue = '';
    var separatorCount = 0;

    for (var i = value.length - 1; i > -1; i--) {
      if (separatorCount == 3) {
        formattedValue = ',$formattedValue';
        separatorCount = 0;
      }
      separatorCount++;
      formattedValue = value[i] + formattedValue;
    }

    return formattedValue;
  }

  String format(String value) {
    return _addSeparator(value);
  }
}
