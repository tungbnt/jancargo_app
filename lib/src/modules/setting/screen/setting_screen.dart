import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jancargo_app/src/domain/repositories/auth/delete-local-access-token.dart';
import 'package:jancargo_app/src/domain/services/dialog/dialog_service.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/general/utils/model_func_utils.dart';
import 'package:jancargo_app/src/modules/address/screen/address_list_screen.dart';
import 'package:jancargo_app/src/modules/auth/login/screens/login_screen.dart';
import 'package:jancargo_app/src/modules/payment_oders/bloc/payment_oders_cubit.dart';
import 'package:jancargo_app/src/modules/setting/bloc/setting_cubit.dart';
import 'package:jancargo_app/src/modules/web_view/screen/web_view.dart';
import 'package:jancargo_app/src/util/app_gap.dart';
import 'package:remixicon/remixicon.dart';

import '../../../components/resource/molecules/app_list_item_divider.dart';
import '../../personal/widget/group_option_item.dart';
import '../components/change_pass_screen.dart';
import '../components/information.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final SettingCubit _cubit = SettingCubit();

  @override
  void initState() {
    super.initState();
    _cubit.fetchSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: const Text(' Cài đặt'),
        elevation: 0,
        shadowColor: AppColors.primary200Color,
      ),
      backgroundColor: AppColors.neutral100Color,
      body: BlocBuilder<SettingCubit, SettingState>(
        bloc: _cubit,
        buildWhen: (prv, state) =>
            state is SettingLoading || state is SettingSuccess,
        builder: (context, state) {
          if (state is SettingLoading) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (state is SettingSuccess) {
            return Column(
              children: [
                Container(
                  color: AppColors.white,
                  margin: EdgeInsets.only(top: AppGap.h10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppGap.h10, horizontal: AppGap.w10),
                        child: Text(
                          'Tài khoản',
                          style: AppStyles.text6016(
                              color: AppColors.neutral800Color),
                        ),
                      ),
                      GroupOptionItem(
                        titleLangKey: 'Thông tin cá nhân',
                        trailingAction: true,
                        onTap: () =>
                            RouteService.routeGoOnePage(const Information()),
                      ),
                      const AppListItemDivider(),
                      GroupOptionItem(
                        titleLangKey: 'Đổi mật khẩu',
                        trailingAction: true,
                        onTap: () => RouteService.routeGoOnePage(ChangePass(
                          userId: state.sessionDto!.data!.id!,
                        )),
                      ),
                      const AppListItemDivider(),
                      GroupOptionItem(
                        titleLangKey: 'Địa chỉ',
                        trailingAction: true,
                        onTap: () {
                          RouteService.routeGoOnePage(AddressListScreen(
                            cubit: PaymentOdersCubit(),
                          ));
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  color: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppGap.h10, horizontal: AppGap.w10),
                        child: Text(
                          'Cài đặt',
                          style: AppStyles.text6016(
                              color: AppColors.neutral800Color),
                        ),
                      ),
                      GroupOptionItem(
                        titleLangKey: 'Cài đặt thông báo',
                        trailingAction: true,
                        onTap: () {},
                      ),
                      // const AppListItemDivider(),
                      // GroupOptionItem(
                      //   titleLangKey: 'Ngôn ngữ',
                      //   trailingAction: true,
                      //   onTap: () {},
                      // ),
                    ],
                  ),
                ),
                Container(
                  color: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppGap.h10, horizontal: AppGap.w10),
                        child: Text(
                          'Hỗ trợ',
                          style: AppStyles.text6016(
                              color: AppColors.neutral800Color),
                        ),
                      ),
                      GroupOptionItem(
                        titleLangKey: 'Người mới dùng',
                        trailingAction: true,
                        onTap: () async {
                          await RouteService.routeGoOnePage(const WebViewScreen(
                            url:
                                "https://m.jancargo.com/page/danh-cho-nguoi-dung-moi?view=app",
                            title: "Hướng dẫn",
                          ));
                        },
                      ),
                      const AppListItemDivider(),
                      GroupOptionItem(
                        titleLangKey: 'FAQ',
                        trailingAction: true,
                        onTap: () {},
                      ),
                      const AppListItemDivider(),
                      BlocListener<SettingCubit, SettingState>(
                        bloc: _cubit,
                        listenWhen: (prv, state) =>
                            state is SettingDeletedAccountLoading ||
                            state is SettingDeletedAccountSuccess,
                        listener: (context, state) async {
                          if (state is SettingDeletedAccountLoading) {
                            openDialogBox(
                              context,
                              const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.yellow800Color,
                                ),
                              ),
                            );
                          } else if (state is SettingDeletedAccountSuccess) {
                            if (state.deletedAccountDto!.success == true) {
                              await DeleteLocalAccessToken().delete();
                              await DialogService.showNotiBannerSuccess(context, 'Xoá tài khoản thành công!');
                              RouteService.routePushReplacementPage(
                                  const LoginScreen());
                            } else {
                              await DialogService.openDialog(
                                  DeletedAccountErrorDialog(
                                message: state.deletedAccountDto!.message!,
                              ));
                            }
                          }
                        },
                        child: GroupOptionItem(
                          titleLangKey: 'Yêu cầu huỷ tài khoản',
                          trailingAction: true,
                          onTap: () {
                            DialogService.openDialog(const DeletedAccountDialog())
                                .then((value) {
                              if (value) {
                                _cubit.deletedMyAccount();
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ].expand((e) => [e, AppGap.sbH10]).toList(),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class DeletedAccountDialog extends StatefulWidget {
  const DeletedAccountDialog({
    super.key,
  });

  @override
  State<DeletedAccountDialog> createState() => _DeletedAccountDialogState();
}

class _DeletedAccountDialogState extends State<DeletedAccountDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128.h,
      color: AppColors.white,
      margin: EdgeInsets.symmetric(
        horizontal: AppGap.w20,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppGap.w10,
      ),
      child: Column(
        children: [
          SvgPicture.asset(AppImages.icX),
          Text(
            'Bạn có chắc chắn muốn xoá tài khoản?',
            style: AppStyles.text6016(),
            softWrap: true,
          ),
          AppGap.sbH10,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildBtn('Không', AppColors.neutral800Color,
                  onTap: () => RouteService.pop()),
              AppGap.sbW8,
              _buildBtn('Chắc chắn', AppColors.primary300Color,
                  onTap: () => RouteService.popBackResult()),
            ],
          )
        ].expand((e) => [e, AppGap.sbH10]).toList(),
      ),
    );
  }

  Widget _buildBtn(String textBtn, Color color,
          {required void Function() onTap}) =>
      InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: AppGap.w5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(AppGap.r4),
            ),
            border: Border.all(color: color),
          ),
          child: Text(
            textBtn,
            style: AppStyles.text4014(color: color),
          ),
        ),
      );
}

class DeletedAccountErrorDialog extends StatefulWidget {
  const DeletedAccountErrorDialog({
    super.key,
    required this.message,
  });

  final String message;

  @override
  State<DeletedAccountErrorDialog> createState() =>
      _DeletedAccountErrorDialog();
}

class _DeletedAccountErrorDialog extends State<DeletedAccountErrorDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      color: AppColors.white,
      padding: EdgeInsets.symmetric(
        horizontal: AppGap.w20,
      ),
      child: Column(
        children: [
          AppGap.sbH20,
          SvgPicture.asset(AppImages.icX),
          Text(
            widget.message,
            style: AppStyles.text4012(),
            softWrap: true,
          ),
          SizedBox(
            width: 100.w,
            child: _buildBtn('Đã hiểu', AppColors.primary300Color,
                onTap: () => RouteService.popBackResult()),
          ),
        ].expand((e) => [e, AppGap.sbH10]).toList(),
      ),
    );
  }

  Widget _buildBtn(String textBtn, Color color,
          {required void Function() onTap}) =>
      InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: AppGap.w5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(AppGap.r4),
            ),
            border: Border.all(color: color),
          ),
          child: Text(
            textBtn,
            style: AppStyles.text4014(color: color),
          ),
        ),
      );
}
