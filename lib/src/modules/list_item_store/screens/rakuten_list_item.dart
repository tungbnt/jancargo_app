import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/modules/detail_product_rakuten/screens/detail_product_rakuten.dart';
import 'package:jancargo_app/src/modules/list_seller/bloc/rakutens/rakuten_cubit.dart';

import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../components/resource/molecules/app_loading.dart';
import '../../../components/resource/molecules/custom_timer.dart';
import '../../../components/resource/molecules/smart_refresher_custom.dart';
import '../../../components/resource/organisms/will_refresh_view.dart';
import '../../../domain/dtos/search/search_rakuten/search_rakuten_dto.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_constants.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_convert.dart';
import '../../../util/app_gap.dart';

class RakutenListItem extends StatefulWidget {
  const RakutenListItem({super.key});

  @override
  State<RakutenListItem> createState() => _RakutenListItemState();
}

class _RakutenListItemState extends State<RakutenListItem> {
  final RakutenCubit _cubit = RakutenCubit();

  @override
  void initState() {
    super.initState();
    _cubit.load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral300Color,
      extendBody: true,
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: AppColors.white,
        leading: InkWell(
          highlightColor: Colors.transparent,
          onTap: () => RouteService.pop(),
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.black03,
          ),
        ),
        title: Text(
          'Rakuten',
          style: AppStyles.text7018(),
        ),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          WillRefreshView(child: _items()),
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: Container(
          //     color: AppColors.white,
          //     width: double.infinity,
          //     height: AppGap.h40,
          //     alignment: Alignment.center,
          //     padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Icon(
          //           Icons.access_time,
          //           size: AppGap.h32,
          //         ),
          //         AppGap.sbW8,
          //         Text('Kết thúc trong', style: AppStyles.text4017()),
          //         Spacer(),
          //         // CountdownScreen(),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget _items() => BlocConsumer<RakutenCubit, RakutenState>(
        bloc: _cubit,
        listenWhen: (prv,state)=> state is RakutenLoading || state is RakutenDataSuccess,
        listener: (context, state) async{
          if (state is RakutenDataSuccess) {
            RouteService.pop();
            setState(() {
              state.searchRakutenDto!.data!
                  .addAll(state.searchRakutenDto!.data!);
            });
          }else if(state is RakutenLoading){
            return await AppLoading.openSpinkit(context);
          }
        },
        builder: (context, state) {
          if (state is RakutenDataSuccess) {
            return CustomSmartRefresher(
              controller: _cubit.refreshController,
              onLoading: () async {
                _cubit.loadMore();
              },
              onRefresh: () async {
                _cubit.refreshList();
              },
              enablePullDown: true,
              enablePullUp: true,
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(
                    horizontal: AppGap.h5, vertical: AppGap.h50),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: AppGap.h5,
                    mainAxisSpacing: AppGap.h5,
                    mainAxisExtent: AppGap.h240),
                itemCount: state.searchRakutenDto!.data!.length,
                itemBuilder: (context, index) =>
                    _item(state.searchRakutenDto!.data![index]),
              ),
            );
          }
          return SizedBox.shrink();
        },
      );

  Widget _item(RakutensDto itemsDto) => InkWell(
        onTap: () => RouteService.routeGoOnePage(RakutenDetailProductScreen(
          code: itemsDto.code!,
          source: AppConstants.rakutenSource,
        )),
        child: Container(
          width: AppGap.w144,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppGap.r8),
              topLeft: Radius.circular(AppGap.r8),
            ),
          ),
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
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(AppGap.r8),
                      topLeft: Radius.circular(AppGap.r8),
                    ),
                    autoPlay: false,
                  ),
                  // Align(
                  //   alignment: Alignment.topRight,
                  //   child: Row(
                  //     children: [
                  //       Spacer(),
                  //       Padding(
                  //         padding:  EdgeInsets.only(right: AppGap.w20),
                  //         child: ShapeDiscountWidget(cent: itemsDto.),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 30,
                      height: 30,
                      margin: EdgeInsets.all(AppGap.h10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary900Color ,
                      ),
                      child: Image.asset(AppImages.imgRakuten,height: 24.h,width: 24.w,),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(AppGap.w3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemsDto.name!,
                      style: AppStyles.text5014(color: AppColors.black03),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(AppConvert.convertAmountVn(itemsDto.price!),
                        style: AppStyles.text7016(
                            color: AppColors.primary700Color)),
                    Text(AppConvert.convertAmountJp(itemsDto.price!),
                        style: AppStyles.text4012(
                            color: AppColors.neutral400Color)),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
