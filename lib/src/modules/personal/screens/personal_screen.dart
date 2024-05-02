import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/auth/login/screens/login_screen.dart';
import 'package:jancargo_app/src/modules/cart/screens/cart_screens.dart';
import 'package:jancargo_app/src/modules/coupon/screen/coupon_screen.dart';
import 'package:jancargo_app/src/modules/favorite/screen/favorite_screens.dart';
import 'package:jancargo_app/src/modules/personal/bloc/personal/personal_cubit.dart';
import 'package:jancargo_app/src/modules/personal/components/grid_com.dart';
import 'package:jancargo_app/src/modules/personal/screens/recently_viewed/recently_viewed_screen.dart';
import 'package:jancargo_app/src/modules/web_view/screen/web_view.dart';
import 'package:remixicon/remixicon.dart';

import '../../../components/resource/molecules/app_list_item_divider.dart';
import '../../../components/resource/molecules/cached_network_shaped_image.dart';
import '../../../domain/repositories/auth/delete-local-access-token.dart';
import '../../../util/app_gap.dart';
import '../../oder_management/screens/oder_management_screen.dart';
import '../../setting/components/information.dart';
import '../../setting/screen/setting_screen.dart';
import '../components/oder_status.dart';
import '../widget/custom_container_personal.dart';
import '../widget/custom_surplus.dart';
import '../widget/group_option_item.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  final PersonalCubit _cubit = PersonalCubit();

  @override
  void initState() {
    super.initState();
    _cubit.initEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.neutral100Color,
        body: BlocBuilder<PersonalCubit, PersonalState>(
            bloc: _cubit,
            buildWhen: (prv, state) =>
                state is PersonalLoading || state is PersonalDataSuccess,
            builder: (context, state) {
              return switch (state) {
                PersonalLoading() => SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  ),
                PersonalDataSuccess() => SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: AppGap.h194,
                          child: Stack(children: [
                            const CustomContainerPersonal(),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: _info(),
                            )
                          ]),
                        ),
                        _managementOder(),
                        _gridContainer(),
                        _fot(),
                      ],
                    ),
                  ),
                _ => const SizedBox.shrink()
              };
            }));
  }

  Widget _info() => BlocBuilder<PersonalCubit, PersonalState>(
        bloc: _cubit,
        buildWhen: (prv, state) => state is SessionPersonalSuccess,
        builder: (context, state) {
          if (state is SessionPersonalSuccess) {
            return Stack(
              children: [
                Container(
                  height: AppGap.h144,
                  margin: EdgeInsets.only(left: AppGap.w10, right: AppGap.w10),
                  padding: EdgeInsets.symmetric(
                      horizontal: AppGap.w10, vertical: AppGap.h10),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppGap.r15),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () => RouteService.routeGoOnePage(
                                const Information()),
                            child: Container(
                              margin:
                                  EdgeInsets.symmetric(horizontal: AppGap.w10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(AppGap.r100)),
                                child: CachedNetworkRectangleImage(
                                  width: 64,
                                  height: 64,
                                  imageDecoration: const BoxDecoration(
                                      shape: BoxShape.circle),
                                  imageUrl:
                                      state.sessionDto!.data!.avatar ?? "",
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                  errorWidget: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.neutral200Color),
                                        shape: BoxShape.circle),
                                    child: SvgPicture.asset(
                                      AppImages.icX,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(state.sessionDto!.data!.fullName!),
                              Text('ID: ${state.sessionDto!.data!.customerNo}'),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppGap.w10),
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(colors: [
                                      AppColors.white,
                                      AppColors.neutral400Color
                                    ]),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(AppGap.r15),
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: AppColors.neutral200Color,
                                        blurRadius: 0,
                                        offset: Offset(3, 4),
                                        spreadRadius: 1,
                                      )
                                    ]),
                                child: Row(
                                  children: [
                                    const Text('Thành viên bạc'),
                                    SvgPicture.asset(
                                      AppImages.icArrowight,
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      AppGap.sbH10,
                      CustomSurplus(
                        number: state.sessionDto!.data!.wallet!.balance!,
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 10,
                    child: IconButton(
                        onPressed: () =>
                            RouteService.routeGoOnePage(const SettingScreen()),
                        icon: SvgPicture.asset(AppImages.icSettingInfo)))
              ],
            );
          }
          return const SizedBox.shrink();
        },
      );

  Widget _managementOder() => BlocBuilder<PersonalCubit, PersonalState>(
        bloc: _cubit,
        buildWhen: (prv, state) => state is OderPersonalSuccess,
        builder: (context, state) {
          if (state is OderPersonalSuccess) {
            return Container(
              color: AppColors.white,
              padding: EdgeInsets.symmetric(
                  horizontal: AppGap.w10, vertical: AppGap.h10),
              margin: EdgeInsets.symmetric(vertical: AppGap.h10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Quản lý đơn hàng',
                        style: AppStyles.text6014(
                            color: AppColors.neutral800Color),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () =>
                            RouteService.routeGoOnePage(const OderManagement()),
                        child: Row(
                          children: [
                            Text(
                              'Xem thêm',
                              style: AppStyles.text4014(
                                  color: AppColors.primary500Color),
                            ),
                            SvgPicture.asset(
                              AppImages.icArrowight,
                              color: AppColors.primary600Color,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  AppGap.sbH5,
                  OrderStates(dto: state.dtoManager!.options),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      );

  Widget _fot() {
    Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
    String isToken = hiveBox.get(AppConstants.ACCESS_TOKEN);
    return Column(
        children: [
          GroupOptionItem(
            titleLangKey: 'Đấu giá VIP',
            icon: SvgPicture.asset(AppImages.icVip),
            onTap: () async{

              await RouteService.routeGoOnePage(WebViewScreen(url: "https://m.jancargo.com/redirect?access_token=$isToken&next=/account/vip?view=app",title: "Đấu giá VIP",callback: ()async{
                 print('có vào không');
                await RouteService.routeGoOnePage(WebViewScreen(url: "https://m.jancargo.com/redirect?access_token=$isToken&next=/account/wallet/billing?view=app",title: "Nạp tiền",));

              },));
            },
            trailingAction: true,
          ),
          const AppListItemDivider(),
          GroupOptionItem(
            titleLangKey: 'Giỏ hàng',
            icon: SvgPicture.asset(AppImages.icBasket),
            trailingAction: true,
            onTap: () => RouteService.routeGoOnePage(const CartScreen()),
          ),
          const AppListItemDivider(),
          GroupOptionItem(
            titleLangKey: 'Đã xem gần đây',
            icon: SvgPicture.asset(AppImages.icClock),
            trailingAction: true,
            onTap: () =>
                RouteService.routeGoOnePage(const RecentlyViewedScreen()),
          ),
          const AppListItemDivider(),
          GroupOptionItem(
            titleLangKey: 'Cửa hàng yêu thích',
            icon: SvgPicture.asset(AppImages.icShop),
            trailingAction: true,
            onTap: () => RouteService.routeGoOnePage(const FavoriteScreen()),
          ),
          const AppListItemDivider(),
          GroupOptionItem(
            titleLangKey: 'Voucher',
            icon: SvgPicture.asset(AppImages.icTicket),
            trailingAction: true,
            onTap: () {
              RouteService.routeGoOnePage(const CouponScreen());
            },
          ),
          const AppListItemDivider(),
          GroupOptionItem(
            titleLangKey: 'Khiếu nại / góp ý',
            trailingAction: true,
            iconData: Remix.time_line,
            onTap: () {},
          ),
          const AppListItemDivider(),
          GroupOptionItem(
            titleLangKey: 'Người dùng lần đầu',
            onTap: () async{
              await RouteService.routeGoOnePage(const WebViewScreen(url: "https://m.jancargo.com/page/danh-cho-nguoi-dung-moi?view=app",title: "Hướng dẫn",));
            },
          ),
          const AppListItemDivider(),
          GroupOptionItem(
            titleLangKey: 'FAQ',
            onTap: () async{
              await RouteService.routeGoOnePage(const WebViewScreen(url: "https://m.jancargo.com/page/danh-cho-nguoi-dung-moi?view=app",title: "FAQ",));
            },
          ),
          const AppListItemDivider(),
          GroupOptionItem(
            titleLangKey: 'Biểu Phí',
            onTap: () async{
              await RouteService.routeGoOnePage(const WebViewScreen(url: "https://m.jancargo.com/page/bieu-phi?view=app",title: "Biểu Phí",));
            },
          ),
          const AppListItemDivider(),
          GroupOptionItem(
            titleLangKey: 'Liên hệ và góp ý',
            onTap: () {},
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppGap.h10),
            child: GroupOptionItem(
              titleLangKey: 'Đăng xuất',
              icon: SvgPicture.asset(AppImages.icLogout),
              onTap: () async {
                await DeleteLocalAccessToken().delete();
                RouteService.routePushReplacementPage(const LoginScreen());
              },
            ),
          ),
        ],
      );
  }

  Widget _gridContainer() => Container(
      height: AppGap.h144,
      padding: EdgeInsets.only(left: AppGap.w5, bottom: AppGap.h10),
      alignment: Alignment.center,
      child: const GridCom());
}
