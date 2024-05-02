import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:jancargo_app/src/data/object_request_api/auction/price_auction/price_auction_request.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/modules/dashboard/screens/dashboard_screen.dart';
import 'package:jancargo_app/src/modules/oder_management/screens/oder_management_screen.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../components/resource/molecules/app_button.dart';
import '../../../domain/dtos/detail_product/detail/detail_dto.dart';
import '../../../domain/dtos/info_product/info_product_dto.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/app_strings/app_strings.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_constants.dart';
import '../../../general/constants/app_styles.dart';
import '../../auction/screens/auction_screen.dart';
import '../../auction_now/screen/now_auction_screen.dart';
import '../../auth/login/screens/login_screen.dart';
import '../../cart/screens/cart_screens.dart';
import '../../last_minute_hunting/screen/last_minute_hunting.dart';
import '../bloc/detail_product_cubit.dart';

class ScaffoldCustom extends StatefulWidget {
  const ScaffoldCustom(
      {super.key,
      required this.body,
      required this.cubit,
      this.bottomNav,
      this.cartKey,
      this.onPressed, required this.numberItemCart});

  final Widget body;
  final Widget? bottomNav;
  final DetailProductCubit cubit;
  final void Function()? onPressed;
  final GlobalKey<CartIconKey>? cartKey;
  final ValueNotifier<int> numberItemCart;

  @override
  State<ScaffoldCustom> createState() => _ScaffoldCustomState();
}

class _ScaffoldCustomState extends State<ScaffoldCustom> {
  Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
  late String? token;

  // kiểm tra có add product vào giỏ hàng
  int isAddCart = 0;

  @override
  void initState() {
    super.initState();
    token = hiveBox.get(AppConstants.ACCESS_TOKEN);
    isAddCart = widget.numberItemCart.value;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.neutral200Color,
      extendBody: true,
      appBar: AppBar(
          bottomOpacity: 0.0,
          leading: null,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.white,
          title: Row(
            children: [
              InkWell(
                highlightColor: Colors.transparent,
                onTap: () => Navigator.pop(context,isAddCart == widget.numberItemCart.value ? false : true ),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.black03,
                ),
              ),
              Text(
                AppStrings.of(context).productDetails,
                style: AppStyles.text7018(),
                overflow: TextOverflow.clip,
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: widget.onPressed,
              icon: SvgPicture.asset(AppImages.icRefresh),
            ),
            AddToCartIcon(

              key: widget.cartKey ?? GlobalKey<CartIconKey>(),
              icon: SizedBox(
                width: 30.w,
                child: GestureDetector(
                    onTap: () => RouteService.routeGoOnePage(const CartScreen()),
                    child: Stack(children: [SvgPicture.asset(AppImages.icCartItem),
                      Positioned(
                        top: -1.h,
                        right: 0,
                        child: ValueListenableBuilder(
                          valueListenable: widget.numberItemCart,
                          builder: (context,value,__) {
                            return Container(
                              width: 14.w,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primary800Color
                              ),
                              child: Text(value.toString(),style: AppStyles.text4012(color: AppColors.white),),
                            );
                          }
                        ),
                      )
                    ]),),
              ),
              badgeOptions: const BadgeOptions(
                active: false,
                backgroundColor: Colors.red,

              ),
            ),
            PopupMenuButton<String>(
              color: AppColors.white,
              onSelected: (value) {
                // Handle menu item selection
                print('Selected: $value');
                if(value == "1"){
                  RouteService.routeGoOnePage(const DashboardView());
                }else if(value == "2"){
                  RouteService.routeGoOnePage(const OderManagement());
                }else{
                  RouteService.routeGoOnePage(const DashboardView(indexTabView: 4,));
                }
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'item1',
                    child: _popup(AppImages.icHomeSmall, ' Trở về trang chủ'),
                  ),
                  PopupMenuItem(
                    value: 'item2',
                    child: _popup(AppImages.icOderManager, ' Đơn hàng của tôi'),
                  ),
                  PopupMenuItem(
                    value: 'item3',
                    child: _popup(AppImages.icProfile, ' Cá nhân'),
                  ),
                  // Add more menu items as needed
                ];
              },
            ),
          ]),
      body: widget.body,
      bottomNavigationBar: widget.bottomNav ??
          BlocBuilder<DetailProductCubit, DetailProductState>(
            bloc: widget.cubit,
            buildWhen: (prv, state) => state.runtimeType == DataDetailsSuccess,
            builder: (context, state) {
              if (state is DataDetailsSuccess) {
                return SizedBox(
                  height: AppGap.h50,
                  child: state.detailDto!.methods!.buy! &&
                          state.detailDto!.methods!.bid == false
                      ? _onlyBuy(state.detailDto!)
                      : (state.detailDto!.methods!.buy! &&
                              state.detailDto!.methods!.bid!
                          ? _btnAll(state.detailDto!, width: width)
                          : _btnNoBuy(state.detailDto!, width: width)),
                );
              }
              return const SizedBox.shrink();
            },
          ),
    );
  }

  Widget _onlyBuy(
    DetailDto? detailDto,
  ) {
    var data = detailDto!;
    return _btn(
      () async {
        if (token == null || token == "") {
          await RouteService.routeGoOnePage(const LoginScreen(
            isLoginBack: true,
          ));
        }
        RouteService.routeGoOnePage(
          NowAuctionScreen(
            request: PriceRequest(
              items: [
                PriceAuctionRequest(
                    qty: data.qty!, tax: data.tax, price: data.price)
              ],
            ),
            dto: InfoProductDto(
              code: data.code!,
              name: data.name!,
              url: data.url!,
              thumbnails: data.thumbnails,
              price: data.price,
              tax: data.tax,
              qty: data.qty,
              condition: data.condition,
              percent: data.sellerDto!.percent,
            ),
          ),
        );
      },
     Text('Mua ngay',style: AppStyles.text6016(color: AppColors.neutral800Color),),
      AppColors.yellow800Color,
    );
  }

  Widget _btnAll(DetailDto? detailDto, {double width = 0}) {
    var data = detailDto!;
    return Row(
      children: [
        SizedBox(
          width: width / 2,
          child: Row(
            children: [
              _btn(() async {
                if (token == null || token == "") {
                  await RouteService.routeGoOnePage(const LoginScreen(
                    isLoginBack: true,
                  ));
                }
                RouteService.routeGoOnePage(
                  LastMinuteHuntingScreen(
                    request: PriceRequest(
                      items: [
                        PriceAuctionRequest(
                            qty: data.qty!, tax: 0, price: data.price)
                      ],
                    ),
                    dto: InfoProductDto(
                      code: data.code!,
                      name: data.name!,
                      url: data.url!,
                      thumbnails: data.thumbnails,
                      price: data.price,
                      tax: 0,
                      qty: data.qty,
                      condition: data.condition,
                      sellerId: data.sellerDto!.id,
                      percent: data.sellerDto!.percent,
                    ),
                  ),
                );
              }, SvgPicture.asset(AppImages.icLastMinus), AppColors.white,
                  width: width / 4),
              _btn(() async {
                if (token == null || token == "") {
                  await RouteService.routeGoOnePage(const LoginScreen(
                    isLoginBack: true,
                  ));
                }
                RouteService.routeGoOnePage(
                  NowAuctionScreen(
                    request: PriceRequest(
                      items: [
                        PriceAuctionRequest(
                            qty: data.qty!, tax: data.tax, price: data.price)
                      ],
                    ),
                    dto: InfoProductDto(
                      code: data.code!,
                      name: data.name!,
                      url: data.url!,
                      thumbnails: data.thumbnails,
                      price: data.price,
                      tax: data.tax,
                      qty: data.qty,
                      condition: data.condition,
                      percent: data.sellerDto!.percent,
                    ),
                  ),
                );
              },
                  SvgPicture.asset(
                    AppImages.icBasket,
                    width: AppGap.w24,
                    height: AppGap.h24,
                    color: AppColors.neutral800Color,
                  ),
                  AppColors.white,
                  width: width / 4),
            ],
          ),
        ),
        SizedBox(
            width: width / 2,
            child: _btn(
              () async {
                if (token == null || token == "") {
                  await RouteService.routeGoOnePage(const LoginScreen(
                    isLoginBack: true,
                  ));
                }
                RouteService.routeGoOnePage(
                  AuctionScreen(
                    request: PriceRequest(
                      items: [
                        PriceAuctionRequest(
                            qty: data.qty!, tax: data.tax, price: data.price)
                      ],
                      routeCode: 'JP'
                    ),
                    dto: InfoProductDto(
                      code: data.code!,
                      name: data.name!,
                      url: data.url!,
                      thumbnails: data.thumbnails,
                      price: data.price,
                      tax: data.tax,
                      qty: data.qty,
                      condition: data.condition,
                      percent: data.sellerDto!.percent!,
                      sellerId: data.sellerDto!.id,
                    ),
                  ),
                );
              },
              Text(
                'Đấu giá',
                style: AppStyles.text6016(color: AppColors.neutral800Color),
              ),
              AppColors.yellow800Color,
            )),
      ],
    );
  }

  Widget _btnNoBuy(DetailDto? detailDto, {double width = 0}) {
    var data = detailDto!;
    return Row(
      children: [
        _btnTitle(
          AppStrings.of(context).auction,
          AppImages.icBid,
          width: width,
          onTap: () async {
            if (token == null || token == "") {
              await RouteService.routeGoOnePage(const LoginScreen(
                isLoginBack: true,
              ));
            }
            var isResult = RouteService.routeGoOnePage(
              AuctionScreen(
                request: PriceRequest(
                  items: [
                    PriceAuctionRequest(
                        qty: data.qty!, tax: 0, price: data.price)
                  ],
                ),
                dto: InfoProductDto(
                  code: data.code!,
                  name: data.name!,
                  url: data.url!,
                  thumbnails: data.thumbnails,
                  price: data.price,
                  tax: 0,
                  qty: data.qty,
                  condition: data.condition,
                  sellerId: data.sellerDto!.id,
                  percent: data.sellerDto!.percent!,
                ),
              ),
            );
          },
        ),
        _btnTitle(
            AppStrings.of(context).lastMinuteHunting, AppImages.icLastMinus,
            width: width, colors: AppColors.primary700Color, onTap: () async {
          if (token == null || token == "") {
            await RouteService.routeGoOnePage(const LoginScreen(
              isLoginBack: true,
            ));
          }
          RouteService.routeGoOnePage(
            LastMinuteHuntingScreen(
              request: PriceRequest(
                items: [
                  PriceAuctionRequest(qty: data.qty!, tax: 0, price: data.price,)
                ],
                routeCode: 'JP'
              ),
              dto: InfoProductDto(
                code: data.code!,
                name: data.name!,
                url: data.url!,
                thumbnails: data.thumbnails,
                price: data.price,
                tax: 0,
                qty: data.qty,
                condition: data.condition,
                sellerId: data.sellerDto!.id,
                percent: data.sellerDto!.percent
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _btnTitle(String text, String icon,
          {double width = 0,
          void Function()? onTap,
          Color colors = AppColors.yellow800Color}) =>
      AppButton(
        enable: true,
        width: width / 2,
        onPressed: onTap,
        text: text,
        radius: 0,
        color: colors,
        icon: icon,
      );

  Widget _btn(void Function()? onTap, Widget child, Color colors,
          {double width = 0}) =>
      InkWell(
        onTap: onTap,
        child: Container(
          width: width,
          decoration: BoxDecoration(
            color: colors,
            border: Border.all(color: colors, width: 1),
          ),
          padding: EdgeInsets.symmetric(
            vertical: AppGap.h10,
          ),
          alignment: Alignment.center,
          child: child,
        ),
      );

  Widget _popup(String icon, String title) => Row(
        children: [
          SvgPicture.asset(icon),
          Text(title),
        ],
      );
}
