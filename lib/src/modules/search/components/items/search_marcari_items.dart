import 'package:flutter/material.dart';

import '../../../../components/resource/molecules/app_carousel_image.dart';
import '../../../../domain/dtos/search/search_mercari/search_mercari_dto.dart';
import '../../../../general/constants/app_colors.dart';
import '../../../../general/constants/app_styles.dart';
import '../../../../util/app_convert.dart';
import '../../../../util/app_gap.dart';

class SearchIMarcariItems extends StatefulWidget {
  const SearchIMarcariItems({super.key, required this.nameStore, required this.dto});
  final String nameStore;
  final SearchMercariDto dto;

  @override
  State<SearchIMarcariItems> createState() => _SearchIMarcariItemsState();
}

class _SearchIMarcariItemsState extends State<SearchIMarcariItems> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _nameStore(),
        _searchResult(widget.dto),

      ],
    );
  }

  Widget _nameStore()=>Row(
    children: [

      Text(widget.nameStore)
    ],
  );

  Widget _searchResult(SearchMercariDto dto)=> GridView.builder(
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
        return _items(dto.data![index]);
      },
      itemCount: dto.data!.length);

  Widget _items(MercarisDto itemsDto)=>  InkWell(
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
          Text(AppConvert.convertAmountVn(itemsDto.price!),style: AppStyles.text7016(color: AppColors.primary700Color)),
          Text(AppConvert.convertAmountJp(itemsDto.price!),style: AppStyles.text4014(color: AppColors.neutral400Color)),
        ],
      ),
    ),
  );
}
