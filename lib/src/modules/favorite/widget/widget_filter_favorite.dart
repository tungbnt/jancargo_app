import 'package:flutter/material.dart';
import 'package:jancargo_app/src/components/bloc/favorite/favorite_cubit.dart';
import 'package:jancargo_app/src/components/resource/molecules/app_button.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/modules/favorite/components/filter_favorite_radio_horizontal.dart';
import 'package:jancargo_app/src/util/app_gap.dart';


class WidgetFilterFavorite extends StatefulWidget {
  const WidgetFilterFavorite({super.key, required this.filterModel, required this.contextFavorite});

  final FavoriteFilterModel filterModel;
  final BuildContext contextFavorite;

  @override
  State<WidgetFilterFavorite> createState() =>
      _WidgetFilterFavorite();
}

class _WidgetFilterFavorite extends State<WidgetFilterFavorite> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
            child: Column(
              children: [
                AppGap.sbH10,
                FilterRadioHorizontal(title: 'Nguồn',cubit: widget.filterModel.searchCubit,filterModelForView: widget.filterModel.conditionsFilterController,),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: AppGap.h55,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppButton(
                        height: AppGap.h40,
                        width: AppGap.w163,
                        enable: true,
                        onPressed: () {
                          Navigator.pop(widget.contextFavorite,true);
                        },
                        color: AppColors.white,
                        textColor: AppColors.neutral800Color,
                        borderColor: AppColors.neutral200Color,
                        text: 'Đóng'),
                    AppButton(
                        height: AppGap.h40,
                        width: AppGap.w163,
                        enable: true,
                        onPressed: () {
                          Navigator.pop(widget.contextFavorite,true);
                        },
                        text: 'Lọc'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class WidgetArrangeFavorite extends StatefulWidget {
  const WidgetArrangeFavorite({super.key, required this.filterModel, required this.contextFavorite});

  final FavoriteFilterModel filterModel;
  final BuildContext contextFavorite;

  @override
  State<WidgetArrangeFavorite> createState() =>
      _WidgetArrangeFavoriteState();
}

class _WidgetArrangeFavoriteState extends State<WidgetArrangeFavorite> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
            child: Column(
              children: [
                AppGap.sbH10,
                FilterRadioHorizontal(title: 'Sắp xếp',cubit: widget.filterModel.searchCubit,filterModelForView: widget.filterModel.conditionsArrangeController,),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: AppGap.h55,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppButton(
                        height: AppGap.h40,
                        width: AppGap.w163,
                        enable: true,
                        onPressed: () {
                          Navigator.pop(widget.contextFavorite,true);
                        },
                        color: AppColors.white,
                        textColor: AppColors.neutral800Color,
                        borderColor: AppColors.neutral200Color,
                        text: 'Đóng'),
                    AppButton(
                        height: AppGap.h40,
                        width: AppGap.w163,
                        enable: true,
                        onPressed: () {
                          Navigator.pop(widget.contextFavorite,true);
                        },
                        text: 'Lọc'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}