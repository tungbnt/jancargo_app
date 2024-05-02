import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jancargo_app/src/components/resource/molecules/shimmer_sale.dart';
import 'package:jancargo_app/src/domain/dtos/favorite/favorite_dto.dart';
import 'package:jancargo_app/src/domain/services/dialog/dialog_service.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/modules/cart/screens/cart_screens.dart';
import 'package:jancargo_app/src/modules/detail_product_marcari/screens/detail_product_marcari.dart';
import 'package:jancargo_app/src/modules/detail_product_rakuten/screens/detail_product_rakuten.dart';
import 'package:jancargo_app/src/modules/detail_product_y_shopping/screens/detail_product_y_shopping.dart';
import 'package:jancargo_app/src/modules/details_product_auction/screens/details_product_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/bloc/cart/cart_cubit.dart';
import '../../../components/bloc/favorite/favorite_cubit.dart';
import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../data/object_request_api/add_cart/add_cart_request.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_storage.dart';
import '../../../general/constants/app_styles.dart';
import '../../../general/utils/model_func_utils.dart';
import '../../../util/app_convert.dart';
import '../../../util/app_gap.dart';
import '../../payment_oders/screens/payment_oders_screen.dart';

class FavoriteItem extends StatefulWidget {
  const FavoriteItem({super.key, required this.item, required this.cubit, required this.getIndex, required this.index});

  final FavoriteItems item;
  final FavoriteCubit cubit;
  final ValueSetter<int> getIndex;
  final int index;

  @override
  State<FavoriteItem> createState() => _FavoriteItemState();
}

class _FavoriteItemState extends State<FavoriteItem> {
  ValueNotifier<String> name = ValueNotifier('Đang cập nhật');
  final CartCubit cubitCart = CartCubit();

  @override
  void initState() {
    super.initState();
    nameStore();
  }

  void nameStore() async {
    name.value = await AppStorage.nameStore(widget.item.siteCode!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          _title(),
          _itemProd(),
          _btn(),
        ],
      ),
    );
  }

  Widget _title() => ValueListenableBuilder(
      valueListenable: name,
      builder: (context, value, Widget? child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppGap.w10,vertical: AppGap.h5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(AppConvert.pathImg(widget.item.siteCode!),height: 24.h,width: 24.w,),
                  AppGap.sbW8,
                  Text(
                    name.value,
                    style: AppStyles.text7018(),
                  ),
                ],
              ),
              GestureDetector(
                onTap: (){
                    final uri = Uri.tryParse(widget.item.url!);
                    if (uri != null) {
                      launchUrl(uri);
                    }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Xem bản gốc',
                      style: AppStyles.text5012(color: AppColors.primary800Color),
                    ),
                   SvgPicture.asset(AppImages.icArrowight,color: AppColors.primary800Color,),
                  ],
                ),
              ),
            ],
          ),
        );
      });

  Widget _itemProd() => Padding(
        padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 25.w,
                  height: 25.h,
                  margin: EdgeInsets.symmetric(vertical: AppGap.w40),
                  child: Checkbox(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r)),
                    side: const BorderSide(
                        color: AppColors.neutral300Color, width: 1),
                    activeColor: AppColors.yellow700Color,
                    value: widget.item.status ?? false,
                    onChanged: ((value) {}),
                  ),
                ),
                Container(
                  width: AppGap.w90,
                  height: AppGap.h78,
                  margin: EdgeInsets.symmetric(horizontal: AppGap.w10),
                  decoration: BoxDecoration(
                    color: AppColors.neutral200Color,
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppGap.r8),
                    ),
                  ),
                  child: AppCarouselImages(
                    fit: BoxFit.cover,
                    height: AppGap.h78,
                    // ignore: invalid_use_of_protected_member
                    imagesUrl: widget.item.images!,
                    alignment: Alignment.topCenter,
                    borderRadius: BorderRadius.circular(AppGap.r8),
                    autoPlay: false,
                    showIndicatorBottom: false,
                    imageDecoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(AppGap.r8))),
                  ),
                ),
                Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: AppGap.w195,
                          child: GestureDetector(
                            onTap: (){
                              switch(widget.item.siteCode){
                                case 'YAC_JP': RouteService.routeGoOnePage(ProductDetailsScreen(
                                  code: widget.item.code!,
                                  source: AppConstants.auctionShoppingSource,
                                ),);
                                break;
                                case 'YSP_JP': RouteService.routeGoOnePage(YShoppingDetailProduct(
                                  code: widget.item.code!,
                                  source: AppConstants.yShoppingSource,
                                ),);
                                break;
                                case 'RAK_JP': RouteService.routeGoOnePage(RakutenDetailProductScreen(
                                  code: widget.item.code!,
                                  source: AppConstants.rakutenSource,
                                ),);
                                break;
                                case 'MER_JP': RouteService.routeGoOnePage(MarcariDetailProduct(
                                  code: widget.item.code!,
                                  source: AppConstants.marcariSource,
                                ),);
                                break;
                              }
                            },
                            child: Text(
                              widget.item.name!,
                              style: AppStyles.text5014(
                                  color: AppColors.neutral800Color),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                            ),
                          ),
                        ),
                        AppGap.sbH5,
                        Text('${AppStrings.of(context).nation}: Nhật Bản',
                            style: AppStyles.text4012(
                                color: AppColors.neutral600Color)),
                        AppGap.sbH5,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              AppConvert.convertAmountVn(widget.item.price!),
                              style: AppStyles.text4016(
                                  color: AppColors.primary800Color),
                            ),
                            AppGap.sbW8,
                            Text(AppConvert.convertAmountJp(widget.item.price!),
                                style: AppStyles.text4012(
                                    color: AppColors.neutral600Color)),


                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: -12,
                      right: -15,
                      child:  IconButton(onPressed: (){
                      widget.cubit.deletedFavorites();
                      widget.getIndex.call(widget.index);
                    }, icon: SvgPicture.asset(AppImages.icTrash),),),
                  ],
                )
              ],
            ),
            const Divider(),
          ],
        ),
      );

  Widget _btn() => Padding(
        padding: EdgeInsets.only(
          left: AppGap.w10,
          bottom: AppGap.h16,
          right: AppGap.w10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppConvert.convertStringDateTime(widget.item.createdDate!),
              style: AppStyles.text4012(),
            ),
            ValueListenableBuilder(
              builder: (context, value, Widget? child) {
                return switch (name.value) {
                  'YAC_JP' => _btnCustom((){},'Đấu giá', AppColors.yellow800Color,
                      AppColors.yellow800Color),
                  _ => Row(
                      children: [
                        BlocListener<CartCubit, CartState>(
                          bloc: cubitCart,
                          listener: (context, state) {
                            if(state is CartLoading){
                              openDialogBox(
                                  context,
                                  const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.yellow800Color,
                                    ),
                                  ),
                                  isBarrierDismissible: true);
                            }else if(state is AddCartSuccess){
                              RouteService.pop();
                              DialogService.showNotiBannerSuccess(context, 'Thêm vào giỏ thành công!');
                            }
                          },
                          child: _btnCustom(() {
                            cubitCart.addCart(AddCartRequest(
                              name: widget.item.name,
                              code: widget.item.code,
                              images: widget.item.images,
                              description: '',
                              price: widget.item.price,
                              url: widget.item.url,
                              shipMode: "AIR-HAN",
                              qty: 1,
                              currency: widget.item.currency,
                              siteCode: widget.item.siteCode),);

                          },'Thêm giỏ hàng', AppColors.white,
                              AppColors.neutral800Color),
                        ),
                        AppGap.sbW8,
                        _btnCustom(() {
                          RouteService.routeGoOnePage(
                          CartScreen(),
                        );
                        },'Mua ngay', AppColors.yellow800Color,
                            AppColors.yellow800Color),
                      ],
                    ),
                };
              },
              valueListenable: name,
            )
          ],
        ),
      );

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
