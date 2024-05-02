import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:jancargo_app/src/components/resource/molecules/container_add_cart_animation.dart';
import 'package:jancargo_app/src/modules/auth/login/screens/login_screen.dart';
import 'package:jancargo_app/src/modules/detail_product_marcari/components/info_product.dart';
import 'package:jancargo_app/src/modules/detail_product_y_shopping/screens/detail_product_y_shopping.dart';
import 'package:jancargo_app/src/modules/personal/screens/recently_viewed/recently_viewed_screen.dart';

import '../../../components/bloc/cart/cart_cubit.dart';
import '../../../components/resource/molecules/app_button.dart';
import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../components/resource/molecules/app_loading.dart';
import '../../../components/resource/molecules/btn_seen_all.dart';
import '../../../components/resource/molecules/custom_accordion.dart';
import '../../../components/resource/molecules/custom_expand_text.dart';
import '../../../components/resource/molecules/input_amount.dart';
import '../../../components/resource/molecules/widget_shape_discount.dart';
import '../../../components/resource/organisms/will_view.dart';
import '../../../components/widget/add_item_bottom_sheet.dart';
import '../../../components/widget/widget_error.dart';
import '../../../data/object_request_api/add_cart/add_cart_request.dart';
import '../../../domain/dtos/detail_product/detail_marcari/detail_marcari_dto.dart';
import '../../../domain/dtos/detail_product/list/relates_dto.dart';
import '../../../domain/services/dialog/dialog_service.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/app_strings/app_strings.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_constants.dart';
import '../../../general/constants/app_images.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_convert.dart';
import '../../../util/app_gap.dart';
import '../../cart/screens/cart_screens.dart';
import '../../details_product_auction/bloc/detail_product_cubit.dart';
import '../../details_product_auction/components/primary_img.dart';
import '../../details_product_auction/components/recentlys.dart';
import '../../details_product_auction/components/scaffold.dart';
import '../../details_product_auction/components/similar_product_list.dart';
import '../../details_product_auction/components/suggestions.dart';
import '../../details_product_auction/screens/details_product_screen.dart';
import '../../details_product_auction/widget/store_widget.dart';
import '../../seller/screen/seller_mercari_screen.dart';

class MarcariDetailProduct extends StatefulWidget {
  const MarcariDetailProduct(
      {super.key, required this.code, required this.source});

  final String code;
  final String source;

  @override
  State<MarcariDetailProduct> createState() => _MarcariDetailProductState();
}

class _MarcariDetailProductState extends State<MarcariDetailProduct> {
  final DetailProductCubit _cubit = DetailProductCubit();
  final CartCubit _cubitCart = CartCubit();
  // We can detect the location of the cart by this  GlobalKey<CartIconKey>
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  final GlobalKey widgetKey = GlobalKey();

  List<RelatesDto>? suggestionsDto = [];
  String? valueShip;
  ValueNotifier<int> selectedAmount = ValueNotifier(1);
  ValueNotifier<int> numberItemCart = ValueNotifier(0);
  ValueNotifier<bool> isFavorite = ValueNotifier(false);
  ValueNotifier<bool> isAddCart = ValueNotifier(false);

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

  void _handlePressedAddToCartButton(
      BuildContext context, MarcariDetailDto data) async {
    //ẩn bottom sheet
    await RouteService.pop();
    Future.delayed(const Duration(microseconds: 500), () {
      listClick();
    });
    //call api
    _cubitCart.addCart(
      AddCartRequest(
        name: data.product!.name,
        code: data.product!.code,
        images: data.product!.thumbnails,
        description: data.product!.description,
        price: data.product!.price,
        url: data.product!.url,
        shipMode: valueShip,
        qty: selectedAmount.value,
        currency: "JPY",
        siteCode: AppConstants.marcariSource,
      ),
    );

    // add number cart
    numberItemCart.value++;
  }

  void _showSheet(BuildContext context, MarcariDetailDto data) async {
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
                    Image.asset(AppImages.imgMercari,height: 24.h,width: 24.w,),
                    AppGap.sbW8,
                    Text(
                      'Mercari',
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
                price: data.product!.price!,
                name: data.product!.name!,
                images: data.product!.thumbnails!,
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
                  text: AppStrings.of(context).buyNow,
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
        listenWhen: (prv, state) => state is CartDataSuccess,
        listener: (context, state) {
          if (state is CartDataSuccess) {
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
                    _infStore(),
                    _sizedBox(),
                    _infoProduct(),
                    _sizedBox(),
                    _readMore(),
                    _sizedBox(),
                    _similars(),
                    _sizedBox(),
                    _recentlys(),
                    _sizedBox(),
                    _sizedBox(),
                    _sizedBox(),
                    // _titleSuggestion(),
                    // _sizedBox(),
                    // _suggestions(),
                    // _sizedBox(),
                  ],
                );
              }
              if (state is DetailProductFailed) {
                return ErrorCustomWidget();
              }
              return const SizedBox.shrink();
            },
          ),
          bottomNav: BlocBuilder<DetailProductCubit, DetailProductState>(
            bloc: _cubit,
            buildWhen: (prv, state) => state.runtimeType == DataDetailsSuccess,
            builder: (context, state) {
              if (state is DataDetailsSuccess) {
                var data = state.marcariDetailDto!;
                return Row(
                  children: [
                    Expanded(
                      child: BlocListener<CartCubit, CartState>(
                        bloc: _cubitCart,
                        listener: (context, state) async {
                          if (state is CartLoading) {
                            AppLoading.openPouringHour();
                          } else if (state is AddCartSuccess) {
                            AppLoading.hideLoading();
                            DialogService.showNotiBannerSuccess(
                                context, "Thêm vào giỏ hàng thành công!");
                          }
                        },
                        child: ValueListenableBuilder(
                          valueListenable: isAddCart,
                            builder: (context, _, __) {
                              int? selectedShip;
                              return ContainerAddCartAnimation(
                                widgetKey: widgetKey,
                                enable: true,
                                onPressed: ()async {
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
                        text: AppStrings.of(context).buyNow,
                        radius: 0,
                        color: AppColors.yellow800Color,
                        borderColor: AppColors.yellow800Color,
                      ),
                    ),
                  ],
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
        buildWhen: (prv, state) => state.runtimeType == DataDetailsSuccess,
        builder: (context, state) {
          if (state is DataDetailsSuccess) {
            return PrimaryImg(
              name: state.marcariDetailDto!.product!.name!,
              price: state.marcariDetailDto!.product!.price!,
              images: state.marcariDetailDto!.product!.thumbnails,
              imagesThum: state.marcariDetailDto!.product!.thumbnails!,
              code: state.marcariDetailDto!.product!.code!,
              endTime: '',
              url: '',
              siteCode: AppConstants.marcariSource,
              urlSite: "https://jp.mercari.com/item/${widget.code}",
              nameSite: "Mercari",
              isFavorite: isFavorite,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _titleSuggestion() => SliverToBoxAdapter(
        child: Container(
          color: AppColors.white,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: AppGap.w10),
          width: double.infinity,
          height: AppGap.h40,
          child: Text(
            AppStrings.of(context).suggestionToday,
            style: AppStyles.text7018(),
          ),
        ),
      );

  Widget _infStore() => SliverToBoxAdapter(
          child: BlocBuilder<DetailProductCubit, DetailProductState>(
        bloc: _cubit,
        buildWhen: (prv, state) => state is DataDetailsSuccess,
        builder: (context, state) {
          if (state is DataDetailsSuccess) {
            return GestureDetector(
              onTap: () => RouteService.routeGoOnePage(
                SellerMercariScreen(
                  sellerId:
                      state.marcariDetailDto!.product!.seller!.id!.toString(),
                  sellerName: state.marcariDetailDto!.product!.seller!.name!,
                ),
              ),
              child: StoreWidget(
                url: state.marcariDetailDto!.product!.seller!.photoUrl!,
                name: state.marcariDetailDto!.product!.seller!.name!,
                code: state.marcariDetailDto!.product!.seller!.id!.toString(),
                totalRate: state
                    .marcariDetailDto!.product!.seller!.ratings!.good!
                    .toString(),
                percent: "100",
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ));

  Widget _accordion() => SliverToBoxAdapter(
        child: BlocBuilder<DetailProductCubit, DetailProductState>(
          bloc: _cubit,
          buildWhen: (prv, state) => state.runtimeType == WareHouseDataSuccess,
          builder: (context, state) {
            if (state is WareHouseDataSuccess) {
              return Container(
                color: AppColors.white,
                child: CustomAccordionShip(
                  getCurrentIndex: (index) {
                    valueShip = state.shipModeDto![index].value;
                  },
                  dto: state.shipModeDto!,
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      );

  Widget _readMore() => SliverToBoxAdapter(
        child: BlocBuilder<DetailProductCubit, DetailProductState>(
          bloc: _cubit,
          buildWhen: (prv, state) => state is DataDetailsSuccess,
          builder: (context, state) {
            if (state is DataDetailsSuccess) {
              return state.marcariDetailDto!.product!.description == null
                  ? const SizedBox.shrink()
                  : Container(
                      color: AppColors.white,
                      child: CustomExpandText(
                        code: state.marcariDetailDto!.product!.code!,
                        descriptions:
                            state.marcariDetailDto!.product!.description!,
                        site: "mercari",
                      ),
                    );
            }
            return const SizedBox.shrink();
          },
        ),
      );

  //thông tin sản phẩm
  Widget _infoProduct() => SliverToBoxAdapter(
        child: BlocBuilder<DetailProductCubit, DetailProductState>(
          bloc: _cubit,
          buildWhen: (prv, state) => state is DataDetailsSuccess,
          builder: (context, state) {
            if (state is DataDetailsSuccess) {
              return InfoProduct(dto: state.marcariDetailDto!);
            }
            return const SizedBox.shrink();
          },
        ),
      );

  //danh sách sản phẩm tương tự
  Widget _similars() => SliverToBoxAdapter(
          child: BlocBuilder<DetailProductCubit, DetailProductState>(
        bloc: _cubit,
        buildWhen: (prv, state) => state.runtimeType == DataDetailsSuccess,
        builder: (context, state) {
          if (state is DataDetailsSuccess) {
            return SimilarProductMercari(
              dto: state.marcariDetailDto!.relates!,
            );
          }
          return const SizedBox.shrink();
        },
      ));

  //danh sách gợi ý hôm nay
  Widget _suggestions() => SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: AppGap.w8),
        sliver: BlocBuilder<DetailProductCubit, DetailProductState>(
          bloc: _cubit,
          buildWhen: (prv, state) =>
              state.runtimeType == SuggestionsDataSuccess,
          builder: (context, state) {
            if (state is SuggestionsDataSuccess) {
              return SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  mainAxisExtent: AppGap.h240,
                  crossAxisSpacing: AppGap.w10,
                  mainAxisSpacing: AppGap.w10,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Suggestions(
                      dto: state.suggestionsDto![index],
                    );
                  },
                  childCount: state.suggestionsDto?.length ?? 0,
                ),
              );
            }
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          },
        ),
      );

  //danh sách xem gần đây
  Widget _recentlys() => SliverToBoxAdapter(
          child: BlocBuilder<DetailProductCubit, DetailProductState>(
        bloc: _cubit,
        buildWhen: (prv, state) => state.runtimeType == DataDetailsSuccess,
        builder: (context, state) {
          if (state is DataDetailsSuccess) {
            return RecentlysDetailMercari(
              dto: state.marcariDetailDto!.relates!,
            );
          }
          return const SizedBox.shrink();
        },
      ));
}

class RecentlysDetailMercari extends StatelessWidget {
  const RecentlysDetailMercari({super.key, required this.dto});

  final List<RelatesMarcariDetailDto> dto;

  @override
  Widget build(BuildContext context) {
    return WillView(
      child: Container(
        color: AppColors.white,
        width: double.infinity,
        height: AppGap.h240,
        padding: EdgeInsets.all(AppGap.h10),
        child: Column(
          children: [
            _title(context),
            _items(),
          ],
        ),
      ),
    );
  }

  Widget _title(BuildContext context) => Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
            child: Text(
              AppStrings.of(context).recentlyViewed,
              style: AppStyles.text7018(),
            ),
          ),
          const Spacer(),
          SeenAllBtn(
            onTap: () => const RecentlyViewedScreen(),
          ),
        ],
      );

  Widget _items() => SizedBox(
        height: AppGap.h194,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return _item(dto[index]);
            },
            separatorBuilder: (context, i) {
              return AppGap.sbW8;
            },
            itemCount: dto.length),
      );

  Widget _item(RelatesMarcariDetailDto item) => GestureDetector(
        onTap: () => RouteService.routeGoOnePage(
          ProductDetailsScreen(
            code: item.code!,
            source: AppConstants.auctionShoppingSource,
          ),
        ),
        child: SizedBox(
          width: AppGap.w144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AppCarouselImages(
                    height: AppGap.h128,
                    // ignore: invalid_use_of_protected_member
                    imagesUrl: [item.image!],
                    alignment: Alignment.topCenter,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(AppGap.r8),
                      topLeft: Radius.circular(AppGap.r8),
                    ),
                    autoPlay: false,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      children: [
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: AppGap.w10),
                          child: const ShapeDiscountWidget(cent: '25'),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.all(AppGap.h10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.yellow800Color,
                      ),
                      child: Image.asset(
                        AppImages.imgAuction,
                        height: 24.h,
                        width: 24.w,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(AppGap.h3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name!,
                      style: AppStyles.text4012(color: AppColors.black03),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(AppConvert.convertAmountVn(item.price!),
                        style: AppStyles.text7016(
                            color: AppColors.primary700Color)),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
