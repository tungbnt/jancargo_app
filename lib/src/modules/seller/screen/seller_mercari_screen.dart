import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slivers/slivers.dart';

import '../../../components/bloc/cart/cart_cubit.dart';
import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../components/resource/molecules/cached_network_shaped_image.dart';
import '../../../data/object_request_api/add_cart/add_cart_request.dart';
import '../../../domain/dtos/seller/seller_mercari/seller_mercari_dto.dart';
import '../../../domain/services/dialog/dialog_service.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_constants.dart';
import '../../../general/constants/app_images.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_convert.dart';
import '../../../util/app_gap.dart';
import '../../detail_product_marcari/screens/detail_product_marcari.dart';
import '../../searchs/widget/field_search.dart';
import '../bloc/mercari/seller_mercari_cubit.dart';

class SellerMercariScreen extends StatefulWidget {
  const SellerMercariScreen({super.key, required this.sellerId, required this.sellerName});
  final String sellerId;
  final String sellerName;
  @override
  State<SellerMercariScreen> createState() => _SellerMercariScreenState();
}

class _SellerMercariScreenState extends State<SellerMercariScreen> {
  final SellerMercariCubit _cubit = SellerMercariCubit();

  @override
  void initState() {
    super.initState();
    _cubit.getSellerMercari(widget.sellerId,widget.sellerName);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.neutral200Color,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title:  Text(widget.sellerName,style: AppStyles.text6016(),overflow: TextOverflow.ellipsis,),
        centerTitle: true,
      ),
      body: BlocBuilder<SellerMercariCubit, SellerMercariState>(
        bloc: _cubit,
        builder: (context, state) {
          if(state is SellerDetailProductLoading){
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is SellerSuccessProduct){
            return CustomScrollView(
              slivers: [
                _fieldSearch(
                      (keyword) {
                    if (keyword.isEmpty && keyword == '') {} else {
                      _cubit.getSellerMercari(keyword,widget.sellerName);
                    }
                  },
                ),
                _infoStore(),
                _itemContainer(),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );

  }

  Widget _infoStore() {
    return SliverToBoxAdapter(
      child: BlocBuilder<SellerMercariCubit, SellerMercariState>(
          bloc: _cubit,
          buildWhen: (prv, state) => state is SellerSuccessProduct ,
          builder: (context, state) {
            if (state is SellerSuccessProduct) {
              return _itemStore(state.sellerDetailMercariDto!.data!.seller!.avatar!, state.sellerDetailMercariDto!.data!.seller!.name!, state.sellerDetailMercariDto!.data!.seller!.ratings!.good!);
            }
            return const SizedBox.shrink();
          }

      ),
    );
  }


  Widget _itemStore(String avt,String name,double month)=> Container(
    decoration: const BoxDecoration(color: AppColors.white),
    padding: EdgeInsets.symmetric(
        horizontal: AppGap.w10, vertical: AppGap.h10),
    margin: EdgeInsets.only(
        bottom: AppGap.h10),
    // height: 300,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppGap.h48,
              width: AppGap.w48,
              child: ClipRRect(
                borderRadius:
                BorderRadius.all(Radius.circular(AppGap.r4)),
                child: CachedNetworkRectangleImage(
                  imageDecoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.circular(AppGap.r4)),
                  ),
                  imageUrl: avt,
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.center,
                  errorWidget: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.neutral200Color),
                        shape: BoxShape.circle),
                    child: SvgPicture.asset(
                      AppImages.logoLogin,
                    ),
                  ),
                ),
              ),
            ),
            AppGap.sbW8,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(name),
                Row(
                  children: [
                    Text(
                        "Đánh giá: $month | Uy tín: $month"),
                  ],
                ),
              ],
            )
          ],
        ),
        Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: AppGap.h32,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: AppColors.greenColor.withOpacity(0.3),
              border: Border.all(color: AppColors.greenColor)),
          child:  Text("Mức độ uy tín cao",style: AppStyles.text4014(color: AppColors.neutral800Color),),
        ),
        AppGap.sbH10,
        SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _btn( Text('Xem chi tiết',style: AppStyles.text4012(),)),
              _btn(
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppImages.icHeart,height: 16,width: 16,),
                    AppGap.sbW8,
                    Text('Yêu thích',style: AppStyles.text4012(),)],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _btn(Widget child) => Container(
    width: AppGap.w163,
    height: AppGap.h24,
    decoration: BoxDecoration(
      color: AppColors.white,
      border: Border.all(color: AppColors.neutral400Color),borderRadius: BorderRadius.all(Radius.circular(AppGap.r4),),),
    alignment: Alignment.center,
    child: child,
  );


  Widget _fieldSearch(ValueSetter<String> onChange,) =>
      SliverToBoxAdapter(
        child: ValueListenableBuilder(
            valueListenable: _cubit.controller!,
            builder: (context, _, __) {
              return FieldSearch(
                onChange: onChange,
                controller: _cubit.controller!.value,
              );
            }),
      );

  Widget _itemContainer() =>
      BlocBuilder<SellerMercariCubit, SellerMercariState>(
        bloc: _cubit,
        buildWhen: (prv,state)=> state is SellerSuccessProduct,
        builder: (context, state) {
          if(state is SellerSuccessProduct){
            return SliverContainer(
              decoration: const BoxDecoration(color: AppColors.white),
              sliver: SliverGroup(
                slivers: [
                  _nameStore(),
                  _searchResult(state.sellerDetailMercariDto!.data!),
                ],
              ),
            );
          }
          return const SliverToBoxAdapter(child: SizedBox.shrink(),);
        },
      );

  Widget _nameStore() =>
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppGap.h10, horizontal: AppGap.w10),
          child: Row(
            children: [
              Image.asset(AppImages.imgMercari,height: 24.h,width: 24.w,),
              AppGap.sbW8,
              Text(
                'Mercari',
                style: AppStyles.text6016(),
              )
            ],
          ),
        ),
      );

  Widget _searchResult(SellerMercariDto dto) =>
      SliverGrid.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: AppGap.h5,
              mainAxisSpacing: AppGap.h5,
              mainAxisExtent: AppGap.h245),
          itemBuilder: (context, index) {
            return _items(dto.products![index]);
          },
          itemCount: dto.products!.length);

  Widget _items(ItemsSellerMercariDto itemsDto) => AddCartSellerMercari(itemsDto: itemsDto,cart: ValueNotifier(false),);

  Widget _btnCustom(void Function()? onTap,String name, Color btnColors, Color borderColors) =>
      InkWell(
        onTap: onTap,
        child: Container(
          width: AppGap.w90,
          height: AppGap.h32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: btnColors,
              borderRadius: BorderRadius.circular(AppGap.r4),
              border: Border.all(width: 1, color: borderColors)),
          child: Text(
            name,
            style: AppStyles.text4012(color: AppColors.neutral800Color),
            textAlign: TextAlign.center,
          ),
        ),
      );
}

class AddCartSellerMercari extends StatefulWidget {
  const AddCartSellerMercari({super.key, required this.itemsDto, required this.cart});
  final ItemsSellerMercariDto itemsDto;
  final ValueNotifier<bool> cart;
  @override
  State<AddCartSellerMercari> createState() => _AddCartSellerMercariState();
}

class _AddCartSellerMercariState extends State<AddCartSellerMercari> {
  final CartCubit _cartCubit = CartCubit();


  _handleAddCart(ItemsSellerMercariDto itemsDto) {
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
        siteCode: AppConstants.marcariSource,
      ),
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
