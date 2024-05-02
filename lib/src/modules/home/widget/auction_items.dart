import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:jancargo_app/src/components/bloc/favorite/favorite_cubit.dart';
import 'package:jancargo_app/src/domain/dtos/dashboard/auction/auction_dto.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../components/resource/molecules/app_carousel_image.dart';
import '../../../components/resource/molecules/btn_seen_all.dart';
import '../../../components/resource/molecules/line_time.dart';
import '../../../components/resource/molecules/shape_time_widget.dart';
import '../../../data/object_request_api/favorite/favorite_request.dart';
import '../../../domain/dtos/favorite/favorite_dto.dart';
import '../../../general/constants/app_constants.dart';
import '../../../util/app_convert.dart';
import '../../auth/login/screens/login_screen.dart';
import '../../details_product_auction/screens/details_product_screen.dart';
import '../../list_seller/screens/auctions.dart';

class AuctionItems extends StatefulWidget {
  const AuctionItems({
    super.key,
    required this.dto,
  });

  final AuctionDto dto;

  @override
  State<AuctionItems> createState() => _AuctionItemsState();
}

class _AuctionItemsState extends State<AuctionItems> {
  final FavoriteCubit _cubitFavorite = FavoriteCubit();
  Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
  late String? token;
  @override
  void initState() {
    super.initState();
   token = hiveBox.get(AppConstants.ACCESS_TOKEN);
     if(token != null || token != ""){
       _cubitFavorite.favorites();
     }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteCubit(),
      child: Container(
          color: AppColors.white,
          padding: EdgeInsets.symmetric(
              vertical: AppGap.h10, horizontal: AppGap.w10),
          margin: EdgeInsets.only(bottom: AppGap.h10),
          child: Column(
            children: [
              _title(),
              AppGap.sbH10,
              _items(),
            ],
          )),
    );
  }

  Widget _title() => Row(
        children: [
          Container(
              color: AppColors.white,
              padding: EdgeInsets.all(AppGap.w3),
              margin: EdgeInsets.only(right: AppGap.w5),
              child: Image.asset(AppImages.imgAuction,height: 24.h,width: 24.w,),),
          Text(
            'Sản phẩm đấu giá',
            style: AppStyles.text6020(),
          ),
          const Spacer(),
          SeenAllBtn(
            onTap: () => RouteService.routeGoOnePage(const Auctions()),
          ),
        ],
      );

  Widget _items() => SizedBox(
        height: AppGap.h245,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return _item(widget.dto.results![index]);
            },
            separatorBuilder: (context, i) {
              return AppGap.sbW8;
            },
            itemCount: widget.dto.results!.length),
      );

  Widget _item(AuctionItemsDto itemsDto) {
    return ItemAuction(
      itemsDto: itemsDto,
      cubit: _cubitFavorite,
    );
  }
}

class ItemAuction extends StatefulWidget {
  const ItemAuction({super.key, required this.itemsDto, required this.cubit});

  final AuctionItemsDto itemsDto;
  final FavoriteCubit cubit;

  @override
  State<ItemAuction> createState() => _ItemAuctionState();
}

class _ItemAuctionState extends State<ItemAuction> {
  AuctionItemsDto get itemsDto => widget.itemsDto;
  ValueNotifier<bool> isFavorite = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => RouteService.routeGoOnePage(ProductDetailsScreen(
        code: itemsDto.code!,
        source: AppConstants.auctionShoppingSource,
      ),),
      child: Ink(
        width: AppGap.w144,
        height: AppGap.h144,
        child: Stack(
          children: [
            Column(
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
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding:  EdgeInsets.only(left: AppGap.w20,top: AppGap.h10),
                        child: Image.asset(AppImages.imgAuction,height: 24.h,width: 24.w,),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ColoredBox(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Expanded(
                              child: ShapeTimeWidget(
                                  widget: LineTimer(
                                dateString: itemsDto.endTime!,
                              )),
                            ),
                            SizedBox(width: AppGap.w24),
                            // SvgPicture.asset(AppImages.icHammer, width: 16, height: 16,),
                            // SizedBox(width: 6),
                            // Text('100', style: AppStyles.text5012(color: AppColors.neutral800Color),),
                            // SizedBox(width: 3),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  itemsDto.name!,
                  style: AppStyles.text5012(color: AppColors.black03),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(AppImages.icHammer,),
                    Expanded(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: " ${itemsDto.bids.toString()}",
                              style: AppStyles.text5012(
                                  color: AppColors.neutral700Color)),
                          TextSpan(
                            text: " lượt đấu giá",
                            style: AppStyles.text4012(
                                color: AppColors.neutral500Color),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
                Text(
                  AppConvert.convertAmountVn(itemsDto.price!),
                  style: AppStyles.text4012(color: AppColors.primary700Color),
                ),
              ],
            ),
            Positioned(
              bottom: 10,
              right: 0,
              child:   FavoriteIcon(
              favorite: itemsDto.favorite,
              code: itemsDto.code!,
              siteCode: itemsDto.code!,
              name: itemsDto.name!,
              price: itemsDto.price!,
              currency: itemsDto.priceBuy!.toString(),
              endTime: itemsDto.endTime!,
              url: itemsDto.url!,
              image:  itemsDto.image!,
              cubit: widget.cubit,
            ),)
          ],
        ),
      ),
    );
  }
}

class FavoriteIcon extends StatefulWidget {
  const FavoriteIcon({super.key, required this.favorite, required this.cubit, required this.code, required this.name, required this.siteCode, required this.price, required this.endTime, required this.image, required this.currency, required this.url});

  final ValueNotifier<bool> favorite;
  final FavoriteCubit cubit;
  final String code;
  final String name;
  final String siteCode;
  final int price;
  final String endTime;
  final String image;
  final String currency;
  final String url;

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  late ValueNotifier<bool> favorite;

  @override
  void initState() {
    super.initState();
    favorite = widget.favorite;
    init();
  }

  void init(){
    Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
    final  token = hiveBox.get(AppConstants.ACCESS_TOKEN);
    if(token != null && token != "") {
      print('điều kiện có sai không');
      return  widget.cubit.favorites();;
    }
  }
  void favoriteHandle( ValueNotifier<bool> favorite,) async{
    Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
  final  token = hiveBox.get(AppConstants.ACCESS_TOKEN);
    if(token == null && token == "") {
      await RouteService.routeGoOnePage(const LoginScreen(isLoginBack: true,));
      return;
    }
    favorite.value = !favorite.value;

    widget.cubit.favoriteItem(FavoriteRequest(
        code: widget.code,
        siteCode: widget.code,
        name: widget.name,
        price: widget.price,
        endTime: widget.endTime,
        images: [widget.image],
        qty: 1,
        currency: widget.currency,
        url: widget.url
    ),);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      bloc: widget.cubit,
      buildWhen: (prv, state) => state is FavoritesSuccess,
      builder: (context, state) {
        if (state is FavoritesSuccess) {
    // Lọc phần tử thích hợp từ danh sách favoriteDto
    final favoriteItem = state.favoriteDto!.data!.firstWhere((e) => e.code! == widget.code, orElse: () => FavoriteItems(/* provide default values here */));

    // Gán giá trị của favorite.value dựa trên trạng thái của favoriteItem
    favorite.value = favoriteItem.code != null ? true : false;
    }// defaultValue là giá trị mặc định nếu không tìm thấy phần tử thích hợp

          return ValueListenableBuilder(
            valueListenable: favorite,
            builder: (BuildContext context, value, Widget? child) {
              return IconButton(
                onPressed: () => favoriteHandle(favorite),
                icon: SvgPicture.asset(
                  value ? AppImages.icHeartBold : AppImages.icHeart,
                  color: value
                      ? AppColors.primary700Color
                      : AppColors.neutral600Color,
                ),
                iconSize: AppGap.h20,
              );
            },
          );
        }



    );
  }
}
