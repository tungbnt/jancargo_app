import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jancargo_app/src/domain/dtos/auction/auction_search/auction_search_dto.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/auction_search/auction_search_cubit.dart';
import 'package:jancargo_app/src/modules/searchs/widget/checkbox_title_search.dart';
import 'package:jancargo_app/src/modules/searchs/widget/widget_selected_title.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

class ArrangeAuctionSearch extends StatefulWidget {
  const ArrangeAuctionSearch({super.key, required this.dto, required this.currentSort, required this.cubit});

  final List<SortAuctionSearchDataDto> dto;
  final String currentSort;
  final AuctionSearchCubit cubit;


  @override
  State<ArrangeAuctionSearch> createState() =>
      _ArrangeAuctionSearchState();
}

class _ArrangeAuctionSearchState extends State<ArrangeAuctionSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.h,
      child: Scaffold(
        appBar: AppBar(
          title:  Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Sắp xếp',style: AppStyles.text6016(color: AppColors.neutral900Color),),
                  GestureDetector(
                    onTap: ()=>RouteService.pop(),
                      child: SvgPicture.asset(AppImages.icX,height: AppGap.h40,width: AppGap.w40,),),
                ],
              ),
              Divider(),
            ],
          ),
          automaticallyImplyLeading: false,
          leading: null,


        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Padding(
            padding:  EdgeInsets.only(left: AppGap.w10,bottom: AppGap.h5,),
            child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: AppStyles.text6016(color: AppColors.neutral900Color),
                children: [
                  TextSpan(text: 'Đang xếp theo: '),
                  TextSpan(
                      text: widget.currentSort,

                      style: AppStyles.text4014(
                          color: AppColors.neutral800Color)),
                ]),
                    ),
          ),
              AppGap.sbH10,
              ...widget.dto.map((e) =>_WidgetSortersAuction(itemSort: e,cubit: widget.cubit,),),
            ],

          ),
        ),
      ),
    );
  }
}


class _WidgetSortersAuction extends StatelessWidget {
  const _WidgetSortersAuction({super.key, required this.itemSort, required this.cubit});
  final SortAuctionSearchDataDto itemSort;
  final AuctionSearchCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(itemSort.header == 'Sắp xếp theo giá')
        Divider(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(itemSort.header!,style: AppStyles.text6016(color: AppColors.neutral900Color),),
              AppGap.sbH5,
              ...itemSort.items!.map((e) => WidgetSelectedTitle(item: e,cubit: cubit,),).expand((e) => [e,AppGap.sbH5]),
            ],
          ),
        ),
        if(itemSort.header == 'Sắp xếp theo giá')
        Divider(),
      ],
    );
  }
}

class WidgetSelectedTitle extends StatelessWidget {
  const WidgetSelectedTitle({super.key, required this.item, this.onTap, required this.cubit});
  final ItemsSortAuctionSearchDataDto item;
  final void Function()? onTap;
  final AuctionSearchCubit cubit;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          cubit.load('', cubit.controller!.value.text,false,item.params);
        },
        child: Text(item.label!,style: AppStyles.text4014(color: AppColors.neutral800Color),));
  }
}

