import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../components/bloc/cart/cart_cubit.dart';
import '../../../../components/resource/molecules/app_carousel_image.dart';
import '../../../../data/object_request_api/add_cart/add_cart_request.dart';
import '../../../../domain/dtos/search/search_all/search_all_dto.dart';
import '../../../../domain/services/dialog/dialog_service.dart';
import '../../../../domain/services/navigator/route_service.dart';
import '../../../../general/constants/app_colors.dart';
import '../../../../general/constants/app_constants.dart';
import '../../../../general/constants/app_images.dart';
import '../../../../general/constants/app_styles.dart';
import '../../../../util/app_convert.dart';
import '../../../../util/app_gap.dart';
import '../../../detail_product_marcari/screens/detail_product_marcari.dart';

class MercariItems extends StatefulWidget {
  const MercariItems({super.key, required this.itemsDto, required this.cart});
  final AllSearchItems itemsDto;
  final ValueNotifier<bool> cart;

  @override
  State<MercariItems> createState() => _MercariItemsState();
}

class _MercariItemsState extends State<MercariItems> {
  final CartCubit _cartCubit = CartCubit();


  _handleAddCart(AllSearchItems itemsDto) {
    widget.cart.value = !widget.cart.value;
    _cartCubit.addCart(
      AddCartRequest(
          name: itemsDto.name,
          code: itemsDto.code,
          images: [itemsDto.image!],
          description: '',
          price: itemsDto.price,
          url: itemsDto.url,
          shipMode: '',
          qty: 1,
          currency: "JPY",
          siteCode: AppConstants.marcariSource),
    );
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => RouteService.routeGoOnePage(
          MarcariDetailProduct(code: widget.itemsDto.code!, source: 'marcari')),
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
                      autoPlay: false,
                    ),
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
                Text(
                  widget.itemsDto.name!,
                  style: AppStyles.text7016(color: AppColors.black03),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(AppConvert.convertAmountVn(widget.itemsDto.price!),
                    style: AppStyles.text7016(color: AppColors.primary700Color),),
                Text(AppConvert.convertAmountJp(widget.itemsDto.price!),
                    style: AppStyles.text4014(color: AppColors.neutral400Color),),

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
                        onPressed: ()=> _handleAddCart(widget.itemsDto),
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
