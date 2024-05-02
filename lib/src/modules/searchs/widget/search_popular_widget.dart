import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/rakuten_search/rakuten_search_cubit.dart';

import '../../../app_manager.dart';
import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../domain/dtos/search/search_popular/search_popular_dto.dart';
import '../../../general/constants/app_colors.dart';
import '../../../util/app_gap.dart';

class SearchPopularWidget extends StatefulWidget {
  const SearchPopularWidget({super.key, required this.populars, required this.getSearchIndex});
   final List<SearchPopularItemDto> populars;
  final ValueSetter<String> getSearchIndex;


  @override
  State<SearchPopularWidget> createState() => _SearchPopularWidgetState();
}

class _SearchPopularWidgetState extends State<SearchPopularWidget> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: AppColors.white,
      margin: EdgeInsets.only(top: AppGap.h10,bottom: AppGap.h10),
      padding: EdgeInsets.only(bottom: AppGap.h20),
      child: Column(
        children: [
          _title(),
          _populars(),
        ],
      ),
    );
  }

  Widget _title()=>   Column(
    crossAxisAlignment: CrossAxisAlignment.start,
   children: [
     Padding(
       padding:EdgeInsets.only(top: AppGap.h10,left: AppGap.w10),
       child: Text('Tìm kiếm phổ biến',textAlign: TextAlign.center,style: AppStyles.text5020(),),
     ),
     const Divider(),

   ],
  );

  Widget _populars() => Wrap(
    children: widget.populars.map((e) => _itemTest(e)).toList(),
  );

  Widget _itemTest(SearchPopularItemDto e) => GestureDetector(
    onTap: (){
      widget.getSearchIndex.call(e.name ?? '');
      AppManager.appSession.saveCodeCategory(e.name);
    },
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.neutral300Color,
        borderRadius: BorderRadius.circular(AppGap.r4),
      ),
      padding: EdgeInsets.symmetric(horizontal: AppGap.w3),
      margin: EdgeInsets.symmetric(horizontal: AppGap.w3,vertical: AppGap.h5),
      child: Text(
        e.name!,
      ),
    ),
  );

 ///
  Widget _gridPopular()=> GridView.builder(
    primary: false,
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) => _item(',',''),
    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 3 / 2,mainAxisExtent: AppGap.w255,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20),
    itemCount: 1,
  );

  Widget _item(String text,String img)=> Container( child: Row(
    children: [
      Container(
        width: AppGap.w50,
        height: AppGap.w50,
        margin: EdgeInsets.symmetric(horizontal: AppGap.w10),
        color: AppColors.neutral200Color,
        child: AppCarouselImages(
          fit: BoxFit.cover,
          height: AppGap.h90,
          // ignore: invalid_use_of_protected_member
          imagesUrl: [img],
          alignment: Alignment.topCenter,
          autoPlay: false,
          showIndicatorBottom: false,
          imageDecoration: const BoxDecoration(
              borderRadius:
              BorderRadius.zero), borderRadius: BorderRadius.zero,
        ),
      ),
      Text(text)
    ],
  ),
  );
}
