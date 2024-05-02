import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jancargo_app/src/components/bloc/cart/cart_cubit.dart';
import 'package:jancargo_app/src/data/object_request_api/add_cart/add_cart_request.dart';
import 'package:jancargo_app/src/domain/dtos/cart/item_cart/item_cart_dto.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_shop/search_shopping_dto.dart';
import 'package:jancargo_app/src/domain/services/dialog/dialog_service.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/modules/detail_product_y_shopping/screens/detail_product_y_shopping.dart';
import 'package:jancargo_app/src/modules/list_seller/bloc/y_shopping/y_shopping_cubit.dart';

import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../components/resource/molecules/smart_refresher_custom.dart';
import '../../../components/resource/organisms/will_refresh_view.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_constants.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_convert.dart';
import '../../../util/app_gap.dart';

class YShoppingListItem extends StatefulWidget {
  const YShoppingListItem({
    super.key, required this.cartDto,
  });
  final CartDto cartDto;

  @override
  State<YShoppingListItem> createState() => _YShoppingListItemState();
}

class _YShoppingListItemState extends State<YShoppingListItem> {
  final YShoppingCubit _cubit = YShoppingCubit();

  @override
  void initState() {
    super.initState();
    _cubit.cartDto = widget.cartDto;
    _cubit.load();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral300Color,
      extendBody: true,
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: AppColors.white,
        leading: InkWell(
          highlightColor: Colors.transparent,
          onTap: () => RouteService.pop(),
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.black03,
          ),
        ),
        title: Text(
          'Y!Shopping',
          style: AppStyles.text7018(),
        ),
        centerTitle: true,
      ),
      body: WillRefreshView(
        child: _items(),
      ),
    );
  }

  Widget _items() => BlocConsumer<YShoppingCubit, YShoppingState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is YShoppingDataSuccess) {
            _cubit.results!.addAll(state.dto!.results!);
          }
        },
        buildWhen: (prv, state) =>
            state is YShoppingDataSuccess || state is YShoppingLoading,
        builder: (context, state) {
          if (state is YShoppingLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is YShoppingDataSuccess) {
            return CustomSmartRefresher(
              controller: _cubit.refreshController,
              onLoading: () async {
                _cubit.load();
              },
              onRefresh: () async {
                _cubit.refreshList();
              },
              enablePullDown: true,
              enablePullUp: true,
              child: Container(
                color: AppColors.white,
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.symmetric(
                        horizontal: AppGap.h5, vertical: AppGap.h10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: AppGap.h5,
                        mainAxisSpacing: AppGap.h5,
                        mainAxisExtent: AppGap.h275),
                    itemBuilder: (context, index) {
                      return _item(state.dto!.results![index]);
                    },
                    itemCount: state.dto!.results!.length),
              ),
            );
          }
          return const SizedBox.shrink();
        },
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
