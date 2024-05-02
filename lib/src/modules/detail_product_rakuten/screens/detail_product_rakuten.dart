import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';
import 'package:jancargo_app/src/modules/detail_product_rakuten/components/info_product.dart';
import 'package:jancargo_app/src/modules/detail_product_y_shopping/screens/detail_product_y_shopping.dart';

import '../../../components/bloc/cart/cart_cubit.dart';
import '../../../components/resource/molecules/app_button.dart';
import '../../../components/resource/molecules/app_loading.dart';
import '../../../components/resource/molecules/container_add_cart_animation.dart';
import '../../../components/resource/molecules/custom_accordion.dart';
import '../../../components/resource/molecules/custom_expand_text.dart';
import '../../../components/resource/molecules/input_amount.dart';
import '../../../components/widget/add_item_bottom_sheet.dart';
import '../../../components/widget/widget_error.dart';
import '../../../data/object_request_api/add_cart/add_cart_request.dart';
import '../../../domain/dtos/detail_product/list/relates_dto.dart';
import '../../../domain/dtos/detail_product/rakuten_detail/rakuten_detail_dto.dart';
import '../../../domain/services/dialog/dialog_service.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_constants.dart';
import '../../../general/constants/app_images.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_gap.dart';
import '../../auth/login/screens/login_screen.dart';
import '../../cart/screens/cart_screens.dart';
import '../../details_product_auction/bloc/detail_product_cubit.dart';
import '../../details_product_auction/components/primary_img.dart';
import '../../details_product_auction/components/recentlys.dart';
import '../../details_product_auction/components/scaffold.dart';
import '../../details_product_auction/components/similar_product_list.dart';
import '../../details_product_auction/components/suggestions.dart';

class RakutenDetailProductScreen extends StatefulWidget {
  const RakutenDetailProductScreen(
      {super.key, required this.code, required this.source});

  final String code;
  final String source;

  @override
  State<RakutenDetailProductScreen> createState() =>
      _RakutenDetailProductScreenState();
}

class _RakutenDetailProductScreenState
    extends State<RakutenDetailProductScreen> {
  ValueNotifier<int> selectedAmount = ValueNotifier(1);
  ValueNotifier<bool> isFavorite = ValueNotifier(false);
  ValueNotifier<bool> isAddCart = ValueNotifier(false);
  ValueNotifier<int> numberItemCart = ValueNotifier(0);
  final DetailProductCubit _cubit = DetailProductCubit();
  final CartCubit _cubitCart = CartCubit();
  List<RelatesDto>? suggestionsDto = [];
  String? valueShip;

  // We can detect the location of the cart by this  GlobalKey<CartIconKey>
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  final GlobalKey widgetKey = GlobalKey();
  late Function(GlobalKey) runAddToCartAnimation;
  var _cartQuantityItems = 0;

  void handleAmountChanged(int value) => selectedAmount.value = value;

  @override
  void initState() {
    super.initState();
    _cubit.info(widget.code, widget.source);
  }

  void listClick() async {
    isAddCart.value = true;
    await runAddToCartAnimation(widgetKey);
    await cartKey.currentState!
        .runCartAnimation((++_cartQuantityItems).toString());
    isAddCart.value = false;
  }

  void _handlePressedAddToCartButton(BuildContext context,
      RakutenDetailItemDto data) async {
    await RouteService.pop();
    Future.delayed(const Duration(microseconds: 500), () {
      listClick();
    });
    //call api
    _cubitCart.addCart(
      AddCartRequest(
          name: data.name,
          code: data.code,
          images: data.images,
          description: data.description,
          price: data.price,
          url: data.url,
          shipMode: valueShip,
          qty: selectedAmount.value,
          currency: "JPY",
          siteCode: AppConstants.rakutenSource),
    );
    // add number cart
    numberItemCart.value++;
  }

  void _showSheet(BuildContext context, RakutenDetailItemDto data) async {
    DialogService.showBottomSheet(
        context,
        Container(
          color: AppColors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppGap.w10,
                ),
                child: Row(
                  children: [
                    Image.asset(AppImages.imgRakuten,height: 24.h,width: 24.w,),
                    AppGap.sbW8,
                    Text(
                      "Rakuten",
                      style: AppStyles.text7016(),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => RouteService.pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              AddItemBottomSheet(
                price: data.price!,
                name: data.name!,
                images: data.images!,
              ),
              const Divider(),
              InputAmount(
                selectedAmount: selectedAmount,
                onChanged: handleAmountChanged,
                readOnly: true,
              ),
              const Divider(),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppGap.w10, vertical: AppGap.h20),
                child: AppButton(
                  enable: true,
                  onPressed: () => _handlePressedAddToCartButton(context, data),
                  text: AppStrings
                      .of(context)
                      .buyNow,
                  radius: 0,
                  color: AppColors.yellow800Color,
                  borderColor: AppColors.neutral200Color,
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      // To send the library the location of the Cart icon
      cartKey: cartKey,
      height: 30,
      width: 30,
      opacity: 0.85,
      dragAnimation: const DragToCartAnimationOptions(
        rotation: false,
      ),
      jumpAnimation:
      const JumpAnimationOptions(duration: Duration(microseconds: 300)),
      createAddToCartAnimation: (runAddToCartAnimation) {
        // You can run the animation by addToCartAnimationMethod, just pass trough the the global key of  the image as parameter
        this.runAddToCartAnimation = runAddToCartAnimation;
      },
      child: BlocListener<DetailProductCubit, DetailProductState>(
        bloc: _cubit,
        listenWhen: (prv,state)=> state is CartDataSuccess,
        listener: (context, state) {
         if(state is CartDataSuccess){
           numberItemCart.value = state.numberItemCart!;
         }
        },
        child: ScaffoldCustom(
          cubit: _cubit,
          cartKey: cartKey,
          numberItemCart: numberItemCart,
          onPressed: (){
            _cubit.info(widget.code, widget.source);
          },
          body: BlocBuilder<DetailProductCubit, DetailProductState>(
            bloc: _cubit,
            builder: (context, state) {
              if (state is DetailProductLoading) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
              if (state is DetailProductInfoDataSuccess) {
                return CustomScrollView(
                  slivers: [
                    _primaryImagerProduct(),
                    _sizedBox(),
                    _accordion(),
                    _sizedBox(),
                    _infoProduct(),
                    _sizedBox(),
                    _readMore(),
                    _suggestions(),
                    _recentlys(),
                    _sizedBox(),
                    _sizedBox(),
                    _sizedBox(),
                    _sizedBox(),
                  ],
                );
              }
              if (state is DetailProductFailed) {
                return const ErrorCustomWidget();
              }
              return const SizedBox.shrink();
            },
          ),
          bottomNav: BlocBuilder<DetailProductCubit, DetailProductState>(
            bloc: _cubit,
            buildWhen: (prv, state) =>
            state.runtimeType == DetailProductInfoDataSuccess,
            builder: (context, state) {
              if (state is DetailProductInfoDataSuccess) {
                var data = state.rakutenDetailDto!;
                return Container(
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(1, 3),
                          blurRadius: 6,
                          spreadRadius: 1,
                          color: AppColors.neutral300Color,
                        )
                      ]
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: BlocListener<CartCubit, CartState>(
                          bloc: _cubitCart,
                          listener: (context, state) async {
                            // if (state is CartLoading) {
                            //   return await AppLoading.openSpinkit();
                            // } else
                            if (state is AddCartSuccess) {
                              // AppLoading.hideLoading();
                              DialogService.showNotiBannerSuccess(
                                  context, "Thêm vào giỏ hàng thành công!");
                            } else if (state is AddCartFailed) {
                              // AppLoading.hideLoading();
                              DialogService.showNotiBannerInfo(
                                  context,
                                  "Thêm vào giỏ hàng không thành công!");
                            }
                          },
                          child: ValueListenableBuilder(
                              valueListenable: isAddCart,
                              builder: (context, _, __) {
                                int? selectedShip;
                                return ContainerAddCartAnimation(
                                  widgetKey: widgetKey,
                                  enable: true,
                                  onPressed: () async{
                                    Box hiveBox =
                                    Hive.box(AppConstants.APP_NAME_ID);
                                    final token =
                                    hiveBox.get(AppConstants.ACCESS_TOKEN);
                                    if (token == null || token == "") {
                                      RouteService.routeGoOnePage(
                                          const LoginScreen(
                                            isLoginBack: true,
                                          ));
                                    } else {
                                      print('valueship: $valueShip');
                                      if( valueShip!.isEmpty && valueShip == ''){
                                        await DialogService.openDialog(
                                          DialogActiveShip(
                                            items: _cubit.newShip,
                                            valueSelected: selectedShip,
                                          ),
                                          barrierDismissible: true,
                                        ).then((selectedVipIndex) {
                                          if (selectedVipIndex != null) {
                                            valueShip = _cubit.newShip[selectedVipIndex].value!;
                                            print('valueship after selected: $valueShip');
                                          }
                                          return selectedVipIndex;
                                        });
                                        return;
                                      }
                                      _showSheet(context, data);
                                    }
                                  },
                                  text: "Thêm vào giỏ",
                                  radius: 0,
                                  color: AppColors.white,
                                  borderColor: AppColors.white,
                                  textColor: AppColors.black03,
                                  icon: isAddCart.value ? null : AppImages
                                      .icBasket,
                                );
                              }),
                        ),
                      ),
                      Expanded(
                        child: AppButton(
                          enable: true,
                          onPressed: () =>
                              RouteService.routeGoOnePage(const CartScreen()),
                          text: AppStrings
                              .of(context)
                              .buyNow,
                          radius: 0,
                          color: AppColors.yellow800Color,
                          borderColor: AppColors.yellow800Color,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _sizedBox() => SliverToBoxAdapter(child: AppGap.sbH10);

  Widget _primaryImagerProduct() {
    return SliverToBoxAdapter(
      child: BlocConsumer<DetailProductCubit, DetailProductState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is FavoriteDataSuccess) {
            isFavorite.value = true;
          }
        },
        listenWhen: (prv, state) => state.runtimeType == FavoriteDataSuccess,
        buildWhen: (prv, state) =>
        state.runtimeType == DetailProductInfoDataSuccess,
        builder: (context, state) {
          if (state is DetailProductInfoDataSuccess) {
            return PrimaryImg(
              name: state.rakutenDetailDto!.name!,
              price: state.rakutenDetailDto!.price!,
              images: state.rakutenDetailDto!.images,
              imagesThum: state.rakutenDetailDto!.images!,
              code: state.rakutenDetailDto!.code!,
              endTime: state.rakutenDetailDto!.endTime!,
              url: state.rakutenDetailDto!.url!,
              siteCode: AppConstants.rakutenSource,
              urlSite: "https://item.rakuten.co.jp/zonzontec/${widget.code}/",
              nameSite: "Rakuten",
              isFavorite: isFavorite,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _titleSuggestion() =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
        child: Text(
          AppStrings
              .of(context)
              .suggestionToday,
          style: AppStyles.text7018(),
        ),
      );

  Widget _accordion() =>
      SliverToBoxAdapter(
        child: Container(
          color: AppColors.white,
          child: const CustomAccordionShip(
            dto: [],
          ),
        ),
      );

  Widget _readMore() =>
      SliverToBoxAdapter(
        child: BlocBuilder<DetailProductCubit, DetailProductState>(
          bloc: _cubit,
          buildWhen: (prv, state) =>
          state.runtimeType == DetailProductInfoDataSuccess,
          builder: (context, state) {
            if (state is DetailProductInfoDataSuccess) {
              return Container(
                color: AppColors.white,
                child: CustomExpandText(
                  code: state.rakutenDetailDto!.code,
                  descriptions: state.rakutenDetailDto!.description,
                  site: "rakuten",
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      );

  //thông tin sản phẩm
  Widget _infoProduct() =>
      SliverToBoxAdapter(
        child: BlocBuilder<DetailProductCubit, DetailProductState>(
          builder: (context, state) {
            if (state is DetailProductInfoDataSuccess) {
              return InfoProduct(dto: state.rakutenDetailDto!);
            }
            return const SizedBox.shrink();
          },
        ),
      );

  //danh sách sản phẩm tương tự
  Widget _similars() =>
      SliverToBoxAdapter(
          child: BlocBuilder<DetailProductCubit, DetailProductState>(
            bloc: _cubit,
            buildWhen: (prv, state) => state.runtimeType == RelatesDataSuccess,
            builder: (context, state) {
              if (state is RelatesDataSuccess) {
                return SimilarProduct(
                  dto: state.relatesDto!,
                );
              }
              return const SizedBox.shrink();
            },
          ));

  //danh sách gợi ý hôm nay
  Widget _suggestions() =>
      SliverToBoxAdapter(
        child: BlocBuilder<DetailProductCubit, DetailProductState>(
          bloc: _cubit,
          buildWhen: (prv, state) =>
          state.runtimeType == SuggestionsDataSuccess,
          builder: (context, state) {
            if (state is SuggestionsDataSuccess) {
              return Container(
                padding: EdgeInsets.symmetric(
                    horizontal: AppGap.w8, vertical: AppGap.h10),
                margin: EdgeInsets.only(top: AppGap.h10),
                height: AppGap.h245,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                color: AppColors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _titleSuggestion(),
                    AppGap.sbH5,
                    SizedBox(
                      height: AppGap.h194,
                      child: ListView.separated(
                        itemCount: state.suggestionRakutenDto!.data!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return SuggestionsRakuten(
                            dto: state.suggestionRakutenDto!.data![index],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return AppGap.sbW8;
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      );

  //danh sách xem gần đây
  Widget _recentlys() =>
      SliverToBoxAdapter(
          child: BlocBuilder<DetailProductCubit, DetailProductState>(
            bloc: _cubit,
            buildWhen: (prv, state) =>
            state.runtimeType == RecentlyViewedDataSuccess,
            builder: (context, state) {
              if (state is RecentlyViewedDataSuccess) {
                return Recentlys(
                  dto: state.recentlyDto!.result!,
                );
              }
              return const SizedBox.shrink();
            },
          ));
}
