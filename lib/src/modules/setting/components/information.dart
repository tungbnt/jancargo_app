import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/modules/setting/bloc/setting_cubit.dart';

import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../components/resource/molecules/app_list_item_divider.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/app_strings/app_strings.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_gap.dart';
import '../../personal/widget/group_option_item.dart';

class Information extends StatefulWidget {
  const Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  final SettingCubit _cubit = SettingCubit();

  @override
  void initState() {
    super.initState();
    _cubit.fetchSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral200Color,
      extendBody: true,
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: AppColors.white,
        centerTitle: true,
        leading: InkWell(
          highlightColor: Colors.transparent,
          onTap: () => RouteService.pop(),
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.black03,
          ),
        ),
        title: Text(
          "Thông tin cá nhân",
          style: AppStyles.text7018(),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<SettingCubit, SettingState>(
          bloc: _cubit,
          buildWhen: (prv,state)=> state is SettingLoading || state is SettingSuccess,
          builder: (context, state) {
            if (state is SettingLoading) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height ,
                child: const Center(
                  child: CupertinoActivityIndicator(),
                ),
              );
            }
            if(state is SettingSuccess){
              return Column(
                children: [
                  Stack(
                    children: [
                      Opacity(
                        opacity: 0.8,
                        child: Container(
                          width: double.infinity,
                          height: AppGap.h136,
                          color: AppColors.primary600Color,
                          child: AppCarouselImages(
                            fit: BoxFit.fitWidth,
                            height: AppGap.h136,
                            // ignore: invalid_use_of_protected_member
                            imagesUrl:  [state.sessionDto?.data?.avatar ?? ""],
                            alignment: Alignment.topCenter,
                            borderRadius: BorderRadius.zero,
                            autoPlay: false,
                            showIndicatorBottom: false,
                            imageDecoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        bottom: 10,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () =>
                                  RouteService.routeGoOnePage(Information()),
                              child: Container(
                                width: AppGap.w64,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.greenColor,
                                ),
                                child: AppCarouselImages(
                                  fit: BoxFit.fill,
                                  height: AppGap.h64,
                                  // ignore: invalid_use_of_protected_member
                                  imagesUrl:  [state.sessionDto?.data?.avatar ?? ""],
                                  alignment: Alignment.topCenter,
                                  borderRadius: BorderRadius.circular(100),
                                  autoPlay: false,
                                  showIndicatorBottom: false,
                                  imageDecoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(100),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            AppGap.sbW8,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(state.sessionDto?.data?.name ?? '',style: AppStyles.text6016(color: AppColors.white),),
                                Text(state.sessionDto!.data!.shortName!,style: AppStyles.text4014(color: AppColors.neutral700Color),),
                                Container(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: AppGap.w5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(AppGap.r15),
                                      ),
                                      color: AppColors.primary50Color),
                                  child: Text('Thành viên bạc'),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    color: AppColors.white,
                    margin: EdgeInsets.only(top: AppGap.h10),
                    child: Column(
                      children: [
                        _line('Tên tài khoản', state.sessionDto!.data!.name!),
                        _line('Nick name', state.sessionDto!.data!.shortName!),
                        _line('Ngày sinh', state.sessionDto!.data!.birthdate ?? "Chưa cập nhật"),
                        _line('Số điện thoại', state.sessionDto!.data!.phone!),
                        _line('Email', state.sessionDto!.data!.email!),
                        _line('Giới tính', state.sessionDto!.data!.gender == "M" ? "Name" : "Nữ", isShow: false),
                      ],
                    ),
                  )
                ],
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _line(String title, String value, {bool isShow = true}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: AppGap.w10, top: AppGap.h10),
            child: Text(title),
          ),
          GroupOptionItem(
            titleLangKey: value,
            onTap: () {},
          ),
          isShow ? AppListItemDivider() : AppGap.sbH10,
        ],
      );
}
