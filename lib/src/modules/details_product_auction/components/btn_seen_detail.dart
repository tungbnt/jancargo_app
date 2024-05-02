import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jancargo_app/src/components/bloc/favorite/favorite_cubit.dart';
import 'package:jancargo_app/src/domain/services/dialog/dialog_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_enum.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/util/app_gap.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/object_request_api/favorite/favorite_request.dart';

class SeenDetailBtn extends StatefulWidget {
  const SeenDetailBtn(
      {super.key,
      required this.code,
      required this.name,
      required this.price,
      required this.endTime,
      required this.thumbnails,
      required this.currency,
      required this.url,
      required this.siteCode,
      required this.urlSite,
      required this.nameSite,
      required this.isFavorite});

  final String code;
  final String siteCode;
  final String currency;
  final String name;
  final String url;
  final String urlSite;
  final String nameSite;
  final int price;
  final String endTime;
  final List<String> thumbnails;
  final ValueNotifier<bool> isFavorite;

  @override
  State<SeenDetailBtn> createState() => _SeenDetailBtnState();
}

class _SeenDetailBtnState extends State<SeenDetailBtn> {
  final FavoriteCubit _favoriteCubit = FavoriteCubit();
  late ValueNotifier<bool> isFavorite;

  bool isFavoriteSuccess = false;

  _launchURL() async {
    final uri = Uri.tryParse(widget.urlSite);
    if (uri != null) {
      launchUrl(uri);
    }
  }

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: _launchURL,
          child: SizedBox(
            height: AppGap.h20,
            child: Text(
              'Xem trên ${widget.nameSite}',
              style:
                  AppStyles.text6016(color: AppColors.yellow900Color).copyWith(
                decoration: TextDecoration.underline,
                    decorationColor: AppColors.yellow900Color,
              ),
            ),
          ),
        ),
        const Spacer(),
        Row(
          children: [
            BlocListener<FavoriteCubit, FavoriteState>(
              bloc: _favoriteCubit,
              listener: (context, state) {
                if (state is FavoriteItemSuccess) {
                  isFavoriteSuccess = false;
                  if (isFavorite.value) {
                    DialogService.showNotiBannerSuccess(
                        context, 'Thêm sản phẩm yêu thích thành công!');
                  } else {
                    DialogService.showNotiBannerSuccess(
                        context, 'Xoá sản phẩm yêu thích thành công!');
                  }
                } else if (state is FavoritesSearchFailed) {
                  isFavoriteSuccess = false;
                  DialogService.showNotiBannerInfo(
                      context, 'Thêm sản phẩm yêu thích không thành công!');
                  //
                  isFavorite.value = false;
                }
              },
              child: ValueListenableBuilder(
                  valueListenable: isFavorite,
                  builder: (context, value, __) {
                    return IconButton(
                        onPressed: () {
                          //
                          if (isFavoriteSuccess) {
                            DialogService.showNotiBannerInfo(
                                context, 'Đang đợi hệ thống xử lí!');
                          }
                          isFavorite.value = !isFavorite.value;
                          context.read<FavoriteCubit>().favoriteItem(
                                FavoriteRequest(
                                    code: widget.code,
                                    siteCode: widget.siteCode,
                                    name: widget.name,
                                    price: widget.price,
                                    endTime: widget.endTime,
                                    images: widget.thumbnails,
                                    qty: 1,
                                    currency: widget.currency,
                                    url: widget.url),
                              );
                          //chặn request nhiều lần
                          isFavoriteSuccess = true;
                        },
                        icon: SvgPicture.asset(
                          value ? AppImages.icHeartBold : AppImages.icHeart,
                          color: value ? AppColors.primary600Color : null,
                        ),
                        iconSize: 35);
                  }),
            ),
            IconButton(
                onPressed: () {
                  DialogService.openDialog(_buildDialogShare());
                },
                icon: SvgPicture.asset(AppImages.icShare),
                iconSize: 35),
          ],
        )
      ],
    );
  }

  Widget _buildDialogShare() => Container(
        height: 162.h,
        margin: EdgeInsets.symmetric(horizontal: AppGap.w20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(
                AppGap.r6,
              ),
            ),
            color: AppColors.white),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: AppGap.w10,top: AppGap.h5,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chia sẻ với',
                    style: AppStyles.text6016(),
                  ),
                  SizedBox(
                    height: 30,
                    child: InkWell(
                      onTap: () => DialogService.hideDialog(),
                      child: SvgPicture.asset(
                        AppImages.icX,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Divider(),
            _CustomTextFieldWithCopyButton(
              url: widget.urlSite,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: SvgPicture.asset(AppImages.icFbShare),
                  onPressed: () {
                    onButtonTap(ShareEnum.facebook,widget.urlSite);
                  },
                ),
                SizedBox(
                  height: 70,
                  width: 70,
                  child: IconButton(
                    iconSize: 70.h,
                    icon: Image.asset(AppImages.imgMessShare),
                    onPressed: () {
                      Share.share(widget.urlSite);
                      // onButtonTap(ShareEnum.messenger,widget.urlSite);
                    },
                  ),
                ),
                IconButton(
                  icon: SvgPicture.asset(AppImages.icTwitterShare),
                  onPressed: () {
                    onButtonTap(ShareEnum.twitter,widget.urlSite);
                  },
                ),
                SizedBox(
                  height: 70,
                  width: 70,
                  child: IconButton(
                    iconSize: 70.h,
                    icon: Image.asset(AppImages.imgInstagramShare),
                    onPressed: () {
                      onButtonTap(ShareEnum.messenger,widget.urlSite);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  // Future<void> _shareToFacebook(String text) async {
  //   SocialShare.shareOptions(
  //     text,
  //   ).then((data) {
  //     print(data);
  //   });
  // }
  // Future<void> _shareToTwitter(String text) async {
  //   SocialShare.shareTwitter(
  //     "Từ Jancargo",
  //     hashtags: [
  //       "Jancargo",
  //       "NhaphangJP",
  //       "PhuongKhang",
  //     ],
  //     url: text,
  //     trailingText: "cool!!",
  //   ).then((data) {
  //     print(data);
  //   });
  // }

  Future<void> onButtonTap(ShareEnum share,String url) async {
    String msg = 'Mô tả: Link sản phẩm được sao chép từ ứng dụng Jancargo';

    String? response;
    final FlutterShareMe flutterShareMe = FlutterShareMe();
    switch (share) {
      case ShareEnum.facebook:
        response = await flutterShareMe.shareToFacebook(url: url, msg: msg);
        break;
      case ShareEnum.messenger:
         Share.share(url);
        break;
      case ShareEnum.twitter:
        response = await flutterShareMe.shareToTwitter(url: url, msg: msg);
        break;

      case ShareEnum.share_instagram:
        Share.share(url);
        break;
    }
    if(response!.contains('Cannot share thought messenger')){
      DialogService.showNotiBannerInfo(context, 'Có lỗi xảy ra!');
    }
    debugPrint(response);

  }

}

class _CustomTextFieldWithCopyButton extends StatefulWidget {
  final String url;

  const _CustomTextFieldWithCopyButton({Key? key, required this.url})
      : super(key: key);

  @override
  _CustomTextFieldWithCopyButtonState createState() =>
      _CustomTextFieldWithCopyButtonState();
}

class _CustomTextFieldWithCopyButtonState
    extends State<_CustomTextFieldWithCopyButton> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.url);
  }

  @override
  Widget build(BuildContext context) {
    print('widget.url ${widget.url}');
    return Container(
      height: 30.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppGap.r6,
          ),
        ),
        color: AppColors.white,
        border: Border.all(color: AppColors.neutral400Color, width: 1),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: AppGap.w10,vertical: AppGap.h10,
      ),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: TextField(

              controller: _controller,
              style: AppStyles.text4014(color: AppColors.neutral400Color),
              decoration:  InputDecoration(
                contentPadding: EdgeInsets.only(left: AppGap.w5,top: AppGap.h3,),
                isDense: true,
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Khoảng cách giữa TextField và nút sao chép
          GestureDetector(
            onTap: () {
              _copyToClipboard(_controller.text);
            },
            child: Container(
              width: 70.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(
                    AppGap.r4,
                  ),
                  bottomRight: Radius.circular(
                    AppGap.r4,
                  ),
                ),
                color: AppColors.neutral400Color,
              ),
              alignment: Alignment.center, // Màu nút sao chép
              child: Text(
                'Sao chép',
                style: AppStyles.text6014(color: AppColors.primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
