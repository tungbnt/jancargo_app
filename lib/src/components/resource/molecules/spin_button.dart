import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

const Color kSpinButtonColor = Color(0xFFECEDF0);

typedef WillChangedCallback = Future<bool> Function();

class SpinButton extends StatefulWidget {
  const SpinButton({
    super.key,
    this.initialValue = 0,
    this.minValue = 0,
    this.maxValue,
    required this.style,
    required this.border,
    required this.onChanged,
    this.readOnly = false,
    this.onWillMin,
    this.onWillIncrease,
  })  : assert(initialValue >= minValue),
        assert(maxValue == null || maxValue > minValue);

  const SpinButton.borderAll({
    super.key,
    this.initialValue = 0,
    this.minValue = 0,
    this.maxValue,
    required this.style,
    required this.onChanged,
    this.readOnly = false,
    this.onWillMin,
    this.onWillIncrease,
  })  : assert(initialValue >= minValue),
        assert(maxValue == null || maxValue > minValue),
        border = const Border.fromBorderSide(
          BorderSide(color: kSpinButtonColor),
        );

  const SpinButton.borderBottomOnly({
    super.key,
    this.initialValue = 0,
    this.minValue = 0,
    this.maxValue,
    required this.style,
    required this.onChanged,
    this.onWillMin,
    this.onWillIncrease,  this.readOnly = false,
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
  final bool readOnly ;

  /// If the callback returns a Future that resolves to false,
  /// [SpinButton] will decrease its value to [minValue]
  final WillChangedCallback? onWillMin;

  /// If the callback returns a Future that resolves to true,
  /// [SpinButton] will increase its value
  final WillChangedCallback? onWillIncrease;

  @override
  State<SpinButton> createState() => _SpinButtonState();
}

class _SpinButtonState extends State<SpinButton> {
  late int _value;
  late final TextEditingController _inputController;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
    _inputController = TextEditingController(text: _value.toString());
  }

  @override
  void didUpdateWidget(covariant SpinButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _value = widget.initialValue;
    _updateInputController();
  }

  void _updateInputController() {
    final value = _value.toString();
    _inputController.value = TextEditingValue(
      text: value,
      selection: TextSelection.fromPosition(TextPosition(offset: value.length)),
    );
  }

  void _handleInputControllerChanged(String value) {
    final String input = value.trim();

    final int? inputValue = int.tryParse(input);

    if (inputValue == null || inputValue < widget.minValue) {
      _value = 1;
      _inputController.value = const TextEditingValue(
        text: '1',
        selection: TextSelection.collapsed(offset: 1, affinity: TextAffinity.downstream),
      );

      widget.onChanged(_value);
    } else {
      _tryUpdateValue(input, inputValue);
    }
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

    _inputController.value = TextEditingValue(
      text: input,
      selection: TextSelection.fromPosition(TextPosition(offset: input.length)),
    );

    widget.onChanged(_value);
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

              _tryUpdateValue(newVal.toString(), newVal);
            },
            iconData: Remix.subtract_line,
          ),
          divider,
          const SizedBox(width: 8),
          SizedBox(
            width: 20,
            child: TextField(
              readOnly: widget.readOnly,
              controller: _inputController,
              style: widget.style,
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
          divider,
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
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(iconData, size: 20),
      ),
    );
  }
}
