import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/general/constants/app_storage.dart';
import 'package:jancargo_app/src/modules/searchs/widget/search_popular_widget.dart';

import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../domain/dtos/site_model/paypay/paypay_dto.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_convert.dart';
import '../../../util/app_gap.dart';
import '../bloc/paypay/paypay_cubit.dart';

class PayPays extends StatefulWidget {
  const PayPays({super.key});

  @override
  State<PayPays> createState() => _PayPaysState();
}

class _PayPaysState extends State<PayPays> {
  final PaypayCubit _cubit = PaypayCubit();

  @override
  void initState() {
    super.initState();
    _cubit.prepare();
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
          'Paypay Fleamarket',
          style: AppStyles.text7018(),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<PaypayCubit, PaypayState>(
        bloc: _cubit,
        buildWhen: (prv, state) => state is PaypayDataSuccess,
        builder: (context, state) {
          if (state is PaypayLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is PaypayDataSuccess) {
            return CustomScrollView(
              slivers: [
                _popularSearch(),
                itemCategory(),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _popularSearch() => BlocBuilder<PaypayCubit, PaypayState>(
        bloc: _cubit,
        buildWhen: (prv, state) => state is PaypaySearchPopularDataSuccess,
        builder: (context, state) {
          if (state is PaypaySearchPopularDataSuccess) {
            return SliverToBoxAdapter(
              child: SearchPopularWidget(
                populars: state.searchPopularDto!.data!,
                getSearchIndex: (String keyName) {},
              ),
            );
          }
          return const SliverToBoxAdapter(
            child: SizedBox.shrink(),
          );
        },
      );

  Widget itemCategory() => BlocBuilder<PaypayCubit, PaypayState>(
        bloc: _cubit,
        buildWhen: (prv, state) => state is PaypayItemSuccess,
        builder: (context, state) {
          if (state is PaypayItemSuccess) {
            return SliverList.builder(
              itemCount: state.dto!.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: AppGap.h283,
                  margin: EdgeInsets.only(bottom: AppGap.h10),
                  color: AppColors.white,
                  child: Column(
                    children: [
                      _nameCategory(AppStorage.gettitlePay(
                          state.dto![index].category!.toString())),
                      _sliverGrid(state.dto![index].results),
                    ],
                  ),
                );
              },
            );
          }
          return const SliverToBoxAdapter(
            child: SizedBox.shrink(),
          );
        },
      );

  Widget _nameCategory(String name) => Padding(
        padding:
            EdgeInsets.symmetric(vertical: AppGap.h10, horizontal: AppGap.w10),
        child: Row(
          children: [
            Text(
              name,
              style: AppStyles.text6016(),
            )
          ],
        ),
      );

  Widget _sliverGrid(List<ItemPaypay>? items) => Container(
        height: AppGap.h240,
        padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
        child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: AppGap.h5,
                mainAxisSpacing: AppGap.h5,
                mainAxisExtent: AppGap.w163),
            itemBuilder: (context, index) {
              return _item(items[index]);
            },
            itemCount: items!.length),
      );

  Widget _item(ItemPaypay itemsDto) => InkWell(
        onTap: () {},
        child: SizedBox(
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
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(AppGap.r8),
                      topLeft: Radius.circular(AppGap.r8),
                    ),
                    imageDecoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(AppGap.r8),
                        topLeft: Radius.circular(AppGap.r8),
                      ),
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
