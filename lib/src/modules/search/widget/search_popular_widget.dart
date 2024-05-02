import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:slivers/widgets.dart';

import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../domain/dtos/search/search_popular/search_popular_dto.dart';
import '../../../general/constants/app_colors.dart';
import '../../../util/app_gap.dart';

class SearchPopularWidget extends StatelessWidget {
  const SearchPopularWidget({super.key, required this.populars, required this.getIndexValue});
   final List<SearchPopularItemDto> populars;
   final ValueSetter<SearchPopularItemDto> getIndexValue;

  @override
  Widget build(BuildContext context) {
    return  SliverContainer(
      decoration: const BoxDecoration(color: AppColors.white),
      margin: EdgeInsets.only(top: AppGap.h10,bottom: AppGap.h20),
      sliver: SliverGroup(
        slivers: [
          _title(),
          _populars(),
        ],
      ),
    );
  }

  Widget _title()=>   SliverToBoxAdapter(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       Padding(
         padding:EdgeInsets.only(top: AppGap.h10,left: AppGap.w10),
         child: Text('Tìm kiếm phổ biến',textAlign: TextAlign.center,style: AppStyles.text5020(),),
       ),
       Divider(),

     ],
    ),
  );



  Widget _populars() => SliverToBoxAdapter(
    child: Wrap(
      children: populars.map((e) => _itemTest(e)).toList(),
    ),
  );

  Widget _itemTest(SearchPopularItemDto e) => InkWell(
    onTap: (){
      getIndexValue.call(e);
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
