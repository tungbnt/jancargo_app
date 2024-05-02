import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../../app_manager.dart';
import '../../../../components/resource/molecules/app_button.dart';
import '../../../../components/resource/molecules/input.dart';
import '../../../../domain/services/utils/validation.dart';
import '../../../../general/app_strings/app_strings.dart';
import '../../../../general/constants/app_styles.dart';
import '../bloc/forget_pass_cubit.dart';

class InputFieldPage extends StatefulWidget {
  const InputFieldPage({super.key, required this.cubit});

  final ForgetPassCubit cubit;

  @override
  State<InputFieldPage> createState() => _InputFieldPageState();
}

class _InputFieldPageState extends State<InputFieldPage> {
  late ForgetPassCubit _cubit;
  bool isActive = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = widget.cubit;
  }

  void _onTapNext(BuildContext context) {
    if (_cubit.formKeyInput.currentState!.validate()) {
      AppManager.appSession.saveAccount(_cubit.inputEmail.text);
      _cubit.getOtp();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _cubit.formKeyInput,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.of(context).hintEmail,
            style: AppStyles.text5014(),
          ),
          AppGap.sbH20,
          _filed(),
          AppGap.sbH32,
          _btn(),
        ],
      ),
    );
  }

  Widget _filed() => AppInput(
        placeholder: AppStrings.of(context).hintAccount,
        controller: _cubit.inputEmail,
        maxLine: 1,
        validator: (value) {
          late final RegExp numberRegex = RegExp(r'^[0-9]+$');
          if (numberRegex.hasMatch(value!) == true) {
            return Validation.validatorPhone(value);
          }else
         {
            return Validation.validateEmail(email: value);
          }

        },
        onChange: (value) {
          late final RegExp numberRegex = RegExp(r'\d+');

          setState(() {
            if (_cubit.inputEmail.text.isEmpty) {
              isActive = false;
            } else {
              isActive = true;
            }
          });
          AppManager.appSession.saveType(value.contains(numberRegex) == false
              ? AppConstants.phone
              : AppConstants.email);

        },
      );

  Widget _btn() => AppButton(
      enable: isActive,
      onPressed: () => _onTapNext(context),
      text: AppStrings.of(context).next);
}
