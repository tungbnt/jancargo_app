import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jancargo_app/src/components/resource/molecules/input.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/auth/login/screens/login_screen.dart';
import 'package:jancargo_app/src/modules/auth/sign_up/bloc/sign_u_cubit.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../../components/resource/molecules/app_button.dart';
import '../../../../domain/services/utils/validation.dart';
import '../../../../general/app_strings/app_strings.dart';
import '../../../../general/constants/app_images.dart';
import '../../../../general/inject_dependencies/inject_dependencies.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  SignUpCubit get _cubit => getIt<SignUpCubit>();

  bool isActive = false;

  //function login
  void _onTapRegister(BuildContext context) {
    if (_cubit.formKey.currentState!.validate()) {
      // _cubit.login();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cubit.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _logo(),
            _fieldRegister(),
            _buildCheckbox(),
            _btnRegister(),
            _spacer(),
            _containerRules(),
            _containerAccount(),
          ],
        ),
      ),
    );
  }

  Widget _spacer() => AppGap.sbH40;

  Widget _logo() => Column(
        children: [
          AppGap.sbH48,
          SvgPicture.asset(AppImages.logoLogin),
        ],
      );

  Widget _fieldRegister() => Form(
        key: _cubit.formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              SizedBox(
                height: 15.h,
              ),
              AppInput(
                placeholder: AppStrings.of(context).hintName,
                controller: _cubit.inputName,
                maxLine: 1,
                validator: (value) {
                  return Validation.validateName(value!);
                },
                onChange: (value) {},
              ),
              AppInput(
                placeholder: AppStrings.of(context).hintPhone,
                controller: _cubit.inputPhone,
                maxLine: 1,
                validator: (value) {
                  return Validation.validatorPhone(value);
                },
                onChange: (value) {},
              ),
              AppInput(
                placeholder: AppStrings.of(context).hintEmail,
                controller: _cubit.inputEmail,
                maxLine: 1,
                validator: (value) {
                  return Validation.validateEmail(email: value);
                },
                onChange: (value) {},
              ),
              AppInput(
                placeholder: AppStrings.of(context).hintPass,
                controller: _cubit.inputPass,
                maxLine: 1,
                validator: (value) {
                  return Validation.validatorPass(value);
                },
                onChange: (value) {},
              ),
              AppInput(
                placeholder: AppStrings.of(context).hintPassAgain,
                controller: _cubit.inputPassAgain,
                maxLine: 1,
                validator: (value) {
                  return Validation.validatorPassAgain(
                      _cubit.inputPassAgain.text, _cubit.inputPass.text);
                },
                onChange: (value) {},
              ),
            ]
                .expand((e) => [
                      e,
                      SizedBox(
                        height: 15.h,
                      )
                    ])
                .toList(),
          ),
        ),
      );

  Widget _btnRegister() => Padding(
        padding: EdgeInsets.all(AppGap.d15),
        child: Column(
          children: [
            AppButton(
                enable: isActive,
                onPressed: () => _onTapRegister(context),
                text: AppStrings.of(context).signup),
            AppGap.sbH32,
          ],
        ),
      );

  Widget _buildCheckbox() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,

        // textBaseline: TextBaseline.values[],
        children: [
          SizedBox(
            width: 18.w,
            height: 18.h,
            child: Checkbox(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r)),
              side:
                  const BorderSide(color: AppColors.neutral300Color, width: 2),
              activeColor: AppColors.yellow700Color,
              value: isActive,
              onChanged: ((value) {
                setState(() {
                  isActive = !isActive;
                });
              }),
            ),
          ),
          Expanded(
            flex: 1,
            child: Baseline(
              baseline: 13.h,
              baselineType: TextBaseline.alphabetic,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: AppStyles.text4014(color: AppColors.black03),
                    children: [
                      TextSpan(text: " ${AppStrings.of(context).iAgree} "),
                      TextSpan(
                          text: AppStrings.of(context).privacyPolicy,
                          recognizer: TapGestureRecognizer()..onTap = () {},
                          style: AppStyles.text4014(
                              color: AppColors.yellow800Color)),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _containerRules() => Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: AppStyles.text4012(color: AppColors.neutral400Color),
                children: [
                   TextSpan(
                      text: "${AppStrings.of(context).youAgree}\n "),
                  TextSpan(
                    text: AppStrings.of(context).termsOfService,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => RouteService.routePushReplacementPage(
                            const LoginScreen(),
                          ),
                    style: AppStyles.text4012(color: AppColors.black03),
                  ),
                  const TextSpan(text: " & "),
                  TextSpan(
                    text: '${AppStrings.of(context).privacyPolicyOf} ',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => RouteService.routePushReplacementPage(
                            const LoginScreen(),
                          ),
                    style: AppStyles.text4012(color: AppColors.black03),
                  ),
                  const TextSpan(text: "Jancargo"),
                ]),
          ),
        ],
      );

  Widget _containerAccount() => Container(
        height: 55.h,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        margin: EdgeInsets.only(top: 10.h),
        color: AppColors.neutral100Color,
        child: Column(
          children: [
            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                  style: AppStyles.text4014(color: AppColors.neutral400Color),
                  children: [
                    const TextSpan(text: "Bạn đã có tài khoản? "),
                    TextSpan(
                        text: AppStrings.of(context).login,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => RouteService.routePushReplacementPage(
                              const LoginScreen()),
                        style: AppStyles.text4014(
                            color: AppColors.yellow800Color)),
                  ]),
            ),
          ],
        ),
      );
}
