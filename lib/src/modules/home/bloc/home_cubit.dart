import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:jancargo_app/src/data/object_request_api/dashboard/auction/auction_request.dart';
import 'package:jancargo_app/src/data/object_request_api/dashboard/top_shop/top_shop_request.dart';
import 'package:jancargo_app/src/domain/dtos/cart/item_cart/item_cart_dto.dart';
import 'package:jancargo_app/src/domain/dtos/dashboard/banner_slider/banner_slider_dto.dart';
import 'package:jancargo_app/src/domain/dtos/dashboard/quick/quick_dto.dart';
import 'package:jancargo_app/src/domain/dtos/dashboard/top_categories/top_categories_dto.dart';
import 'package:jancargo_app/src/domain/dtos/favorite/favorite_dto.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_mercari/search_mercari_dto.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_rakuten/search_rakuten_dto.dart';
import 'package:jancargo_app/src/domain/repositories/cart/cart_repo.dart';
import 'package:jancargo_app/src/domain/repositories/detail_product/detail_product_repo.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';

import '../../../data/object_request_api/dashboard/banner_slider/banner_slider_request.dart';
import '../../../data/object_request_api/dashboard/quick/quick_request.dart';
import '../../../data/object_request_api/search/search_seller/search_seller_request.dart';
import '../../../domain/dtos/dashboard/auction/auction_dto.dart';
import '../../../domain/dtos/dashboard/flash_sale/flash_sale_dto.dart';
import '../../../domain/dtos/dashboard/recently_viewed/recently_viewed_dto.dart';
import '../../../domain/dtos/dashboard/top_shop/top_shop_dto.dart';
import '../../../domain/dtos/search/search_shop/search_shopping_dto.dart';
import '../../../domain/repositories/dashboard/dashboard_repo.dart';
import '../../../general/inject_dependencies/inject_dependencies.dart';

part 'home_state.dart';
@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(DashboardInitial()){
    fetchInit();
  }
  DashBoardRepo get = getIt<DashBoardRepo>();
  CartRepo getCart = getIt<CartRepo>();
  DetailProductRepo getFavorite = getIt<DetailProductRepo>();

  CartDto? cartDto = const CartDto(data:  []);
  final LoadItemRequest request = LoadItemRequest(size: '20',page: '1');

  Future<void> initEvent() async {

    try {
      List<HomeState?> statusListLoadDataSuccess = await Future.wait<
          HomeState?>([_fetchBannerSlider(),_fetchQuick(),
            _fetchFlashSale(), _fetchRecentlyViewed(),
            _fetchTopShop(),_fetchAuction(),
            _fetchSearchYShopping(),_fetchSearchMercari(),
            _fetchSearchRakuten()]);
      if (statusListLoadDataSuccess.every((element) => element != null) &&
          statusListLoadDataSuccess[0] is DashboardSuccessState &&
          statusListLoadDataSuccess[1] is DashboardSuccessState &&
          statusListLoadDataSuccess[2] is DashboardSuccessState &&
          statusListLoadDataSuccess[3] is DashboardSuccessState &&
          statusListLoadDataSuccess[4] is DashboardSuccessState &&
          statusListLoadDataSuccess[5] is DashboardSuccessState &&
          statusListLoadDataSuccess[6] is DashboardSuccessState &&
          statusListLoadDataSuccess[7] is DashboardSuccessState &&
          statusListLoadDataSuccess[8] is DashboardSuccessState
      ) {
        emit(statusListLoadDataSuccess[0]!
          ..copy(statusListLoadDataSuccess[1])
          ..copy(statusListLoadDataSuccess[2])
          ..copy(statusListLoadDataSuccess[3])
          ..copy(statusListLoadDataSuccess[4])
          ..copy(statusListLoadDataSuccess[5])
          ..copy(statusListLoadDataSuccess[6])
          ..copy(statusListLoadDataSuccess[7])
          ..copy(statusListLoadDataSuccess[8])
        );
        await Future.delayed(const Duration(seconds: 1));
      }
    }catch(e){
      print('${e} có lỗi xảy ra');
    }
  }
  /// favorite
  Future<void> fetchInit() async {
    emit(DashboardLoading());
    final response = await getCart.itemCart();
    response.fold((l) {
      // no action need analytics in future
      // emit(CartDataSuccess(state: state)..cartDto = r);
      initEvent();
    }, (r) async {
      // add data => check product carded
      cartDto = r;
      // emit(CartDataSuccess(state: state)..cartDto = r);
      initEvent();

    });
  }

  /// favorite
  Future<HomeState?> _fetchFavorite() async {
    final response = await getFavorite.favorites();
    HomeState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {

        emit(FavoriteDataSuccess(state: state)..favoriteSearchDto = r);

      state = FavoriteDataSuccess(state: state);
    });
    return state;
  }

  //get list flash sale
  Future<HomeState?> _fetchFlashSale() async {
    final response = await get.flashSale();
    HomeState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      if(cartDto!.data != []){
        List<ItemCartDto> carts = cartDto!.data!;
        List<ItemSaleDto> flashSales = r.data!;
        // check isCarded
        for (var cartItem in carts) {
          for (var flashSaleItem in flashSales) {
            if (cartItem.code == flashSaleItem.code) {
              print('object ${cartItem.code == flashSaleItem.code}');
              flashSaleItem.isItemSavedCart = true;

              break; // Nếu tìm thấy trùng, thoát vòng lặp nội
            }
          }
        }
        emit(FlashSaleDataSuccess(state: state)..flashSaleDto = FlashSaleDto(data: flashSales));
        state = FlashSaleDataSuccess(state: state)
          ..flashSaleDto = FlashSaleDto(data: flashSales);
      }

      emit(FlashSaleDataSuccess(state: state)..flashSaleDto = FlashSaleDto(data: r.data));
      state = FlashSaleDataSuccess(state: state)
        ..flashSaleDto = FlashSaleDto(data: r.data);

    });
    return state;
  }
  //get list nhà bán nổi bật
  Future<HomeState?> _fetchTopShop() async {
    final response = await get.topShop(request: request);
    HomeState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(TopShopDataSuccess(state: state)..topShopDto = r);
      state = TopShopDataSuccess(state: state)
       ..topShopDto = r;

    });
    return state;
  }

  Future<HomeState?> _fetchTopCategories() async {
    final response = await get.topCategories(request: request);
    HomeState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {

      state = TopCategoriesDataSuccess(state: state)
        ..topCategoriesDto = state?.topCategoriesDto;

    });
    return state;
  }
  //get list đã xem gần đây
  Future<HomeState?> _fetchRecentlyViewed() async {

    HomeState? state;
    Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
    final token = hiveBox.get(AppConstants.ACCESS_TOKEN);
    if(token != null || token != ""){
      return state;
    }
    final response = await get.recentlyViewed(request: request);
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      if(r.result!.isEmpty){
        return;
      }
      emit(RecentlyViewedDataSuccess(state: state)..recentlyDto = r);
      state = RecentlyViewedDataSuccess(state: state)
        ..recentlyDto = r;
    });
    return state;
  }
  //get list banner home
  Future<HomeState?> _fetchBannerSlider() async {
    final response = await get.bannerSlider(request: BannerSliderRequest(page: '1',size: AppConstants.sizeApi,status: 'true',typePage: 'home'));
    HomeState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(BannerSliderDataSuccess(state: state)..bannerSliderDto = r);
      state = BannerSliderDataSuccess(state: state)
        ..bannerSliderDto = r;
    });
    return state;
  }

  //get list type product
  Future<HomeState?> _fetchQuick() async {
    final response = await get.quick(request: QuickRequest(page: '1',size: AppConstants.sizeApi,status: 'true'));
    HomeState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(QuickDataSuccess(state: state)..quickDto = r);
      state = QuickDataSuccess(state: state)
        ..quickDto = r;

    });
    return state;
  }

  //get list sản phẩm đấu giá
  Future<HomeState?> _fetchAuction() async {
    final response = await get.auction(request: AuctionRequest(size: AppConstants.sizeApi,category: '23260'));
    HomeState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(AuctionDataSuccess(state: state)..auctionDto = r);
      state = AuctionDataSuccess(state: state)
        ..auctionDto = r;

    });
    return state;
  }

  //search seller Y shopping
  Future<HomeState?> _fetchSearchYShopping() async {
    final response = await get.searchYShopping(request: SearchSellerRequest(size: AppConstants.sizeApi,query: AppConstants.querySearch,));
    HomeState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      if(cartDto!.data == []){
        emit(SearchDataSuccess(state: state)..searchShoppingDto = SearchShoppingDto(results: r.results));
        state = SearchDataSuccess(state: state)
          ..searchShoppingDto = SearchShoppingDto(results: r.results);
        return;
      }
      List<ItemCartDto> carts = cartDto!.data!;
      List<ItemsShoppingDto> yShoppings = r.results!;
      // check isCarded
      for (var cartItem in carts) {
        for (var yShoppingItem in yShoppings) {
          if (cartItem.code == yShoppingItem.code) {
            yShoppingItem.isItemSavedCart = true;

            break; // Nếu tìm thấy trùng, thoát vòng lặp nội
          }
        }
      }
      emit(SearchDataSuccess(state: state)..searchShoppingDto = SearchShoppingDto(results: yShoppings));
      state = SearchDataSuccess(state: state)
        ..searchShoppingDto = SearchShoppingDto(results: yShoppings);

    });
    return state;
  }
  //get list mercari
  Future<HomeState?> _fetchSearchMercari() async {
    final response = await get.searchMercari();
    HomeState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      if(cartDto!.data == []){
        emit(SearchMercariDataSuccess(state: state)..searchMercariDto = SearchMercariDto(data: r.data));
        state = SearchMercariDataSuccess(state: state)
          ..searchMercariDto = SearchMercariDto(data: r.data);
      }
      List<ItemCartDto> carts = cartDto!.data!;
      List<MercarisDto> mercaris = r.data!;
      // check isCarded
      for (var cartItem in carts) {
        for (var mercariItem in mercaris) {
          if (cartItem.code == mercariItem.code) {
            mercariItem.isItemSavedCart = true;

            break; // Nếu tìm thấy trùng, thoát vòng lặp nội
          }
        }
      }
      emit(SearchMercariDataSuccess(state: state)..searchMercariDto = SearchMercariDto(data: mercaris));
      state = SearchMercariDataSuccess(state: state)
        ..searchMercariDto = SearchMercariDto(data: mercaris);

    });
    return state;
  }

  //get list rakuten
  Future<HomeState?> _fetchSearchRakuten() async {
    final response = await get.searchRakuten(request: SearchSellerRequest(size: AppConstants.sizeApi,query: AppConstants.querySearchRakuten,));
    HomeState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      if(cartDto!.data != []){
        emit(SearchRakutenDataSuccess(state: state)..searchRakutenDto = SearchRakutenDto(data: r.data));
        state = SearchRakutenDataSuccess(state: state)
          ..searchRakutenDto = SearchRakutenDto(data: r.data);
        return;
      }
      List<ItemCartDto> carts = cartDto!.data!;
      List<RakutensDto> rakutens = r.data!;
      // check isCarded
      for (var cartItem in carts) {
        for (var rakutenItem in rakutens) {
          if (cartItem.code == rakutenItem.code) {
           rakutenItem.isItemSavedCart = true;

            break; // Nếu tìm thấy trùng, thoát vòng lặp nội
          }
        }
      }
      emit(SearchRakutenDataSuccess(state: state)..searchRakutenDto = SearchRakutenDto(data: rakutens));
      state = SearchRakutenDataSuccess(state: state)
        ..searchRakutenDto = SearchRakutenDto(data: rakutens);

    });
    return state;
  }

  //get list nhà bán nổi bật
  void fetchTopShop(String site) async {
   await Future.delayed(const Duration(milliseconds: 600),(){
     emit(TopShopDataLoading(state: state));
   });

    final response = await get.topShop(request: LoadItemRequest(size: '20',page: '1',site: site));
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(TopShopDataSuccess(state: state)..topShopDto = r);
    });
  }
}
