import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jancargo_app/src/app_manager.dart';
import 'package:jancargo_app/src/components/bloc/cart_items/cart_items_cubit.dart';
import 'package:jancargo_app/src/data/object_request_api/auction/price_auction/price_auction_request.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/general/constants/app_storage.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/cart/widget/spin_carts.dart';
import 'package:jancargo_app/src/modules/detail_product_marcari/screens/detail_product_marcari.dart';
import 'package:jancargo_app/src/modules/detail_product_rakuten/screens/detail_product_rakuten.dart';
import 'package:jancargo_app/src/modules/detail_product_y_shopping/screens/detail_product_y_shopping.dart';
import 'package:jancargo_app/src/modules/details_product_auction/screens/details_product_screen.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../domain/dtos/cart/item_cart/item_cart_dto.dart';
import '../../../general/app_strings/app_strings.dart';
import '../../../general/constants/app_colors.dart';
import '../../../util/app_gap.dart';

class ItemCart extends StatefulWidget {
  const ItemCart({
    super.key,
    required this.dto,
    required this.listGroupCarts,
    required this.nameShop,
    required this.cubit,
    this.getCurrentIndex,
  });

  final GroupCartsDto dto;
  final List<GroupCartsDto> listGroupCarts;
  final String nameShop;
  final CartItemsCubit cubit;
  final ValueSetter<int>? getCurrentIndex;

  @override
  State<ItemCart> createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  ValueNotifier<String> name = ValueNotifier('Đang cập nhật');
  ValueNotifier<List<ItemCartDto>> dataItem = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    nameStore();
    dataItem.value = widget.dto.data!;
  }

  void nameStore() async {
    name.value = await AppStorage.nameStore(dataItem.value[0].siteCode!);
  }

  void handleAmountChanged(int value, int index,ItemCartDto itemCart) async {
    dataItem.value[index].selectedAmount.value = value;
    List<CalculateCartRequest> calculateCartList = [];
    widget.listGroupCarts.forEach((groupCartsDto) {
      groupCartsDto.data?.forEach((itemCartDto) {
        if (itemCartDto.isSelected.value) { // Kiểm tra isSelected
          int exchangeRate = AppManager.appSession.exchange!;
          int price = itemCartDto.price!;
          itemCartDto.selectedAmount.value = itemCart.code == itemCartDto.code ? value : itemCartDto.selectedAmount.value;
          String routeCode = itemCartDto.shipMode!;
          int tax = 0;
          int originCountryShippingFee = 0;
          int mode = 1;

          CalculateCartRequest calculateCartRequest = CalculateCartRequest(
            exchangeRate: exchangeRate,
            price: price,
            mode: mode,
            originCountryShippingFee: originCountryShippingFee,
            qty: itemCartDto.selectedAmount.value,
            routeCode: routeCode,
            tax: tax,
            weight: 0,
          );
          calculateCartList.add(calculateCartRequest);
        }
      });
    });
    if (widget.cubit.selectedCount.value != 0) { // Kiểm tra isSelected
      widget.cubit.updateTotal(
          PriceCalculateCartRequest(items: calculateCartList, routeCode: 'JP'),);
    }

    // cập nhật số lượng sản phẩm mới
     itemCart.qty = value;
    ///push API
    widget.cubit.updateItemCart(
      item: itemCart,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dto.data!.isEmpty && widget.dto.data == []) {

      return const SizedBox.shrink();
    } else {
      return ValueListenableBuilder(
        valueListenable: dataItem,
        builder: (context,value,_) {
          if(value.isEmpty){
            return const SizedBox.shrink();
          }
          return Container(
            color: AppColors.white,
            child: Column(
              children: [
                if(dataItem.value[0].siteCode != '')
                ValueListenableBuilder(
                  valueListenable: widget.dto.isSelected,
                  builder: (context, isSelected, _) {
                    return Padding(
                      padding: EdgeInsets.only(left: AppGap.w10, top: AppGap.h5),
                      child: Row(
                        children: [
                          Container(
                            width: 20.w,
                            height: 20.h,
                            margin: EdgeInsets.only(right: AppGap.h5),
                            child: Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              side: const BorderSide(
                                  color: AppColors.neutral300Color, width: 1),
                              activeColor: AppColors.yellow700Color,
                              value: widget.dto.isSelected.value,
                              onChanged: (value) {
                                widget.cubit
                                    .toggleStoreSelection(widget.listGroupCarts,widget.dto, value!);
                              },
                            ),
                          ),
                          Image.asset(AppConvert.pathImg(widget.dto.code!),height: 24.h,width: 24.w,),
                          AppGap.sbW8,
                          ValueListenableBuilder(
                              valueListenable: name,
                              builder: (context, value, _) {
                                return Text(AppStorage.nameStore(dataItem.value[0].siteCode!),
                                    style: AppStyles.text6016());
                              }),
                          Text(
                            ' ( ${widget.dto.selectedCount} sản phẩm )',
                            style: AppStyles.text4012(
                                color: AppColors.neutral800Color),
                          )
                        ],
                      ),
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: ValueNotifier(widget.dto.data),
                  builder: (context, value, Widget? child) {
                    return Column(
                      children: widget.dto.data!.asMap().entries.map((e) {
                        final index = e.key;
                        final model = e.value;
                        return _itemProduct(index, model);
                      }).toList(),
                    );
                  },
                ),
                AppGap.sbH10,
              ],
            ),
          );
        }
      );
    }
  }

  Widget _itemProduct(int index, ItemCartDto item) =>
      Column(
        children: [
          const Divider(
            thickness: 2,
            color: AppColors.neutral300Color,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppGap.sbW8,
              BlocListener<CartItemsCubit, CartItemsState>(
                bloc: widget.cubit,
                listenWhen: (prv,state)=> state is UpdateCartItemsFailed,
                listener: (context, state) {
                 if(state is UpdateCartItemsFailed){
                   item.isSelected.value = false;
                 }
                },
                child: ValueListenableBuilder(
                    valueListenable: item.isSelected,
                    builder: (context, isSelected, _) {
                      return Container(
                        width: 20.w,
                        height: 20.h,
                        margin: EdgeInsets.symmetric(vertical: AppGap.w40),
                        child: Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r)),
                          side: const BorderSide(
                              color: AppColors.neutral300Color, width: 1),
                          activeColor: AppColors.yellow700Color,
                          value: item.isSelected.value,
                          onChanged: ((value) {
                            widget.cubit
                                .toggleItemSelection(widget.listGroupCarts,widget.dto, index, value!,false);
                            item.isSelected.value = value;

                            ///push API
                            widget.cubit.updateItemCart(
                              item: item,
                            );
                            print('có vảo không');
                          }),
                        ),
                      );
                    }),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: AppGap.w106,
                    height: AppGap.h90,
                    margin: EdgeInsets.symmetric(horizontal: AppGap.w10),
                    decoration: BoxDecoration(
                      color: AppColors.neutral200Color,
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppGap.r8),
                      ),
                    ),
                    child: AppCarouselImages(
                      fit: BoxFit.cover,
                      height: AppGap.h90,
                      // ignore: invalid_use_of_protected_member
                      imagesUrl: item.images!,
                      alignment: Alignment.topCenter,
                      borderRadius: BorderRadius.circular(AppGap.r8),
                      autoPlay: false,
                      showIndicatorBottom: false,
                      imageDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(AppGap.r8),
                        ),
                      ),
                    ),
                  ),
                  AppGap.sbH24,
                  GestureDetector(
                    onTap: ()async{
                        final uri = Uri.tryParse(item.url!);
                        if (uri != null) {
                         await  launchUrl(uri);
                        }

                    },
                    child: SizedBox(
                      height: AppGap.h16,
                      child: Text('Xem trên ${name.value}',style:
                      AppStyles.text4010(color: AppColors.yellow900Color).copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.yellow900Color,
                      ),
                                ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AppGap.h128,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: AppGap.w195,
                      child: GestureDetector(
                        onTap: (){
                          switch(widget.nameShop){
                            case 'YAC_JP': RouteService.routeGoOnePage(ProductDetailsScreen(
                              code: item.code!,
                              source: AppConstants.auctionShoppingSource,
                            ),);
                            break;
                            case 'YSP_JP': RouteService.routeGoOnePage(YShoppingDetailProduct(
                              code: item.code!,
                              source: AppConstants.yShoppingSource,
                            ),);
                            break;
                            case 'RAK_JP': RouteService.routeGoOnePage(RakutenDetailProductScreen(
                              code: item.code!,
                              source: AppConstants.rakutenSource,
                            ),);
                            break;
                            case 'MER_JP': RouteService.routeGoOnePage(MarcariDetailProduct(
                              code: item.code!,
                              source: AppConstants.marcariSource,
                            ),);
                            break;
                          }
                        },
                        child: Text(
                          item.name!,
                          style: AppStyles.text5014(
                              color: AppColors.neutral800Color),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ),
                    ),
                    Text(
                      '${AppStrings
                          .of(context)
                          .nation}: Nhật Bản',
                      style:
                      AppStyles.text4012(color: AppColors.neutral600Color),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          AppConvert.convertAmountVn(item.price!),
                          style: AppStyles.text4016(
                              color: AppColors.primary800Color),
                        ),
                        AppGap.sbW8,
                        Text(
                          AppConvert.convertAmountJp(item.price!),
                          style: AppStyles.text4012(
                              color: AppColors.neutral600Color),
                        ),
                      ],
                    ),
                    AppGap.sbH10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ValueListenableBuilder(
                          valueListenable: item.selectedAmount,
                          builder:
                              (BuildContext context, value, Widget? child) {
                            return SpinCarts(
                              selectedAmount: item.selectedAmount,
                              onChanged: (value) =>
                                  handleAmountChanged(value, index,item),
                              readOnly: true,
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: AppGap.w24),
                          child: IconButton(
                            onPressed: () {
                              widget.getCurrentIndex?.call(index);
                            },
                            icon: SvgPicture.asset(AppImages.icTrash),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
}
