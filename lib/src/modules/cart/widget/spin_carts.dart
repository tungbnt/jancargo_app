import 'package:flutter/material.dart';
import 'package:jancargo_app/src/components/resource/molecules/spin_button.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/util/app_gap.dart';



class SpinCarts extends StatelessWidget {
  const SpinCarts({
    super.key,
    required this.selectedAmount,
    required this.onChanged,  required this.readOnly,
  });

  final ValueNotifier<int> selectedAmount;
  final ValueSetter<int> onChanged;
  final bool readOnly ;


  @override
  Widget build(BuildContext context) {


    return SpinButton.borderAll(
      initialValue: selectedAmount.value,
      minValue: 1,
      style: AppStyles.text7016(),
      onChanged: onChanged,
      readOnly: readOnly,
    );
  }
}
