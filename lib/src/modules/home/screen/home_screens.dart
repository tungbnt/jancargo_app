import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jancargo_app/src/components/resource/molecules/shimmer_product.dart';
import 'package:jancargo_app/src/components/resource/molecules/shimmer_sale.dart';
import 'package:jancargo_app/src/domain/dtos/dashboard/banner_slider/banner_slider_dto.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/dashboard/screens/dashboard_screen.dart';
import 'package:jancargo_app/src/modules/home/bloc/home_cubit.dart';
import 'package:jancargo_app/src/modules/home/components/flash_sale.dart';
import 'package:jancargo_app/src/modules/home/widget/widget_field_home.dart';
import 'package:jancargo_app/src/modules/searchs/screens/searchs_screens.dart';
import 'package:jancargo_app/src/modules/web_view/screen/web_view_no_scaffold.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../components/resource/molecules/cached_network_shaped_image.dart';
import '../../../components/resource/molecules/shimmer_items.dart';
import '../../../general/constants/app_images.dart';
import '../../../general/constants/app_storage.dart';
import '../../list_item_store/screens/marcari_list_item.dart';
import '../../list_item_store/screens/rakuten_list_item.dart';
import '../../list_item_store/screens/y_shopping_list_item.dart';
import '../../list_seller/screens/amazon_js.dart';
import '../../list_seller/screens/auctions.dart';
import '../../list_seller/screens/paypays.dart';
import '../components/ItemType.dart';
import '../components/home_shimmer.dart';
import '../components/mercari_items.dart';
import '../components/outstanding_seller.dart';
import '../components/rakutenItems.dart';
import '../components/recently_viewed.dart';
import '../components/y_shopping_items.dart';
import '../widget/auction_items.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeCubit _cubit = HomeCubit();
  final ValueNotifier<int> _currentPageSlider = ValueNotifier(0);
  final ValueNotifier<bool> _isShowSearch = ValueNotifier(false);
  String searchText = '';
  final TextEditingController _controller =
      TextEditingController(text: 'Initial Text');


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.neutral100Color,

        appBar: _appBar(),
        // AppBar(
        //   backgroundColor: AppColors.yellow700Color,
        //   title: const Text('Home'),
        //   actions: [
        //     IconButton(
        //       icon: const Icon(Icons.search),
        //       onPressed: () => RouteService.routeGoOnePage(const SearchsScreens(
        //         category: "",
        //       )),
        //     )
        //   ],
        // ),
        body: SafeArea(
          child: ScreenBodyContextProvider(
            context: context,
            page: 'Home',
            scrollController: PrimaryScrollController.maybeOf(context),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _store(),
                  _banner(),
                  _itemType(),
                  _recentlyViewed(),
                  _flashSale(),
                  _outstandingSeller(context),
                  _auctionItems(),
                  _yShoppingItems(),
                  _rakutenItems(),
                  _mercariItems(),
                  // GestureDetector(
                  //   onTap: () => RouteService.routeGoOnePage(
                  //     const PersonalScreen(),
                  //   ),
                  //   child: const Text('abc'),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _store() => Container(
      height: AppGap.h40,
      color: AppColors.white,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, int i) {
            return GestureDetector(
              onTap: () {
                switch(i){
                  case 0: RouteService.routeGoOnePage(const SearchsScreens(
                    category: "",
                  ),);
                  case 1:  RouteService.routeGoOnePage(const Auctions());
                  break;
                  case 2:  RouteService.routeGoOnePage( YShoppingListItem(cartDto: _cubit.cartDto!,));
                  break;
                  case 3:  RouteService.routeGoOnePage(const RakutenListItem());
                  break;
                  case 4:  RouteService.routeGoOnePage(const MarcariListItem());
                  break;
                  case 5:  RouteService.routeGoOnePage(const PayPays());
                  break;
                  case 6:  RouteService.routeGoOnePage(const AmazonJS());
                  break;

                  default: RouteService.routeGoOnePage(const SearchsScreens(
                    category: "",
                  ),);
                }
                // if (i == 0) {
                //   RouteService.routeGoOnePage(const SearchsScreens(
                //     category: "",
                //   ));
                // } else if (i == 1) {
                //   RouteService.routeGoOnePage(const Auctions());
                // } else if (i == 2) {
                //   RouteService.routeGoOnePage(const YShoppingListItem());
                // } else if (i == 3) {
                //   RouteService.routeGoOnePage(const RakutenListItem());
                // } else if (i == 4) {
                //   RouteService.routeGoOnePage(const MarcariListItem());
                // } else if (i == 5) {
                //   RouteService.routeGoOnePage(const PayPays());
                // } else if (i == 6) {
                //   RouteService.routeGoOnePage(const AmazonJS());
                // }
                // else if(i == 7){
                //   return RouteService.routeGoOnePage(Rakutens(dto: dto));
                // }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  i != 0
                      ? Image.asset(AppStorage.items[i]['icon'],height: 24.h,width: 24.w,)
                      : const SizedBox.shrink(),
                  AppGap.sbW8,
                  Text(
                    AppStorage.items[i]['text'],
                    style: AppStyles.text6014(color: AppColors.neutral600Color),
                  ),
                  i <= AppStorage.items.length - 1
                      ? Container(
                          width: 1.0,
                          margin: EdgeInsets.symmetric(
                              vertical: AppGap.h5, horizontal: AppGap.w8),
                          // Chiều rộng của thanh dọc
                          color: AppColors
                              .neutral200Color, // Màu sắc của thanh dọc
                        )
                      : const SizedBox.shrink()
                ],
              ),
            );
          },
          separatorBuilder: (context, int i) {
            return const SizedBox.shrink();
          },
          itemCount: AppStorage.items.length));

  Widget _banner() => BlocBuilder<HomeCubit, HomeState>(
        bloc: _cubit,
        buildWhen: (pre, current) =>
            current is BannerSliderDataSuccess || current is DashboardLoading,
        builder: (context, state) {
          if (state is BannerSliderDataSuccess) {
            List<String?> image = state.bannerSliderDto!.results!
                .where((e) => e.type == "main")
                .map((e) {
              if (e.image != null && !e.image!.startsWith("http")) {
                return "https://jancargo.com/${e.image}";
              } else {
                return e.image;
              }
            }).toList();
            return Padding(
              padding: EdgeInsets.only(
                  left: AppGap.w8, right: AppGap.w8, top: AppGap.h10),
              child: ValueListenableBuilder(
                builder: (context, value, Widget? child) {
                  return CarouselSlider(
                    items: image.map(
                      (url) {
                        return GestureDetector(
                          onTap: ()async{
                            //
                            List<BannerDto>? results = state.bannerSliderDto!.results;

                            if(url == image[0]){
                              await RouteService.routeGoOnePage(WebViewNoScaffoldScreen(url: results![0].url!,));
                            }else if(url == image[1]){
                              await RouteService.routeGoOnePage(WebViewNoScaffoldScreen(url: results![1].url!,));
                            }else if(url == image[2]){
                              await RouteService.routeGoOnePage(WebViewNoScaffoldScreen(url: results![2].url!,));
                            }else if(url == image[3]){
                              await RouteService.routeGoOnePage(WebViewNoScaffoldScreen(url: results![3].url!,));
                            }else if(url == image[4]){
                              await RouteService.routeGoOnePage(WebViewNoScaffoldScreen(url: results![4].url!,));
                            }else if(url == image[5]){
                              await RouteService.routeGoOnePage(WebViewNoScaffoldScreen(url: results![5].url!,));
                            }else if(url == image[6]){
                              await RouteService.routeGoOnePage(WebViewNoScaffoldScreen(url: results![6].url!,));
                            }else if(url == image[7]){
                              await RouteService.routeGoOnePage(WebViewNoScaffoldScreen(url: results![7].url!,));
                            }else if(url == image[8]){
                              await RouteService.routeGoOnePage(WebViewNoScaffoldScreen(url: results![8].url!,));
                            }
                          },
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
                  );
                },
                valueListenable: _currentPageSlider,
              ),
            );
          }
          return const BannerSliderShimmer();
        },
      );

  // //type product
  Widget _itemType() => Padding(
        padding: EdgeInsets.symmetric(vertical: AppGap.h10),
        child: BlocBuilder<HomeCubit, HomeState>(
            bloc: _cubit,
            buildWhen: (pre, current) => current is QuickDataSuccess,
            builder: (context, state) {
              if (state is QuickDataSuccess) {
                return ItemType(
                  quickDto: state.quickDto!,
                );
              }
              return const ShimmerItems();
            }),
      );

  // //sp đã xem
  Widget _recentlyViewed() => BlocBuilder<HomeCubit, HomeState>(
      bloc: _cubit,
      buildWhen: (pre, current) => current is RecentlyViewedDataSuccess,
      builder: (context, state) {
        if (state is RecentlyViewedDataSuccess) {
          return RecentlyViewed(
            dto: state.recentlyDto!,
          );
        }
        return const SizedBox.shrink();
      });

  //flash sale
  Widget _flashSale() => BlocBuilder<HomeCubit, HomeState>(
      bloc: _cubit,
      buildWhen: (pre, current) => current is FlashSaleDataSuccess,
      builder: (context, state) {
        if (state is FlashSaleDataSuccess) {
          return FlashSaleItems(
            dto: state.flashSaleDto!,
          );
        }
        return const ShimmerProduct();
      });

  //nhà bán nổi bật
  Widget _outstandingSeller(BuildContext context) =>
      BlocBuilder<HomeCubit, HomeState>(
          bloc: _cubit,
          buildWhen: (pre, current) => current is TopShopDataSuccess,
          builder: (context, state) {
            if (state is TopShopDataSuccess) {
              return OutstandingSeller(
                topShopDto: state.topShopDto!,
                cubit: _cubit,
              );
            }
            return ShimmerSale();
          });

  //sản phẩm đấu giá
  Widget _auctionItems() => BlocBuilder<HomeCubit, HomeState>(
      bloc: _cubit,
      buildWhen: (pre, current) => current is AuctionDataSuccess,
      builder: (context, state) {
        if (state is AuctionDataSuccess) {
          return AuctionItems(
            dto: state.auctionDto!,
          );
        }
        return const SizedBox.shrink();
      });

  //YShopping
  Widget _yShoppingItems() => BlocBuilder<HomeCubit, HomeState>(
      bloc: _cubit,
      buildWhen: (pre, current) => current is SearchDataSuccess,
      builder: (context, state) {
        if (state is SearchDataSuccess) {
          return YShoppingItems(
            dto: state.searchShoppingDto!,
            cubit: _cubit,
          );
        }
        return const SizedBox.shrink();
      });

  //rakuten
  Widget _rakutenItems() => BlocBuilder<HomeCubit, HomeState>(
      bloc: _cubit,
      buildWhen: (pre, current) => current is SearchRakutenDataSuccess,
      builder: (context, state) {
        if (state is SearchRakutenDataSuccess) {
          return RakutenItems(
            dto: state.searchRakutenDto!,
            cubit: _cubit,
          );
        }
        return const SizedBox.shrink();
      });

  //mercari
  Widget _mercariItems() => BlocBuilder<HomeCubit, HomeState>(
      bloc: _cubit,
      buildWhen: (pre, current) => current is SearchMercariDataSuccess,
      builder: (context, state) {
        if (state is SearchMercariDataSuccess) {
          return MercariItems(
            dto: state.searchMercariDto!,
            cubit: _cubit,
          );
        }
        return const SizedBox.shrink();
      });

  PreferredSizeWidget _appBar() => AppBar(
        backgroundColor: AppColors.yellow800Color,
        leading: null,
        centerTitle: true,
        title: ValueListenableBuilder(
          valueListenable: _isShowSearch,
          builder: (context,_,__) {
            return _isShowSearch.value ?  WidgetFieldHome(callback: (){
              _isShowSearch.value = false;
            },) : Row(
              children: [
                SvgPicture.asset(AppImages.icLogoHome),
                 Text('Jancargo',style: AppStyles.text7024(color: AppColors.neutral800Color),),
              ],
            );
          }
        ),
    actions: [ValueListenableBuilder(
      valueListenable: _isShowSearch,
      builder: (context,_,__) {
        return _isShowSearch.value ? SizedBox.shrink() : Row(children: [
          IconButton(onPressed: (){
            _isShowSearch.value = true;
          }, icon: SvgPicture.asset(AppImages.icSearchSmall),),SvgPicture.asset(AppImages.icNotification),AppGap.sbW12,
        ],);
      }
    )],

      );



// Widget _test()=> StoreWidget(url: '', name: 'Bùi Nhật Tùng', totalRate: '11', percent: '00',);
}
