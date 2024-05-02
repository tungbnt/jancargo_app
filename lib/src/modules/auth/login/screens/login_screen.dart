import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jancargo_app/src/components/resource/molecules/app_button.dart';
import 'package:jancargo_app/src/components/resource/molecules/input.dart';
import 'package:jancargo_app/src/domain/services/dialog/dialog_service.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/auth/login/bloc/login_cubit.dart';
import 'package:jancargo_app/src/modules/auth/login/widget/line_with_Text.dart';
import 'package:jancargo_app/src/modules/auth/login/widget/not_account_widget.dart';
import 'package:jancargo_app/src/modules/dashboard/screens/dashboard_screen.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../../domain/services/utils/validation.dart';
import '../../../../general/inject_dependencies/inject_dependencies.dart';
import '../../../../general/utils/model_func_utils.dart';
import '../../forget_pass/screen/forget_pass_screen.dart';
import '../bloc/auth_google/auth_google_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.isLoginBack});
  final bool? isLoginBack;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginCubit get _cubit => getIt<LoginCubit>();

  final AuthGoogleCubit  _cubitGoogle = AuthGoogleCubit();

  bool isActive = false;

  @override
  void initState() {
    super.initState();
  }

  //function login
  void _onTapLogin(BuildContext context) {
    if (_cubit.formKey.currentState!.validate()) {
      _cubit.login();
    }
  }

  void _onTapLoginByGoogle(BuildContext context) {
    _cubitGoogle.login();
  }

  void _onTapLoginByFacebook(BuildContext context) {}

  @override
  void dispose() {
    super.dispose();
    _cubit.inputEmail.clear();
    _cubit.inputPass.clear();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: GestureDetector(
        onTap: () {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: height,
              width: width,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppGap.d10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    logo(),
                    inputLogin(),
                    btnLogin(context),
                    lineWithText(),
                    otherLogin(context),
                    AppGap.sbH20,
                    _skipLogin(),
                    const Spacer(),
                    const NotAccount(),
                    AppGap.sbH10,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget logo() => Column(
        children: [
          AppGap.sbH105,
          SvgPicture.asset(AppImages.logoLogin),
        ],
      );

  Widget inputLogin() => Form(
        key: _cubit.formKey,
        child: Column(
          children: [
            AppGap.sbH48,
            AppInput(
              placeholder: AppStrings.of(context).hintAccount,
              controller: _cubit.inputEmail,
              maxLine: 1,
              validator: (value) {
                late final RegExp numberRegex = RegExp(r'\d+');
                if (value!.contains(numberRegex) == false) {
                  return Validation.validatorPhone(value);
                }
                if (!value.contains(numberRegex)) {
                  return Validation.validateEmail(email: value);
                }
                return null;
              },
              onChange: (value) {
                if (_cubit.inputEmail.text.isEmpty) {
                  isActive = false;
                } else {
                  isActive = true;
                }
                setState(() {});
              },
            ),
            AppGap.sbH24,
            AppInput(
              maxLine: 1,
              placeholder: AppStrings.of(context).hintPass,
              controller: _cubit.inputPass,
              isObscure: true,
              isPassword: true,
              validator: (value) {
                return Validation.validatorPass(value);
              },
            ),
            AppGap.sbH10,
            InkWell(
              onTap: () =>
                  RouteService.routeGoOnePage(const ForgetPassScreen()),
              child: SizedBox(
                height: AppGap.d20,
                child: Row(
                  children: [
                    Text(AppStrings.of(context).textForgetPass),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget btnLogin(BuildContext context) => BlocConsumer<LoginCubit, LoginState>(
        bloc: _cubit,
        listenWhen: (prv, state) =>
            state is LoginLoading ||
            state is LoginSuccess ||
            state is LoginFailed,
        listener: (contextt, state) async {
          if (state is LoginLoading) {
            openDialogBox(
                context,
                const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.yellow800Color,
                  ),
                ),
                isBarrierDismissible: true);
          }
          if (state is LoginSuccess) {
            await RouteService.pop();
            if(widget.isLoginBack != null){
              return RouteService.popBackResult();
            }
            RouteService.routePushReplacementPage(const DashboardView());
          } else if (state is LoginFailed) {
            RouteService.pop();
            DialogService.showNotiBannerInfo(context, 'Lỗi đăng nhập,thử lại!');
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              AppGap.sbH28,
              AppButton(
                  enable: isActive,
                  onPressed: () => _onTapLogin(context),
                  text: AppStrings.of(context).login),
              AppGap.sbH32,
            ],
          );
        },
      );

  Widget lineWithText() => Column(
        children: [
          const LineWithText(),
          AppGap.sbH32,
        ],
      );

  Widget otherLogin(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BlocListener<AuthGoogleCubit, AuthGoogleState>(
            bloc: _cubitGoogle,
            listener: (context, state) {
              if (state is AuthGoogleLoading) {
                openDialogBox(
                    context,
                    const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.yellow800Color,
                      ),
                    ),
                    isBarrierDismissible: true);
              } else if (state is AuthGoogleSuccess) {
                RouteService.pop();
                RouteService.pop();
                DialogService.showNotiBannerSuccess(
                    context, 'Đăng nhập thành công!');
                RouteService.routePushReplacementPage(const DashboardView());
              } else if (state is AuthGoogleFailed) {
                RouteService.pop();
                DialogService.showNotiBannerSuccess(context, state.message!);
              }
            },
            child: AppButton(
              onPressed: () => _onTapLoginByGoogle(context),
              text: AppStrings.of(context).login,
              icon: AppImages.icGoogle,
              color: AppColors.white,
              textSize: 14,
              borderColor: AppColors.neutral300Color,
              textColor: AppColors.neutral900Color,
              width: AppGap.w163,
              radius: AppGap.r15,
            ),
          ),
          AppGap.sbW8,
          AppButton(
            onPressed: () => _onTapLoginByFacebook(context),
            text: AppStrings.of(context).login,
            textSize: 14.sp,
            icon: AppImages.icFb,
            color: AppColors.white,
            borderColor: AppColors.neutral300Color,
            textColor: AppColors.neutral900Color,
            width: AppGap.w163,
            radius: AppGap.r15,
          ),
        ],
      );

  Widget _skipLogin()=>   InkWell(
    onTap: ()=>RouteService.routePushReplacementPage(const DashboardView()),
    child: SizedBox(
      child: Text(
        'Bỏ qua đăng nhập',
        style: AppStyles.text5016(
            color: AppColors.neutral300Color),
      ),
    ),
  );
}
