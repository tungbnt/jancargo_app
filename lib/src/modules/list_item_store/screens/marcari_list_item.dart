import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/components/widget/custom_refresh_indicator.dart';
import 'package:jancargo_app/src/components/widget/will_scroll_position_change.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/modules/detail_product_marcari/screens/detail_product_marcari.dart';
import 'package:jancargo_app/src/modules/web_view/screen/web_view.dart';

import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../components/resource/molecules/app_loading.dart';
import '../../../components/resource/molecules/smart_refresher_custom.dart';
import '../../../components/resource/organisms/will_refresh_view.dart';
import '../../../domain/dtos/search/search_mercari/search_mercari_dto.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_constants.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_convert.dart';
import '../../../util/app_gap.dart';
import '../../list_seller/bloc/marcari/marcari_cubit.dart';

class MarcariListItem extends StatefulWidget {
  const MarcariListItem({
    super.key,
  });

  @override
  State<MarcariListItem> createState() => _MarcariListItemState();
}

class _MarcariListItemState extends State<MarcariListItem> {
  final MarcariCubit _cubit = MarcariCubit();

  @override
  void initState() {
    super.initState();
    _cubit.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral200Color,
      extendBody: true,
      appBar: AppBar(
        bottomOpacity: 0.0,
        backgroundColor: AppColors.white,
        leading: IconButton(
          highlightColor: Colors.transparent,
          onPressed: () => Future.delayed(Duration.zero, () {
            RouteService.pop();
          }),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.black03,
          ),
        ),
        title: Text(
          'Mercari',
          style: AppStyles.text7018(),
        ),
        centerTitle: true,
      ),
      body: _items(),
    );
  }

  Widget _items() => BlocConsumer<MarcariCubit, MarcariState>(
        bloc: _cubit,
        listenWhen: (prv, state) =>
            state is MarcariLoading || state is MarcariDataSuccess,
        listener: (context, state) async {
          if (state is MarcariDataSuccess) {
            RouteService.pop();
            setState(() {
              state.dto!.data!.addAll(state.dto!.data!);
            });
          } else if (state is MarcariLoading) {
            return await AppLoading.openSpinkit(context);
          }
        },
        builder: (context, state) {
          if (state is MarcariDataSuccess) {
            return WillScrollPositionChange(
              onNextExtent: (){
                _cubit.load();
              },
              onEnd: (){
                _cubit.load();
              },
              designItemExtent: 500,
              child: CustomRefreshIndicator(
                onRefresh: (){
                  print('có vào đây');
                 return _cubit.load();
                },
                  indicator: LoadingSpinkit(),
              
                builder: (context,bool isbool) {
                  return CustomScrollView(
                    slivers: [
                      SliverGrid.builder(

                        itemBuilder: (context, index) {
                          return _item(state.dto!.data![index]);
                        },
                        itemCount: state.dto!.data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 2,
                            mainAxisExtent: AppGap.w255,
                            crossAxisSpacing: AppGap.w10,
                            mainAxisSpacing: AppGap.h10),
                      ),
                    ],
                  );
                }
              ),
            );
          }
          return const SizedBox.shrink();
        },
      );

  Widget _item(MercarisDto itemsDto) => InkWell(
        onTap: () => RouteService.routeGoOnePage(
            MarcariDetailProduct(code: itemsDto.code!, source: AppConstants.marcariSource)),
        child: Container(
          width: AppGap.w144,
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppGap.r8),
                  topRight: Radius.circular(AppGap.r8))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AppCarouselImages(
                    height: AppGap.h136,
                    // ignore: invalid_use_of_protected_member
                    imagesUrl: [itemsDto.image!],
                    alignment: Alignment.topCenter,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(AppGap.r8),
                      topLeft: Radius.circular(AppGap.r8),
                    ),
                    autoPlay: false,
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
                  style: AppStyles.text4014(color: AppColors.neutral400Color)),
            ],
          ),
        ),
      );
}
