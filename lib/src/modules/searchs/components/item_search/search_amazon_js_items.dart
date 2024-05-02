import 'package:flutter/material.dart';
import 'package:slivers/widgets.dart';

import '../../../../components/resource/molecules/app_carousel_image.dart';
import '../../../../domain/dtos/search/amazon_js_search_keyword/amazon_js_search_keyword_dto.dart';
import '../../../../general/constants/app_colors.dart';
import '../../../../general/constants/app_styles.dart';
import '../../../../util/app_convert.dart';
import '../../../../util/app_gap.dart';

class SearchAmazonJsItems extends StatefulWidget {
  const SearchAmazonJsItems({super.key,required this.dto});

  final AmazonSearchKeyWordDto dto;

  @override
  State<SearchAmazonJsItems> createState() => _SearchAmazonJsItemsState();
}

class _SearchAmazonJsItemsState extends State<SearchAmazonJsItems> {
  @override
  Widget build(BuildContext context) {
    return SliverContainer(
      decoration: const BoxDecoration(color: AppColors.white),
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
          Text('Rakuten', style: AppStyles.text6016(),)
        ],
      ),
    ),
  );

  Widget _searchResult(AmazonSearchKeyWordDto dto)=> SliverPadding(
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

  Widget _items(AmazonItemsSearchKeyWordDto itemsDto)=>  InkWell(
    onTap: (){},
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
          Text(AppConvert.convertAmountVn(itemsDto.currentPrice!),style: AppStyles.text7016(color: AppColors.primary700Color)),
          Text(AppConvert.convertAmountJp(itemsDto.currentPrice!),style: AppStyles.text4014(color: AppColors.neutral400Color)),
        ],
      ),
    ),
  );
}
