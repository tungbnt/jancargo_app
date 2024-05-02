import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:pinput/pinput.dart';

import '../../../../app_manager.dart';
import '../../../../components/resource/molecules/app_button.dart';
import '../../../../general/app_strings/app_strings.dart';
import '../../../../util/app_gap.dart';
import '../bloc/forget_pass_cubit.dart';

class InputOtpPage extends StatefulWidget {
  const InputOtpPage(
      {super.key, required this.cubit, required this.resetValidation});

  final ForgetPassCubit cubit;
  final bool resetValidation;

  @override
  State<InputOtpPage> createState() => _InputOtpPageState();
}

class _InputOtpPageState extends State<InputOtpPage> {
  late ForgetPassCubit _cubit;
  bool isActive = false;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = widget.cubit;
  }

  @override
  void dispose() {
    _cubit.pinController.dispose();
    _cubit.focusNode.dispose();
    super.dispose();
  }

  void _onTapVerifyOtp(BuildContext context) {

      _cubit.verifyOtp();

  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = AppColors.neutral800Color;
    const fillColor = AppColors.white;
    const borderColor = AppColors.neutral300Color;

    final defaultPinTheme = PinTheme(
      width: 45,
      height: 45,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: borderColor),
      ),
    );
    return Column(
      children: [
        Row(
          children: [
            Text(
              AppStrings.of(context).confirm,
              style: AppStyles.text5014(),
            ),
          ],
        ),
        AppGap.sbH32,
        Text(
          AppStrings.of(context).textYourCodeSendEmail +
              AppManager.appSession.type!,
          style: AppStyles.text5014(),
        ),
        Text(
          AppManager.appSession.account!,
          style: AppStyles.text5014(),
        ),
        AppGap.sbH32,
        Directionality(
          // Specify direction if desired
          textDirection: TextDirection.ltr,
          child: Pinput(
            length: 6,
            controller: _cubit.pinController,
            focusNode: _cubit.focusNode,
            androidSmsAutofillMethod:
                AndroidSmsAutofillMethod.smsUserConsentApi,
            listenForMultipleSmsOnAndroid: true,
            defaultPinTheme: defaultPinTheme,
            separatorBuilder: (index) => AppGap.sbW8,
            validator: (value) {
              if (_cubit.pinController.text.isEmpty &&
                  _cubit.pinController.text == '') {
                setState(() {
                  isActive = false;
                  value = null;
                });
              }
             return;
            },
            // onClipboardFound: (value) {
            //   debugPrint('onClipboardFound: $value');
            //   pinController.setText(value);
            // },
            hapticFeedbackType: HapticFeedbackType.lightImpact,
            onCompleted: (pin) {
              setState(() {
                isActive = true;
              });
            },
            onChanged: (value) {
              debugPrint('onChanged: $value');
            },
            cursor: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 9),
                  width: 22,
                  height: 1,
                  color: focusedBorderColor,
                ),
              ],
            ),
            focusedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: focusedBorderColor),
              ),
            ),
            submittedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                color: fillColor,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: focusedBorderColor),
              ),
            ),
            errorPinTheme: defaultPinTheme.copyBorderWith(
              border: Border.all(color: Colors.redAccent),
            ),
          ),
        ),
        AppGap.sbH28,
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              style: AppStyles.text4017(color: AppColors.neutral700Color),
              children: [
                TextSpan(
                  text: '${AppStrings.of(context).hasOtp}\n',
                ),
                TextSpan(
                  text: AppStrings.of(context).resent,
                  style: AppStyles.text4017(color: AppColors.primary800Color),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _cubit.resendOtp();
                    },
                ),
                TextSpan(
                  text: AppStrings.of(context).orTryIt,
                ),
                TextSpan(
                  text: AppStrings.of(context).otherMethod,
                  style: AppStyles.text4017(color: AppColors.primary800Color),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ]),
        ),
        AppGap.sbH32,
        AppButton(
          enable: isActive,
          onPressed: () => _onTapVerifyOtp(context),
          text: AppStrings.of(context).next,
        ),
      ],
    );
  }
}
