import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:slivers/widgets.dart';

import '../../../../components/resource/molecules/app_carousel_image.dart';
import '../../../../domain/dtos/search/mecari_search_key_word/mecari_search_key_word_dto.dart';
import '../../../../domain/dtos/search/search_mercari/search_mercari_dto.dart';
import '../../../../general/constants/app_colors.dart';
import '../../../../general/constants/app_styles.dart';
import '../../../../util/app_convert.dart';
import '../../../../util/app_gap.dart';
import '../../../detail_product_marcari/screens/detail_product_marcari.dart';

class SearchIMarcariItems extends StatefulWidget {
  const SearchIMarcariItems({super.key, required this.nameStore, required this.dto});
  final String nameStore;
  final MercariSearchKeyWordDto dto;

  @override
  State<SearchIMarcariItems> createState() => _SearchIMarcariItemsState();
}

class _SearchIMarcariItemsState extends State<SearchIMarcariItems> {
  @override
  Widget build(BuildContext context) {
    return SliverContainer(
      decoration: BoxDecoration(color: AppColors.white),
      sliver: SliverGroup(
        slivers: [
          _nameStore(),
          _searchResult(widget.dto),

        ],
      ),
    );
  }

  Widget _nameStore()=>SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: AppGap.h10,horizontal: AppGap.w10),
      child: Row(
        children: [
          Image.asset(AppImages.imgMercari,height: 24.h,width: 24.w,),
          AppGap.sbW8,
          Text(widget.nameStore, style: AppStyles.text6016(),)
        ],
      ),
    ),
  );

  Widget _searchResult(MercariSearchKeyWordDto dto)=> SliverPadding(
    padding:  EdgeInsets.symmetric(
        horizontal: AppGap.h5, vertical: AppGap.h10),
    sliver: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: AppGap.h5,
            mainAxisSpacing: AppGap.h5,
            mainAxisExtent: AppGap.h275),
        itemBuilder: (context, index) {
          return _items(dto.products![index]);
        },
        itemCount: dto.products!.length),
  );

  Widget _items(MercariSearchKeyWordItemDto itemsDto)=>  InkWell(
    onTap: ()=>RouteService.routeGoOnePage(MarcariDetailProduct(code: itemsDto.code!, source: AppConstants.marcariSource,)),
    child: Ink(
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
                borderRadius: BorderRadius.only(topRight: Radius.circular(AppGap.r8),topLeft: Radius.circular(AppGap.r8),),
                autoPlay: false,),
            ],
          ),
          Text(itemsDto.name!,style: AppStyles.text7016(color: AppColors.black03),maxLines: 2,overflow: TextOverflow.ellipsis,),
          Text(AppConvert.convertAmountVn(itemsDto.price!),style: AppStyles.text7016(color: AppColors.primary700Color)),
          Text(AppConvert.convertAmountJp(itemsDto.price!),style: AppStyles.text4014(color: AppColors.neutral400Color)),
        ],
      ),
    ),
  );
}
