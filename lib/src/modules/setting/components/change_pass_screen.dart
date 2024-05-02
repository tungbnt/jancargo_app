import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jancargo_app/src/domain/services/dialog/dialog_service.dart';
import 'package:jancargo_app/src/domain/services/utils/validation.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../components/resource/molecules/app_button.dart';
import '../../../components/resource/molecules/app_loading.dart';
import '../../../components/resource/molecules/input.dart';
import '../../../general/app_strings/app_strings.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/utils/model_func_utils.dart';
import '../bloc/setting_cubit.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({super.key, required this.userId});
  final String userId;
  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  final SettingCubit _cubit = SettingCubit();
  bool isActive = false;

  void _onTap(BuildContext context) {
    if (_cubit.formKey.currentState!.validate()) {
      _cubit.changePass(widget.userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: const Text('Đổi mật khẩu'),
        elevation: 0,
      ),
      backgroundColor: AppColors.neutral200Color,
      body: SingleChildScrollView(
        child: Form(
          key: _cubit.formKey,
          child: Container(
            color: AppColors.white,
            margin: EdgeInsets.symmetric(vertical: AppGap.h10),
            child: Column(
              children: [
                _textFiled(
                    (value) {
                      return Validation.validatorPass(value);
                    },
                    'Mật khẩu cũ',
                    'Nhập mật khẩu cũ',
                    _cubit.oldPass,
                    (value) {

                    }),
                _textFiled((value) {
                  return Validation.validatorPass(value);
                }, 'Mật khẩu mới', 'Nhập mật khẩu mới', _cubit.newPass,
                    (value) {}),
                _textFiled((value) {
                  return Validation.validatorPassAgain(
                      value, _cubit.newPass.text);
                }, 'Nhập lại mật khẩu', 'Nhập lại mật khẩu',
                    _cubit.newAgainPass, (value) {
                      setState(() {
                        if (_cubit.oldPass.text.isNotEmpty &&
                            _cubit.newPass.text.isNotEmpty) {
                          isActive = true;
                        }
                      });
                    }),
                BlocListener<SettingCubit, SettingState>(
                  bloc: _cubit,
                  listener: (context, state) async {
                    if (state is SettingLoading) {
                     await openDialogBox(
                          context,
                          const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.yellow800Color,
                            ),
                          ),
                          isBarrierDismissible: true);
                    } else if (state is SettingSuccess) {
                      AppLoading.hideLoading();
                      DialogService.showNotiBannerInfo(
                          context, 'Đổi mật khẩu thành công');
                    } else if (state is SettingFailChangSuccess) {
                      AppLoading.hideLoading();
                      DialogService.showNotiBannerInfo(
                          context, 'Đổi mật khẩu không thành công');
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppGap.w10, vertical: AppGap.h20),
                    child: AppButton(
                        enable: isActive,
                        onPressed: () => _onTap(context),
                        text: 'Thay đổi'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFiled(
    String? Function(String?)? validator,
    String text,
    String hint,
    TextEditingController? controller,
    dynamic Function(String)? onChange,
  ) =>
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: AppGap.w10, vertical: AppGap.h10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: AppStyles.text4014(color: AppColors.neutral800Color),
            ),
            AppGap.sbH10,
            AppInput(
              isObscure: true,
              maxLine: 1,
              placeholder: hint,
              controller: controller,
              validator: validator,
              onChange: onChange,
            ),
          ],
        ),
      );
}
