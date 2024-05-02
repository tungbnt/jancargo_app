import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jancargo_app/src/components/bloc/cart/cart_cubit.dart';
import 'package:jancargo_app/src/components/widget/custom_refresh_indicator.dart';
import 'package:jancargo_app/src/components/widget/will_scroll_position_change.dart';
import 'package:jancargo_app/src/data/object_request_api/add_cart/add_cart_request.dart';
import 'package:jancargo_app/src/domain/dtos/cart/item_cart/item_cart_dto.dart';
import 'package:jancargo_app/src/domain/services/dialog/dialog_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/modules/detail_product_marcari/screens/detail_product_marcari.dart';
import 'package:jancargo_app/src/modules/list_seller/bloc/marcari/marcari_cubit.dart';
import 'package:jancargo_app/src/modules/web_view/screen/web_view.dart';

import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../components/resource/organisms/will_refresh_view.dart';
import '../../../domain/dtos/search/search_mercari/search_mercari_dto.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_constants.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_convert.dart';
import '../../../util/app_gap.dart';

class Mercaris extends StatefulWidget {
  const Mercaris({super.key, required this.dto, required this.cartDto});

  final SearchMercariDto dto;
  final CartDto cartDto;

  @override
  State<Mercaris> createState() => _MercarisState();
}

class _MercarisState extends State<Mercaris> {
  final MarcariCubit _cubit = MarcariCubit();
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    _cubit.dto = widget.dto;
    controller = ScrollController();
    _cubit.cartDto = widget.cartDto;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral200Color,
      extendBody: true,
      appBar: AppBar(
        bottomOpacity: 0.0,
        backgroundColor: AppColors.white,
        leading: IconButton(
          highlightColor: Colors.transparent,
          onPressed: () => RouteService.pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.black03,
          ),
        ),
        title: Text(
          'Mercari',
          style: AppStyles.text7018(),
        ),
        centerTitle: true,
      ),
      body: CustomRefreshIndicator(

          onRefresh: () {
            print('có vào đây');
            return _cubit.load();
          },
          indicator: LoadingSpinkit(),
          builder: (context, bool isbool) {
            return PrimaryScrollController(
              controller: controller,
              child: CustomScrollView(
                  slivers: [
                    WillScrollPositionChange(
                  onNextExtent: () {
                    _cubit.load();
                  },
                  onEnd: () {
                    _cubit.load();
                  },
                  designItemExtent: 500,
                  child: _items())]),
            );
          }),
    );
  }

  Widget _items() => BlocListener<MarcariCubit,MarcariState>(
    bloc: _cubit,
    listenWhen: (prv,state)=> state is MarcariDataSuccess || state is MarcariEmptyData,
    listener: (prv,state){
      if(state is MarcariDataSuccess){
        _cubit.dto.data!.addAll(state.dto!.data!);
        setState(() {

        });
      }else if(state is MarcariEmptyData){
        DialogService.showNotiBannerInfo(context, 'Không tải thêm dữ liệu!');
      }
    },
    child: SliverGrid.builder(

          itemBuilder: (context, index) {
            return _item(_cubit.dto.data![index]);
          },
          itemCount: _cubit.dto.data!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              mainAxisExtent: AppGap.w255,
              crossAxisSpacing: AppGap.w10,
              mainAxisSpacing: AppGap.h10),
        ),
  );

  Widget _item(MercarisDto itemsDto) => AddCartMercari(
        itemsDto: itemsDto,
      );
}

class AddCartMercari extends StatefulWidget {
  const AddCartMercari({
    super.key,
    required this.itemsDto,
  });

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
      onTap: () async {
        var result = await RouteService.routeGoOnePage(MarcariDetailProduct(
            code: widget.itemsDto.code!, source: AppConstants.marcariSource));
        if (result) {
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
                        padding:
                            EdgeInsets.only(left: AppGap.w20, top: AppGap.h10),
                        child: Image.asset(
                          AppImages.imgMercari,
                          height: 24.h,
                          width: 24.w,
                        ),
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
                  if (state is AddCartSuccess) {
                    DialogService.showNotiBannerInfo(
                        context, 'Thêm giỏ thành công!');
                  } else if (state is AddCartFailed) {
                    cart.value = false;
                    DialogService.showNotiBannerInfo(
                        context, 'Lỗi thêm vào giỏ!');
                  }
                },
                child: ValueListenableBuilder(
                    valueListenable: cart,
                    builder: (context, value, _) {
                      return IconButton(
                        onPressed: () => _handleAddCart(widget.itemsDto),
                        icon: SvgPicture.asset(
                          AppImages.icCartItem,
                          color: widget.itemsDto.isItemSavedCart == null ||
                                  widget.itemsDto.isItemSavedCart == false
                              ? (cart.value ? AppColors.primary800Color : null)
                              : AppColors.primary800Color,
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
