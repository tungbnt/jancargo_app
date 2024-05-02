import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jancargo_app/src/modules/list_seller/bloc/amazon_js/amazon_js_cubit.dart';
import 'package:slivers/widgets.dart';

import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../components/resource/molecules/cached_network_shaped_image.dart';
import '../../../domain/dtos/site_model/amazon_js/amazon_js_dto.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_images.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_convert.dart';
import '../../../util/app_gap.dart';
import '../../detail_product_marcari/screens/detail_product_marcari.dart';
import '../../home/components/home_shimmer.dart';

class AmazonJS extends StatefulWidget {
  const AmazonJS({super.key});

  @override
  State<AmazonJS> createState() => _AmazonJSState();
}

class _AmazonJSState extends State<AmazonJS> {
  final ValueNotifier<int> _currentPageSlider = ValueNotifier(0);
  final AmazonJsCubit _cubit = AmazonJsCubit();

  @override
  void initState() {
    super.initState();
    _cubit.initEvent();
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
          'Amazon JP',
          style: AppStyles.text7018(),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<AmazonJsCubit, AmazonJsState>(
        bloc: _cubit,
        buildWhen: (pre, current) => current is AmazonJsDataSuccess || current is AmazonJsLoading,
        builder: (context, state) {
          if(state is AmazonJsLoading){
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if(state is AmazonJsDataSuccess){
            return CustomScrollView(
              slivers: [_imgSlider(),],
            );
          }
         return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _imgSlider() => BlocBuilder<AmazonJsCubit, AmazonJsState>(
        bloc: _cubit,
        buildWhen: (pre, current) => current is AmazonJsSliderDataSuccess,
        builder: (context, state) {
          if (state is AmazonJsSliderDataSuccess) {
            List<String?> image = state.sliderDto!.results!
                .map((e) {
              if (e.image != null && !e.image!.startsWith("http")) {
                return "https://jancargo.com/${e.image}";
              } else {
                return e.image;
              }
            }).toList();
            return SliverPadding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppGap.w10, vertical: AppGap.h10),
              sliver: SliverToBoxAdapter(
                child: SliverPadding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppGap.w10, vertical: AppGap.h10),
                  sliver: CarouselSlider(
                    items: image.map(
                      (url) {
                        return SliverToBoxAdapter(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(AppGap.r8)),
                            child: CachedNetworkRectangleImage(
                              imageDecoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(AppGap.r8)),
                              ),
                              imageUrl: url!,
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.center,
                              errorWidget: SvgPicture.asset(
                                AppImages.logoLogin,
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                    options: CarouselOptions(
                      height: AppGap.h128,
                      aspectRatio: 3 / 2,
                      initialPage: 0,
                      reverse: false,
                      autoPlay: true,
                      enableInfiniteScroll: image.length > 1,
                      viewportFraction: 1,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 1600),
                      autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                      onPageChanged: (index, reason) {
                        _currentPageSlider.value = index;
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              ),
            );
          }
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        },
      );

  Widget _items() => BlocBuilder<AmazonJsCubit, AmazonJsState>(
        bloc: _cubit,
        buildWhen: (pre, current) => current is AmazonJsSliderDataSuccess,
        builder: (context, state) {
          if (state is AmazonJsItemsDataSuccess) {
            return SliverContainer(
              sliver: GridView.builder(
                itemBuilder: (context, index) {
                  return _item(state.dto!.products![index]);
                },
                itemCount: state.dto!.products!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    mainAxisExtent: AppGap.w255,
                    crossAxisSpacing: AppGap.w10,
                    mainAxisSpacing: AppGap.h10),
              ),
            );
          }
          return const SliverToBoxAdapter(
            child: SizedBox.shrink(),
          );
        },
      );

  Widget _item(ItemsAmazonJsDto itemsDto) => InkWell(
        onTap: () => RouteService.routeGoOnePage(
            MarcariDetailProduct(code: itemsDto.code!, source: 'marcari')),
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
                itemsDto.title!,
                style: AppStyles.text7016(color: AppColors.black03),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (itemsDto.price!.basisPrice!.value!.amount! != null)
                Text(
                    AppConvert.convertAmountVn(
                        itemsDto.price!.basisPrice!.value!.amount!),
                    style:
                        AppStyles.text7016(color: AppColors.primary700Color)),
              Text(
                  AppConvert.convertAmountJp(
                      itemsDto.price!.basisPrice!.value!.amount!),
                  style: AppStyles.text4014(color: AppColors.neutral400Color)),
            ],
          ),
        ),
      );
}
