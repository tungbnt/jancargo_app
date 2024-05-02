import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../general/app_strings/app_strings.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_gap.dart';


class ShimmerSale extends StatelessWidget {
  ShimmerSale({super.key});

  @override
  Widget build(BuildContext context) {
    final useMaterial3 = Theme.of(context).useMaterial3;
    return  Column(
      children: [
        Container(
          height: 300,
          color: AppColors.white,
          padding: EdgeInsets.all(AppGap.h10),
          margin: EdgeInsets.symmetric(vertical: AppGap.h10),

          child: DefaultTabController(
            length: 4 ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( AppStrings.of(context).outstandingSeller,style: AppStyles.text7018(),),
                TabBar.secondary(

                  automaticIndicatorColorAdjustment: false ,
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: AppColors.primary700Color,
                  dividerColor: useMaterial3 ? null :  AppColors.neutral700Color,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  indicatorWeight: 4,
                  unselectedLabelColor: AppColors.neutral600Color,
                  labelColor: AppColors.primary700Color,
                  labelStyle: AppStyles.text7016(),
                  dividerHeight: 4,

                  onTap: (index) {
                    // controller.changeTabBar(index);
                  },
                  tabs: const [
                    Text( 'Tất cả'),
                    Text( 'Y!Auction'),
                    Text( 'Mercari'),
                    Text( 'Mercari Shop'),
                  ],

                ),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _itemBarView(),
                      _itemBarView(),
                      _itemBarView(),
                      _itemBarView(),

                    ],
                  ),
                ),
              ],
            ),

          ),
        ),
      ],
    );
  }
  final List<Map> myProducts =
  List.generate(100000, (index) => {"id": index, "name": "Product $index"})
      .toList();
  Widget _itemBarView() {
    return Padding(
      padding:  EdgeInsets.only(bottom: AppGap.h20,top: AppGap.h10),
      child: GridView.builder(
        primary: false,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => const items(),
        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 3 / 2,mainAxisExtent: AppGap.w255,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: myProducts.length,
      ),
    );
  }
}



class items extends StatelessWidget {
  const items({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.neutral300Color,
      highlightColor: AppColors.neutral100Color,
      child: Container(
        width: AppGap.w232,
        height: AppGap.h60,
        padding: EdgeInsets.all(AppGap.w10),
        decoration: BoxDecoration(

            borderRadius:  BorderRadius.all(Radius.circular(AppGap.r8)),
            border: Border.all(color: AppColors.neutral50Color)
        ),
        child: Row(
          children: [
            Container(
              height: AppGap.h48,
              width: AppGap.w48,
              color: AppColors.white,
            ),
            AppGap.sbW8,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height: AppGap.h5,width: double.infinity, decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius:  BorderRadius.all(Radius.circular(AppGap.r8)),
                  ),),
                  AppGap.sbH5,
                  Container(height: AppGap.h5,width: double.infinity, decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius:  BorderRadius.all(Radius.circular(AppGap.r8)),
                  ),),
                  AppGap.sbH5,
                  Container(height: AppGap.h5,width: double.infinity, decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius:  BorderRadius.all(Radius.circular(AppGap.r8)),
                  ),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
