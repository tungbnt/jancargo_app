import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../components/bloc/cart/cart_cubit.dart';
import '../../../../components/resource/molecules/app_carousel_image.dart';
import '../../../../data/object_request_api/add_cart/add_cart_request.dart';
import '../../../../domain/dtos/search/search_all/search_all_dto.dart';
import '../../../../domain/dtos/search/search_shop/search_shopping_dto.dart';
import '../../../../domain/services/dialog/dialog_service.dart';
import '../../../../domain/services/navigator/route_service.dart';
import '../../../../general/constants/app_colors.dart';
import '../../../../general/constants/app_constants.dart';
import '../../../../general/constants/app_images.dart';
import '../../../../general/constants/app_styles.dart';
import '../../../../util/app_convert.dart';
import '../../../../util/app_gap.dart';
import '../../../detail_product_y_shopping/screens/detail_product_y_shopping.dart';

class ItemShopping extends StatefulWidget {
  const ItemShopping({super.key, required this.itemsDto, required this.cart});
  final AllSearchItems itemsDto;
  final ValueNotifier<bool> cart;
  @override
  State<ItemShopping> createState() => _ItemShoppingState();
}

class _ItemShoppingState extends State<ItemShopping> {
  AllSearchItems get itemsDto => widget.itemsDto;
  final CartCubit _cartCubit = CartCubit();


  _handleAddCart(AllSearchItems itemsDto) {
    widget.cart.value = !widget.cart.value;
    _cartCubit.addCart(
      AddCartRequest(
          name: itemsDto.name,
          code: itemsDto.code,
          images: [itemsDto.image!],
          description: null,
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
      onTap: ()=>RouteService.routeGoOnePage(YShoppingDetailProduct(code: itemsDto.code!, source: AppConstants.yShoppingSource)),
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
                      imagesUrl: [itemsDto.image!],
                      alignment: Alignment.topCenter,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(AppGap.r8),topLeft: Radius.circular(AppGap.r8),),
                      imageDecoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(AppGap.r8),topLeft: Radius.circular(AppGap.r8),),),
                      autoPlay: false,),
                    // Align(
                    //   alignment: Alignment.topRight,
                    //   child: Row(
                    //     children: [
                    //       Spacer(),
                    //       Padding(
                    //         padding:  EdgeInsets.only(right: AppGap.w20),
                    //         child: ShapeDiscountWidget(cent: itemsDto.),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                  ],
                ),
                Text(itemsDto.name!,style: AppStyles.text4014(color: AppColors.black03),maxLines: 2,overflow: TextOverflow.ellipsis,),
                AppGap.sbH10,
                Text(AppConvert.convertAmountVn(itemsDto.price!),style: AppStyles.text4014(color: AppColors.primary700Color),),

              ],
            ),
            Positioned(
              bottom: -5,
              right: 0,
              child: BlocListener<CartCubit, CartState>(
                bloc: _cartCubit,
                listener: (context, state) {
                  if(state is AddCartSuccess){
                    DialogService.showNotiBannerInfo(context, 'Thêm giỏ thành công!');
                  }else if(state is AddCartFailed){
                    widget.cart.value = false;
                    DialogService.showNotiBannerInfo(context, 'Lỗi thêm vào giỏ!');
                  }
                },
                child: ValueListenableBuilder(
                    valueListenable: widget.cart,
                    builder: (context,value,_) {
                      return IconButton(
                        onPressed: ()=> _handleAddCart(itemsDto),
                        icon: SvgPicture.asset(AppImages.icCartItem,color: value != true ? null : AppColors.primary800Color,),
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
