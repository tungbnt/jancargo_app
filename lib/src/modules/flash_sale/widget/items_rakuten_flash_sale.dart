import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jancargo_app/src/components/bloc/cart/cart_cubit.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:slivers/slivers.dart';

import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../components/resource/molecules/btn_seen_all.dart';
import '../../../components/resource/molecules/flash_sale_timer.dart';
import '../../../components/resource/molecules/widget_shape_discount.dart';
import '../../../data/object_request_api/add_cart/add_cart_request.dart';
import '../../../domain/dtos/dashboard/flash_sale/flash_sale_dto.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_constants.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_gap.dart';
import '../../detail_product_rakuten/screens/detail_product_rakuten.dart';
import '../screen/big_day_screen.dart';

class ItemsRakutenFlashSale extends StatelessWidget {
  const ItemsRakutenFlashSale({super.key, required this.dto});

  final FlashSaleDto dto;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SliverToBoxAdapter(
      child: Container(
          decoration: BoxDecoration(color: AppColors.white,),
          padding: EdgeInsets.all(AppGap.h10),
          margin: EdgeInsets.only(bottom: AppGap.h10),
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
      Image.asset(AppImages.imgRakuten,height: 24.h,width: 24.w,),
      AppGap.sbW8,
      Text(
        'Rakuten',
        style: AppStyles.text6016(),
      ),
      AppGap.sbW8,
      const FlashSaleTimer(),
      const Spacer(),
      SeenAllBtn(onTap: () => RouteService.routeGoOnePage(BigDayScreen(dto: dto,))),
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

  Widget _item(ItemSaleDto itemsDto) {
    bool isBoolCart = false;

    return InkWell(
    onTap: (){
      RouteService.routeGoOnePage(RakutenDetailProductScreen(code: itemsDto.code!, source: 'RAK_JP',),);

    },
    child: Stack(
      children: [
        SizedBox(
          width: AppGap.w144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AppCarouselImages(
                    height: AppGap.h144,
                    // ignore: invalid_use_of_protected_member
                    imagesUrl: [itemsDto.image!],
                    alignment: Alignment.topCenter,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(AppGap.r8),
                      topLeft: Radius.circular(AppGap.r8),
                    ),
                    autoPlay: false,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      children: [
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: AppGap.w20),
                          child: ShapeDiscountWidget(
                            cent: itemsDto.discountRate!.toString(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding:  EdgeInsets.only(left: AppGap.w20,top: AppGap.h16),
                      child: Image.asset(AppImages.imgRakuten,height: 24.h,width: 24.w,),
                    ),
                  ),
                ],
              ),
              Text(
                itemsDto.name!,
                style: AppStyles.text7016(color: AppColors.black03),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(AppConvert.convertAmountVn(itemsDto.price!),
                  style: AppStyles.text7016(color: AppColors.primary700Color)),
              Text(AppConvert.convertAmountJp(itemsDto.price!),
                  style:
                  AppStyles.text4014(color: AppColors.neutral400Color)),
            ],
          ),
        ),
        Positioned(right: 0,bottom: -10,child:  BlocProvider(
          create: (context) => CartCubit(),
          child: BlocBuilder<CartCubit, CartState>(
            buildWhen: (prv,state)=> state is AddCartSuccess || state is CartLoading,
            builder: (context, state) {
              var isLoading = false;
              var isSuccess = false;
              if(state is AddCartSuccess){
                isLoading = false;
                isBoolCart = true;
              }else if(state is CartLoading){
                isLoading = true;
              }else{
                isLoading = false;
                isBoolCart = false;
              }
              return isLoading
                  ? CupertinoActivityIndicator()
                  : IconButton(
                  onPressed: () => context.read<CartCubit>().addCart(
                    AddCartRequest(
                      name: itemsDto.name,
                      code: itemsDto.code,
                      images: itemsDto.thumbnails,
                      description: itemsDto.description,
                      price: itemsDto.price,
                      url: itemsDto.url,
                      shipMode: '',
                      qty: 1,
                      currency: "JPY",
                      siteCode: AppConstants.rakutenSource,
                    ),
                  ),
                  icon: SvgPicture.asset(AppImages.icBasket,color: itemsDto.isItemSavedCart == null || itemsDto.isItemSavedCart == false ? (isBoolCart == true ? AppColors.primary800Color : null) :  AppColors.primary800Color,height: 20,width: 20,));
            },
          ),
        ),)
      ],
    ),
  );
  }
}
