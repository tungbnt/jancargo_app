import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/auth/login/screens/login_screen.dart';

import '../../../../components/resource/molecules/app_loading.dart';
import '../../../../domain/services/dialog/dialog_service.dart';
import '../../../../general/inject_dependencies/inject_dependencies.dart';
import '../bloc/forget_pass_cubit.dart';
import '../components/input_field_page.dart';
import '../components/input_otp_page.dart';
import '../components/inutNewPassPage.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  ForgetPassCubit get _cubit => getIt<ForgetPassCubit>();
  int _currentPage = 0;
  bool resetValidation = true;

  @override
  void dispose() {
    _cubit.inputEmail.clear();
    super.dispose();
  }

  void _nextPage() {
    _cubit.pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: InkWell(
          highlightColor: Colors.transparent,
          onTap: () => RouteService.pop(),
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.black03,
          ),
        ),
        title: Text(
          AppStrings.of(context).forget,
          style: AppStyles.text6024(),
        ),
        centerTitle: true,
      ),
      body: BlocListener<ForgetPassCubit, ForgetPassState>(
        bloc: _cubit,
        listener: (contextt, state) async {
          if (state is ForgetPassLoading) {
            resetValidation = false;
            return AppLoading.openSpinkit(context);
          } else if (state is ForgetPassSuccess) {
            await RouteService.pop();
            _nextPage();
          }  else if (state is ForgetPassResendOtpSuccess) {
            await RouteService.pop();
            resetValidation = true;
            _cubit.pinController.clear();
            setState(() {});
          }else if (state is ForgetPassVerifyOtpSuccess) {
            await RouteService.pop();
            _nextPage();
          }else if (state is ForgetPassFailed) {
            await RouteService.pop();

          }else if (state is ForgetPassSuccessPassOtpSuccess) {
            await RouteService.pop();
             DialogService.showNotiBannerSuccess(context, 'Bạn đã đổi mật khẩu thành công!');
            RouteService.routePushReplacementPage(LoginScreen());
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _cubit.pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              InputFieldPage(cubit: _cubit),
              InputOtpPage(cubit: _cubit, resetValidation: resetValidation),
              InputNewPassPage(cubit: _cubit)
            ],
          ),
        ),
      ),
    );
  }
}
