import 'package:flutter/material.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../../components/resource/molecules/app_button.dart';
import '../../../../components/resource/molecules/input.dart';
import '../../../../domain/services/utils/validation.dart';
import '../../../../general/app_strings/app_strings.dart';
import '../../../../general/constants/app_styles.dart';
import '../bloc/forget_pass_cubit.dart';

class InputNewPassPage extends StatefulWidget {
  const InputNewPassPage({super.key, required this.cubit});

  final ForgetPassCubit cubit;

  @override
  State<InputNewPassPage> createState() => _InputNewPassPageState();
}

class _InputNewPassPageState extends State<InputNewPassPage> {
  late ForgetPassCubit _cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = widget.cubit;
  }

  void _onTapNext(BuildContext context) {
    if (_cubit.formKey.currentState!.validate()) {
      _cubit.resetPass();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.of(context).newPass,
            style: AppStyles.text5014(),
          ),
          AppInput(
            placeholder: AppStrings.of(context).hintPass,
            controller: _cubit.inputPass,
            maxLine: 1,
            isObscure: true,
            isPassword: true,
            validator: (value) {
              return Validation.validatorPass(value);
            },
            onChange: (value) {},
          ),
          Text(
            AppStrings.of(context).newPassAgain,
            style: AppStyles.text5014(),
          ),
          AppInput(
            placeholder: AppStrings.of(context).hintPassAgain,
            controller: _cubit.inputPassAgain,
            maxLine: 1,
            isObscure: true,
            isPassword: true,
            validator: (value) {
              return Validation.validatorPassAgain(
                  _cubit.inputPassAgain.text, _cubit.inputPass.text);
            },
            onChange: (value) {
              setState(() {});
            },
          ),
          AppGap.sbH10,
          AppButton(
              enable: (_cubit.inputPassAgain.text.isNotEmpty &&
                      _cubit.inputPass.text.isNotEmpty)
                  ? true
                  : false,
              onPressed: () => _onTapNext(context),
              text: AppStrings.of(context).next),
        ].expand((e) => [e, AppGap.sbH10]).toList(),
      ),
    );
  }
}
