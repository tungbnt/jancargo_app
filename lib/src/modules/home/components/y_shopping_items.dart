import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_shop/search_shopping_dto.dart';
import 'package:jancargo_app/src/domain/services/dialog/dialog_service.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/modules/home/bloc/home_cubit.dart';

import '../../../components/bloc/cart/cart_cubit.dart';
import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../components/resource/molecules/btn_seen_all.dart';
import '../../../components/resource/organisms/will_view.dart';
import '../../../data/object_request_api/add_cart/add_cart_request.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_constants.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_convert.dart';
import '../../../util/app_gap.dart';
import '../../detail_product_y_shopping/screens/detail_product_y_shopping.dart';
import '../../list_item_store/screens/y_shopping_list_item.dart';

class YShoppingItems extends StatefulWidget {
  const YShoppingItems({super.key, required this.dto, required this.cubit});

  final SearchShoppingDto dto;
  final HomeCubit cubit;

  @override
  State<YShoppingItems> createState() => _YShoppingItemsState();
}

class _YShoppingItemsState extends State<YShoppingItems> {


  @override
  Widget build(BuildContext context) {
    return WillView(
      child: Container(
          color: AppColors.white,
          margin: EdgeInsets.only(bottom: AppGap.h10),
          padding: EdgeInsets.all(AppGap.h10),
          child: Column(
            children: [
              _title(),
              AppGap.sbH10,
              _items(),
            ],
          )),
    );
  }

  Widget _title() => Row(
        children: [
          Container(
              color: AppColors.white,
              padding: EdgeInsets.all(AppGap.w3),
              margin: EdgeInsets.only(right: AppGap.w5),
              child: Image.asset(AppImages.imgShopping,height: 24.h,width: 24.w,),),
          Text(
            'Y!Shopping',
            style: AppStyles.text7018(),
          ),
          const Spacer(),
          SeenAllBtn(
            onTap: () => RouteService.routeGoOnePage( YShoppingListItem(cartDto: widget.cubit.cartDto!,)),
          ),
        ],
      );

  Widget _items() => SizedBox(
        height: AppGap.h235,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return _item(widget.dto.results![index]);
            },
            separatorBuilder: (context, i) {
              return AppGap.sbW8;
            },
            itemCount: widget.dto.results!.length),
      );

  Widget _item(ItemsShoppingDto itemsDto) => AddCartYShopping(itemsDto: itemsDto,);
}

class AddCartYShopping extends StatefulWidget {
  const AddCartYShopping({super.key, required this.itemsDto,});
  final ItemsShoppingDto itemsDto;


  @override
  State<AddCartYShopping> createState() => _AddCartYShoppingState();
}

class _AddCartYShoppingState extends State<AddCartYShopping> {
  final CartCubit _cartCubit = CartCubit();
  ValueNotifier<bool> cart = ValueNotifier(false);

  _handleAddCart(ItemsShoppingDto itemsDto) {
    cart.value = true;
    _cartCubit.addCart(
      AddCartRequest(
              name: itemsDto.name,
          code: itemsDto.code,
          images: [itemsDto.image!],
          description: itemsDto.description,
          price: itemsDto.price,
          url: itemsDto.url,
          shipMode: '',
          qty: 1,
          currency: "JPY",
          siteCode: AppConstants.yShoppingSource),
    );
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{
       var result = await RouteService.routeGoOnePage(YShoppingDetailProduct(
          code: widget.itemsDto.code!, source: AppConstants.yShoppingSource));
        if(result){
          cart.value = true;
        }
      },
      child: Ink(
        width: AppGap.w144,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    AppCarouselImages(
                      height: AppGap.h144,
                      // ignore: invalid_use_of_protected_member
                      imagesUrl: [widget.itemsDto.image!],
                      alignment: Alignment.topCenter,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(AppGap.r8),
                        topLeft: Radius.circular(AppGap.r8),
                      ),
                      imageDecoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(AppGap.r8),
                          topLeft: Radius.circular(AppGap.r8),
                        ),
                      ),
                      autoPlay: false,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: AppGap.w20, top: AppGap.h16),
                        child: Image.asset(AppImages.imgShopping,height: 24.h,width: 24.w,),
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.itemsDto.name!,
                  style: AppStyles.text7016(color: AppColors.black03),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(AppConvert.convertAmountVn(widget.itemsDto.price!),
                    style:
                    AppStyles.text7016(color: AppColors.primary700Color)),
                Text(AppConvert.convertAmountJp(widget.itemsDto.price!),
                    style:
                    AppStyles.text4014(color: AppColors.neutral400Color)),
              ],
            ),
            Positioned(
              bottom: -5,
              right: 0,
              child: BlocListener<CartCubit, CartState>(
                bloc: _cartCubit,
                listener: (context, state) {
                  if(state is AddCartSuccess){
                    // cart.value = true;
                    DialogService.showNotiBannerInfo(context, 'Thêm giỏ thành công!');
                  }else if(state is AddCartFailed){
                    cart.value = false;
                    DialogService.showNotiBannerInfo(context, 'Lỗi thêm vào giỏ!');
                  }
                },
                child: ValueListenableBuilder(
                  valueListenable: cart,
                  builder: (context,value,_) {
                    return IconButton(
                      onPressed: ()=> _handleAddCart(widget.itemsDto),
                      icon: SvgPicture.asset(AppImages.icCartItem,color: widget.itemsDto.isItemSavedCart == null || widget.itemsDto.isItemSavedCart == false ? (cart.value ? AppColors.primary800Color : null)  : AppColors.primary800Color,),
                    );
                  }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

