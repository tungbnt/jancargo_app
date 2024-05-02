import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:jancargo_app/src/components/resource/molecules/app_loading.dart';
import 'package:jancargo_app/src/components/resource/molecules/radio_button.dart';
import 'package:jancargo_app/src/domain/dtos/user/warehouse/warehouse_dto.dart';
import 'package:jancargo_app/src/domain/services/dialog/dialog_service.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/modules/auth/login/screens/login_screen.dart';
import 'package:jancargo_app/src/modules/cart/screens/cart_screens.dart';
import 'package:jancargo_app/src/util/app_convert.dart';

import '../../../components/bloc/cart/cart_cubit.dart';
import '../../../components/resource/molecules/app_button.dart';
import '../../../components/resource/molecules/container_add_cart_animation.dart';
import '../../../components/resource/molecules/custom_accordion.dart';
import '../../../components/resource/molecules/custom_expand_text.dart';
import '../../../components/resource/molecules/input_amount.dart';
import '../../../components/widget/add_item_bottom_sheet.dart';
import '../../../components/widget/widget_error.dart';
import '../../../data/object_request_api/add_cart/add_cart_request.dart';
import '../../../domain/dtos/detail_product/list/relates_dto.dart';
import '../../../domain/dtos/detail_product/y_shopping/y_shopping_dto.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_constants.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_gap.dart';
import '../../details_product_auction/bloc/detail_product_cubit.dart';
import '../../details_product_auction/components/primary_img.dart';
import '../../details_product_auction/components/recentlys.dart';
import '../../details_product_auction/components/scaffold.dart';
import '../../details_product_auction/components/suggestions.dart';
import '../components/info_product.dart';

class YShoppingDetailProduct extends StatefulWidget {
  const YShoppingDetailProduct(
      {super.key, required this.code, required this.source});

  final String code;
  final String source;

  @override
  State<YShoppingDetailProduct> createState() => _YShoppingDetailProductState();
}

class _YShoppingDetailProductState extends State<YShoppingDetailProduct> {
  final DetailProductCubit _cubit = DetailProductCubit();
  final CartCubit _cubitCart = CartCubit();
  List<RelatesDto>? suggestionsDto = [];
  String valueShip = '';
  ValueNotifier<int> selectedAmount = ValueNotifier(1);
  ValueNotifier<int> numberItemCart = ValueNotifier(0);
  ValueNotifier<bool> isAddCart = ValueNotifier(false);
  ValueNotifier<bool> isFavorite = ValueNotifier(false);

  void handleAmountChanged(int value) => selectedAmount.value = value;

  // We can detect the location of the cart by this  GlobalKey<CartIconKey>
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  final GlobalKey widgetKey = GlobalKey();
  late Function(GlobalKey) runAddToCartAnimation;
  var _cartQuantityItems = 0;

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
      BuildContext context, YShoppingDetailDto data) async {
    //ẩn bottom sheet
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
          siteCode: "YSP_JP"),
    );
  }

  void _showSheet(BuildContext context, YShoppingDetailDto data) async {
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
                    Image.asset(AppImages.imgShopping,height: 24.h,width: 24.w,),
                    AppGap.sbW8,
                    Text(
                      'Yahoo! Shopping',
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
          buildWhen: (prv,state)=> state is DetailProductLoading || state is DetailProductInfoDataSuccess,
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
            if(state is DetailProductFailed){
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
              var data = state.yShoppingDetailDto!;
              return Row(
                children: [
                  Expanded(

                    child: BlocListener<CartCubit, CartState>(
                      bloc: _cubitCart,
                      listener: (context, state) async {
                        if (state is CartLoading) {
                          return await AppLoading.openSpinkit(context);
                        } else if (state is AddCartSuccess) {
                          AppLoading.hideLoading();
                          DialogService.showNotiBannerSuccess(context, "Thêm vào giỏ hàng thành công!");
                        }else if (state is AddCartFailed) {
                          AppLoading.hideLoading();
                          DialogService.showNotiBannerInfo(context, "Thêm vào giỏ hàng không thành công!");
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
                                Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
                                final token = hiveBox.get(AppConstants.ACCESS_TOKEN);
                                if(token == null || token == ""){
                                   RouteService.routeGoOnePage(const LoginScreen(isLoginBack: true,));
                                }else{
                                  print('valueship: $valueShip');
                                  if( valueShip.isEmpty && valueShip == ''){
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
                              borderColor: AppColors.neutral200Color,
                              textColor: AppColors.black03,
                              icon: isAddCart.value ? null : AppImages.icBasket,
                            );
                          }),
                    ),
                  ),
                  Expanded(

                    child: AppButton(
                      enable: true,
                      onPressed: () => RouteService.routeGoOnePage(const CartScreen()),
                      text: AppStrings.of(context).buyNow,
                      radius: 0,
                      color: AppColors.yellow800Color,
                      borderColor: AppColors.neutral200Color,
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
        listener: (context,state){
          if (state is FavoriteDataSuccess) {
            isFavorite.value = true;
          }
        },
        listenWhen: (prv, state) =>
        state.runtimeType == FavoriteDataSuccess,
        buildWhen: (prv, state) =>
            state.runtimeType == DetailProductInfoDataSuccess,
        builder: (context, state) {
          if (state is DetailProductInfoDataSuccess) {
            return PrimaryImg(
              name: state.yShoppingDetailDto!.name!,
              price: state.yShoppingDetailDto!.price!,
              images: state.yShoppingDetailDto!.images,
              imagesThum: state.yShoppingDetailDto!.images!,
              code: state.yShoppingDetailDto!.code!,
              endTime: '',
              url: state.yShoppingDetailDto!.url!,
              siteCode: AppConstants.yShoppingSource,
              urlSite: "https://store.shopping.yahoo.co.jp/sonohara-store/${widget.code}",
              nameSite: "Yahoo! Shopping",
              isFavorite: isFavorite,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _titleSuggestion() => Padding(
    padding:  EdgeInsets.symmetric(horizontal: AppGap.w10),
    child: Text('Sản phẩm liên quan',style: AppStyles.text7018(),),
  );

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
                    valueShip = state.shipModeDto![index].value ?? '';
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
          builder: (context, state) {
            if (state is DetailProductInfoDataSuccess) {
              return Container(
                color: AppColors.white,
                child: CustomExpandText(
                  code: state.yShoppingDetailDto!.code!,
                  descriptions: state.yShoppingDetailDto!.description!,
                  site: "shopping",
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
          buildWhen: (prv, state) =>
              state.runtimeType == DetailProductInfoDataSuccess,
          builder: (context, state) {
            if (state is DetailProductInfoDataSuccess) {
              return InfoProduct(dto: state.yShoppingDetailDto!);
            }
            return const SizedBox.shrink();
          },
        ),
      );



  //danh sách gợi ý hôm nay
  Widget _suggestions() => SliverToBoxAdapter(
    child: BlocBuilder<DetailProductCubit, DetailProductState>(
      bloc: _cubit,
      buildWhen: (prv, state) =>
      state.runtimeType == SuggestionsDataSuccess,
      builder: (context, state) {
        if (state is SuggestionsDataSuccess) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: AppGap.w8,vertical: AppGap.h10),
            margin: EdgeInsets.only(top: AppGap.h10),
            height: AppGap.h245,
            width: double.infinity,
            color: AppColors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _titleSuggestion(),
                AppGap.sbH5,
                SizedBox(
                  height: AppGap.h194,
                  child:  ListView.separated(
                    itemCount: state.suggestionsShoppingDto!.results!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {  return SuggestionsYShopping(
                      dto: state.suggestionsShoppingDto!.results![index],
                    ); }, separatorBuilder: (BuildContext context, int index) {   return AppGap.sbW8; },
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
  Widget _recentlys() => SliverToBoxAdapter(
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

class DialogActiveShip extends StatefulWidget {
  const DialogActiveShip({super.key, required this.items, this.valueSelected,});

  final List<ShipModeDto> items;
  final int? valueSelected;


  @override
  State<DialogActiveShip> createState() => _DialogActiveShipState();
}

class _DialogActiveShipState extends State<DialogActiveShip> {

  final ValueNotifier<int?> selectedVipIndex = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
  }

  void init(){
    if(widget.valueSelected != null){
      selectedVipIndex.value = widget.valueSelected;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      height: AppGap.h308,
      width: MediaQuery
          .of(context)
          .size
          .width,
      margin: EdgeInsets.symmetric(horizontal: AppGap.w10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: AppColors.neutral300Color,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppGap.sbW12,
                Text(
                  'Vui lòng chọn tuyến vận chuyển',
                  style: AppStyles.text7018(),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () =>
                      Navigator.pop(context, selectedVipIndex.value),
                  icon: SvgPicture.asset(AppImages.icX),
                )
              ],
            ),
          ),
          Flexible(child: _buildShipModes(widget.items)),
          _buildBtn(),
          AppGap.sbH20,
        ],
      ),
    );
  }
  Widget _buildBtn(){
   return Row(
     mainAxisAlignment: MainAxisAlignment.end,
     children: [
       GestureDetector(
         onTap: ()async{
            Navigator.pop(context,selectedVipIndex.value);
         },
         child: Container(
           margin: EdgeInsets.only(right: AppGap.w20),
            height: AppGap.h32,
            width: AppGap.w70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(AppGap.r4),),
              color: AppColors.yellow800Color,
            ),
            alignment: Alignment.center,
            child: Text('OK',style: AppStyles.text6016(),),
          ),
       ),
     ],
   );
  }
  Widget _buildShipModes(List<ShipModeDto> items, ){
    return SizedBox(
      height: 220.h,
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(items[index],index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return index < items.length - 1
              ? const Divider()
              : const SizedBox.shrink();
        },
        itemCount:items.length,
      ),
    );
  }

  Widget _buildItem(ShipModeDto shipModeDto, int indexGroup){
    return ValueListenableBuilder(
        valueListenable: selectedVipIndex,
      builder: (context,valueSecleted,_) {
        return CustomRadioListWidget<int>(
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    shipModeDto.label!,
                    style: AppStyles.text4014(color: AppColors.black03),
                  ),
                  // const Spacer(),
                  // Text(
                  //     shipModeDto.priceEst != ''
                  //         ? '${AppConvert.convertVn(int.parse(shipModeDto.priceEst ?? ''))}/kg'
                  //         : '',
                  //     style: AppStyles.text4014(
                  //         color: AppColors.primary700Color)),
                  AppGap.sbW12
                ],
              ),
              Text(shipModeDto.description!,
                  style:
                  AppStyles.text4014(color: AppColors.neutral500Color)),
            ],
          ),
          value: selectedVipIndex.value,
          groupValue: indexGroup,
          onSelected:(int index){
            selectedVipIndex.value = indexGroup;
          },
        );
      }
    );
  }
}
