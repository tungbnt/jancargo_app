import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/all_search/all_search_cubit.dart';

import '../../../../domain/dtos/search/search_all/search_all_dto.dart';
import '../../../../general/constants/app_colors.dart';
import '../../../../util/app_gap.dart';
import '../item_search_all/auction_item.dart';
import '../item_search_all/mercari_item.dart';
import '../item_search_all/paypay.dart';
import '../item_search_all/rakuten_item.dart';
import '../item_search_all/shopping_item.dart';

class SearchAll extends StatelessWidget {
  const SearchAll({super.key, required this.dto, required this.cubit});

  final SearchAllDto dto;
  final AllSearchCubit cubit;
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: dto.data!.length,
      itemBuilder: (context, index) {
        final site = dto.data![index];
        return _itemSite(site);
      },
    );
  }

  Widget _itemSite(AllSearchs site) {
    return switch (site.type) {
      "auction" => _itemsAuction(site),
      "shopping" => _itemShopping(site),
      "rakuten" => _itemRakuten(site),
      "mercari" => _itemMercari(site),
      // "amazon" => _items(site),
      // "amazon-us" => _items(site),
      "paypay" => _itemPaypay(site),
      _ => const SizedBox.shrink(),
    };
  }

  Widget _itemsAuction(AllSearchs dto) => Container(

        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        child: Column(
          children: [
            _nameSiteAllItem('Y! Auction: ${dto.total!}',AppImages.imgAuction,onTap: (){
              cubit.changeTab(1);
            }),
            SizedBox(
              height: AppGap.h240,
              child: GridView.builder(
                primary: false,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
                itemBuilder: (context, index) => ItemAuction(
                  itemsDto: dto.products![index],
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 3 / 2,
                  mainAxisExtent: AppGap.w174,
                  crossAxisSpacing: AppGap.h5,
                  mainAxisSpacing: AppGap.h5,
                ),
                itemCount: dto.products!.length,
              ),
            )
          ],
        ),
      );

  Widget _itemShopping(AllSearchs dto) => Container(
        color: AppColors.white,
        child: Column(
          children: [
            _nameSiteAllItem('Y! Shopping: ${dto.total!}',AppImages.imgShopping,onTap: (){
  cubit.changeTab(2);
  }),
            SizedBox(
              height: AppGap.h221,
              child: GridView.builder(
                primary: false,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
                itemBuilder: (context, index) => ItemShopping(
                  itemsDto: dto.products![index],
                  cart: ValueNotifier(false),
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 3 / 2,
                  mainAxisExtent: AppGap.w174,
                  crossAxisSpacing: AppGap.h5,
                  mainAxisSpacing: AppGap.h5,
                ),
                itemCount: dto.products!.length,
              ),
            ),
          ],
        ),
      );
  Widget _itemRakuten(AllSearchs dto) => Container(
    color: AppColors.white,
    child: Column(
      children: [
        _nameSiteAllItem('Rakuten: ${dto.total!}',AppImages.imgRakuten,onTap: (){
  cubit.changeTab(3);
  }),
        SizedBox(
          height: 252.h,
          child: GridView.builder(
            primary: false,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
            itemBuilder: (context, index) => RakutenItem(
              itemsDto: dto.products![index],
              cart: ValueNotifier(false),
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 3 / 2,
              mainAxisExtent: AppGap.w174,
              crossAxisSpacing: AppGap.h5,
              mainAxisSpacing: AppGap.h5,
            ),
            itemCount: dto.products!.length,
          ),
        ),
      ],
    ),
  );
  Widget _itemMercari(AllSearchs dto) => Container(
    color: AppColors.white,
    child: Column(
      children: [
        _nameSiteAllItem('Mercari: ${dto.total!}',AppImages.imgMercari,onTap: (){
          cubit.changeTab(4);
        }),
        SizedBox(
          height: 252.h,
          child: GridView.builder(
            primary: false,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
            itemBuilder: (context, index) => MercariItems(
              itemsDto: dto.products![index],
              cart: ValueNotifier(false),
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 3 / 2,
              mainAxisExtent: AppGap.w174,
              crossAxisSpacing: AppGap.h5,
              mainAxisSpacing: AppGap.h5,
            ),
            itemCount: dto.products!.length,
          ),
        ),
      ],
    ),
  );
  Widget _itemPaypay(AllSearchs dto) => Container(
    color: AppColors.white,
    child: Column(
      children: [
        _nameSiteAllItem('Payay Fleamarket: ${dto.total!}',AppImages.imgPaypay,onTap: (){
          cubit.changeTab(5);
        }),
        SizedBox(
          height: 252.h,
          child: GridView.builder(
            primary: false,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
            itemBuilder: (context, index) => PaypayItems(
              itemsDto: dto.products![index],
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 3 / 2,
              mainAxisExtent: AppGap.w174,
              crossAxisSpacing: AppGap.h5,
              mainAxisSpacing: AppGap.h5,
            ),
            itemCount: dto.products!.length,
          ),
        ),
      ],
    ),
  );

  Widget _nameSiteAllItem(String nameSite,String img,{void Function()? onTap})=> Padding(
    padding: EdgeInsets.symmetric(
        horizontal: AppGap.w10, vertical: AppGap.h10),
    child: Row(
      children: [
        Row(
          children: [
            Image.asset(img,height: 24.h,width: 24.w,),
            AppGap.sbW8,
            Text(
              nameSite,
              style: AppStyles.text7018(),
            ),
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Xem thêm',
                  style: AppStyles.text7018(
                      color: AppColors.primary800Color),),
              SvgPicture.asset(AppImages.icArrowight,color: AppColors.primary800Color,)
            ],
          ),
        )
      ],
    ),
  );
}
