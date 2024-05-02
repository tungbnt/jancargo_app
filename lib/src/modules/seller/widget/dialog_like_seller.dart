import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jancargo_app/src/components/bloc/favorite/favorite_cubit.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/resource/molecules/app_loading.dart';
import '../../../components/resource/molecules/cached_network_shaped_image.dart';
import '../../../components/resource/molecules/input.dart';
import '../../../data/object_request_api/favorite_seller/favorite_seller_request.dart';
import '../../../domain/services/dialog/dialog_service.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_images.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_gap.dart';

class DialogLikeSeller extends StatefulWidget {
  const DialogLikeSeller({
    super.key,
    required this.avt,
    required this.name,
    required this.url,
    required this.percent,
    required this.rate,
    required this.code,
  });

  final String avt;

  final String name;

  final String url;
  final String code;
  final double percent;

  final int rate;

  @override
  State<DialogLikeSeller> createState() => _DialogLikeSellerState();
}

class _DialogLikeSellerState extends State<DialogLikeSeller> {
  final FavoriteCubit _cubit = FavoriteCubit();
  ValueNotifier<bool> isFavoriteSeller = ValueNotifier(false);

  _launchURL() async {
    final uri = Uri.tryParse(widget.url);
    if (uri != null) {
      launchUrl(uri);
    }
  }

  _dialogLikeSeller() {
    DialogService.openDialog(
      Container(
          height: AppGap.h221,
          color: AppColors.white,
          margin: EdgeInsets.symmetric(horizontal: AppGap.w10),
          padding: EdgeInsets.symmetric(
              horizontal: AppGap.w15, vertical: AppGap.h24),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
                child: Text(
              'Cập nhật người bán yêu thích',
              style: AppStyles.text6016(color: AppColors.neutral800Color),
            )),
            Text('Người bán',
                style: AppStyles.text6014(color: AppColors.neutral800Color)),
            Text(widget.name,
                style: AppStyles.text4014(color: AppColors.neutral800Color)),
            Text('Ghi chú thêm',
                style: AppStyles.text6014(color: AppColors.neutral800Color)),
            AppInput(
              maxLine: 5,
              height: AppGap.h48,
              placeholder: "Nhập nội dung ghi chú",
            ),
            AppGap.sbH10,
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _btnCustom(() => RouteService.pop(), 'Đóng', AppColors.white,
                    AppColors.neutral800Color),
                AppGap.sbW8,
                _btnCustom(() async {
                  await RouteService.popBackResult();

                  _cubit.favoritesSeller(FavoriteSellerRequest(
                      name: widget.name,
                      url: widget.url,
                      image: widget.avt,
                      remark: "remark",
                      description: "",
                      code: widget.code,
                      siteCode: AppConstants.auctionShoppingSource));
                }, 'Lưu lại', AppColors.yellow800Color,
                    AppColors.yellow800Color),
              ],
            ),
          ])),
    );
  }

  @override
  void initState() {
    super.initState();
    _cubit.getFavoritesSeller(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.white),
      padding:
          EdgeInsets.symmetric(horizontal: AppGap.w10, vertical: AppGap.h10),
      margin: EdgeInsets.only(bottom: AppGap.h10),
      // height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppGap.h48,
                width: AppGap.w48,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(AppGap.r4)),
                  child: CachedNetworkRectangleImage(
                    imageDecoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.circular(AppGap.r4)),
                    ),
                    imageUrl: widget.avt,
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.center,
                    errorWidget: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.neutral200Color),
                          shape: BoxShape.circle),
                      child: SvgPicture.asset(
                        AppImages.logoLogin,
                      ),
                    ),
                  ),
                ),
              ),
              AppGap.sbW8,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.name,
                    style: AppStyles.text4014(color: AppColors.neutral800Color),
                    maxLines: 1,
                  ),
                  Row(
                    children: [
                      Text(
                        "Đánh giá: ${widget.rate} | Uy tín: ${widget.percent}",
                        style: AppStyles.text4014(
                            color: AppColors.neutral400Color),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: AppGap.h32,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: AppColors.greenColor.withOpacity(0.3),
                border: Border.all(color: AppColors.greenColor)),
            child: Text(
              "Mức độ uy tín cao",
              style: AppStyles.text4014(color: AppColors.neutral800Color),
            ),
          ),
          AppGap.sbH10,
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _btn(
                  GestureDetector(
                    onTap: _launchURL,
                    child: Text(
                      'Xem chi tiết',
                      style: AppStyles.text4012(),
                    ),
                  ),
                  ValueNotifier(false),
                ),
                _btn(
                    BlocConsumer<FavoriteCubit, FavoriteState>(
                      bloc: _cubit,
                      listenWhen: (content, state) =>
                          state is FavoriteLoading ||
                          state is FavoritesSellerSuccess ||
                          state is FavoritesSearchFailed ||
                          state is GetFavoritesSellerSuccess,
                      buildWhen: (content, state) =>
                          state is FavoriteLoading ||
                          state is FavoritesSellerSuccess ||
                          state is FavoritesSearchFailed ||
                          state is GetFavoritesSellerSuccess,
                      listener: (context, state) async {
                        if (state is FavoriteLoading) {
                          return await AppLoading.openSpinkit(context);
                        } else if (state is FavoritesSellerSuccess) {
                          RouteService.pop();
                          if (state.isFavoriteSeller ==
                              "Đã thêm vào danh sách yêu thích") {
                            isFavoriteSeller.value = true;
                          } else {
                            isFavoriteSeller.value = false;
                          }
                          DialogService.showNotiBannerInfo(
                              context, state.isFavoriteSeller!);
                        } else if (state is FavoritesSearchFailed) {
                          RouteService.pop();
                          isFavoriteSeller.value = false;
                          DialogService.showNotiBannerInfo(
                              context, state.isFavoriteSeller!);
                        } else if (state is GetFavoritesSellerSuccess) {
                          if (state.itemFavoriteSeller!.code == widget.code) {
                            isFavoriteSeller.value = true;
                          } else {
                            isFavoriteSeller.value = false;
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state is FavoriteLoading) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppGap.sbW8,
                              Text(
                                'Đang loading...',
                                style: AppStyles.text4012(),
                              )
                            ],
                          );
                        }
                        return GestureDetector(
                          onTap: () async {
                            await _dialogLikeSeller();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppImages.icHeart,
                                height: 16,
                                width: 16,
                              ),
                              AppGap.sbW8,
                              Text(
                                isFavoriteSeller.value
                                    ? 'Đã thích'
                                    : 'Yêu thích',
                                style: AppStyles.text4012(),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    isFavoriteSeller),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _btn(Widget child, ValueNotifier<bool> isFavorite) =>
      ValueListenableBuilder(
          valueListenable: isFavorite,
          builder: (context, value, _) {
            return Container(
              width: AppGap.w163,
              height: AppGap.h24,
              decoration: BoxDecoration(
                color: isFavorite.value
                    ? AppColors.yellow800Color
                    : AppColors.white,
                border: Border.all(
                    color: isFavorite.value
                        ? AppColors.yellow800Color
                        : AppColors.neutral400Color),
                borderRadius: BorderRadius.all(
                  Radius.circular(AppGap.r4),
                ),
              ),
              alignment: Alignment.center,
              child: child,
            );
          });

  Widget _btnCustom(void Function()? onTap, String name, Color btnColors,
          Color borderColors) =>
      InkWell(
        onTap: onTap,
        child: Container(
          width: AppGap.w90,
          height: AppGap.h32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: btnColors,
              borderRadius: BorderRadius.circular(AppGap.r4),
              border: Border.all(width: 1, color: borderColors)),
          child: Text(
            name,
            style: AppStyles.text4012(color: AppColors.neutral800Color),
            textAlign: TextAlign.center,
          ),
        ),
      );
}
