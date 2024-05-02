import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_mercari/search_mercari_dto.dart';
import 'package:jancargo_app/src/modules/home/bloc/home_cubit.dart';

import '../../../components/bloc/cart/cart_cubit.dart';
import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../components/resource/molecules/btn_seen_all.dart';
import '../../../components/resource/organisms/will_view.dart';
import '../../../data/object_request_api/add_cart/add_cart_request.dart';
import '../../../domain/services/dialog/dialog_service.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_constants.dart';
import '../../../general/constants/app_images.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_convert.dart';
import '../../../util/app_gap.dart';
import '../../detail_product_marcari/screens/detail_product_marcari.dart';
import '../../list_seller/screens/marcaris.dart';

class MercariItems extends StatelessWidget {
  const MercariItems({super.key, required this.dto, required this.cubit});

  final SearchMercariDto dto;
  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return WillView(
      child: Container(
        color: AppColors.white,
        padding: EdgeInsets.all(AppGap.h10),
        margin: EdgeInsets.only(bottom: AppGap.h10),
        child: Column(
          children: [
            _title(),
            AppGap.sbH10,
            _items(),
          ],
        ),
      ),
    );
  }

  Widget _title() => Row(
        children: [
          Container(
            color: AppColors.white,
              padding: EdgeInsets.all(AppGap.w3),
              margin: EdgeInsets.only(right: AppGap.w5),
              child: Image.asset(AppImages.imgMercari,height: 24.h,width: 24.w,),),
          Text(
            'Mercari',
            style: AppStyles.text7018(),
          ),
          const Spacer(),
          SeenAllBtn(
            onTap: ()=>RouteService.routeGoOnePage(Mercaris(
              dto: dto,
              cartDto: cubit.cartDto!,
            )),
          ),
        ],
      );

  Widget _items() => SizedBox(
        height: AppGap.h235,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return _item(dto.data![index]);
            },
            separatorBuilder: (context, i) {
              return AppGap.sbW8;
            },
            itemCount: dto.data!.length),
      );

  Widget _item(MercarisDto itemsDto) => AddCartMercari(itemsDto: itemsDto,);
}

class AddCartMercari extends StatefulWidget {
  const AddCartMercari({super.key, required this.itemsDto,});
  final MercarisDto itemsDto;
  @override
  State<AddCartMercari> createState() => _AddCartMercariState();
}

class _AddCartMercariState extends State<AddCartMercari> {
  final CartCubit _cartCubit = CartCubit();
  ValueNotifier<bool> cart = ValueNotifier(false);

  _handleAddCart(MercarisDto itemsDto) {
    cart.value = true;
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
          siteCode: AppConstants.marcariSource,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{
        var result = await RouteService.routeGoOnePage(
          MarcariDetailProduct(code: widget.itemsDto.code!, source: AppConstants.marcariSource));
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
                      autoPlay: false,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding:  EdgeInsets.only(left: AppGap.w20,top: AppGap.h10),
                        child: Image.asset(AppImages.imgMercari,height: 24.h,width: 24.w,),
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
                    style: AppStyles.text7016(color: AppColors.primary700Color)),
                Text(AppConvert.convertAmountJp(widget.itemsDto.price!),
                    style: AppStyles.text4014(color: AppColors.neutral400Color)),
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

