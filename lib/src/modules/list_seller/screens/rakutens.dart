import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jancargo_app/src/components/bloc/cart/cart_cubit.dart';
import 'package:jancargo_app/src/components/widget/custom_refresh_indicator.dart';
import 'package:jancargo_app/src/components/widget/will_scroll_position_change.dart';
import 'package:jancargo_app/src/data/object_request_api/add_cart/add_cart_request.dart';
import 'package:jancargo_app/src/domain/dtos/cart/item_cart/item_cart_dto.dart';
import 'package:jancargo_app/src/domain/services/dialog/dialog_service.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/modules/detail_product_rakuten/screens/detail_product_rakuten.dart';
import 'package:jancargo_app/src/modules/list_seller/bloc/rakutens/rakuten_cubit.dart';
import 'package:jancargo_app/src/modules/web_view/screen/web_view.dart';

import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../components/resource/molecules/custom_timer.dart';
import '../../../components/resource/molecules/smart_refresher_custom.dart';
import '../../../components/resource/organisms/will_refresh_view.dart';
import '../../../domain/dtos/search/search_rakuten/search_rakuten_dto.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_constants.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_convert.dart';
import '../../../util/app_gap.dart';

class Rakutens extends StatefulWidget {
  const Rakutens({super.key, required this.dto, required this.cartDto});

  final SearchRakutenDto dto;
  final CartDto cartDto;

  @override
  State<Rakutens> createState() => _RakutensState();
}

class _RakutensState extends State<Rakutens> {
  final RakutenCubit _cubit = RakutenCubit();
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    _cubit.dto = widget.dto;
    _cubit.cartDto = widget.cartDto;
  }

  @override
  void dispose() {
    super.dispose();
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
          'Rakuten',
          style: AppStyles.text7018(),
        ),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          _items(),
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: Container(
          //     color: AppColors.white,
          //     width: double.infinity,
          //     height: AppGap.h40,
          //     alignment: Alignment.center,
          //     padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Icon(
          //           Icons.access_time,
          //           size: AppGap.w40,
          //         ),
          //         AppGap.sbW8,
          //         Text('Kết thúc trong', style: AppStyles.text4017()),
          //         const Spacer(),
          //         CountdownScreen(dateTime: ,),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget _items() => CustomRefreshIndicator(
      onRefresh: () {
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
                child: BlocListener<RakutenCubit, RakutenState>(
                  bloc: _cubit,
                  listener: (context, state) {
                    if (state is RakutenDataSuccess) {
                      setState(() {
                        widget.dto.data!.addAll(state.searchRakutenDto!.data!);
                      });
                    }
                  },
                  child: SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: AppGap.h5,
                        mainAxisSpacing: AppGap.h5,
                        mainAxisExtent: AppGap.h275),
                    itemCount: widget.dto.data!.length,
                    itemBuilder: (context, index) =>
                        _item(widget.dto.data![index]),
                  ),
                ),
              ),
            ],
          ),
        );
      });

  Widget _item(RakutensDto itemsDto) => AddCartRakuten(
        itemsDto: itemsDto,
      );
}

class AddCartRakuten extends StatefulWidget {
  const AddCartRakuten({
    super.key,
    required this.itemsDto,
  });

  final RakutensDto itemsDto;

  @override
  State<AddCartRakuten> createState() => _AddCartRakutenState();
}

class _AddCartRakutenState extends State<AddCartRakuten> {
  final CartCubit _cartCubit = CartCubit();
  ValueNotifier<bool> cart = ValueNotifier(false);

  _handleAddCart(RakutensDto itemsDto) {
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
        siteCode: AppConstants.rakutenSource,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var result =
            await RouteService.routeGoOnePage(RakutenDetailProductScreen(
          code: widget.itemsDto.code!,
          source: AppConstants.rakutenSource,
        ));
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
                            EdgeInsets.only(left: AppGap.w20, top: AppGap.h16),
                        child: Image.asset(
                          AppImages.imgRakuten,
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
