import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jancargo_app/src/app_manager.dart';
import 'package:jancargo_app/src/app_session.dart';
import 'package:jancargo_app/src/domain/dtos/dashboard/recently_viewed/recently_viewed_dto.dart';
import 'package:jancargo_app/src/domain/dtos/detail_product/detail/detail_dto.dart';
import 'package:jancargo_app/src/domain/dtos/detail_product/list/relates_dto.dart';
import 'package:jancargo_app/src/domain/dtos/user/warehouse/warehouse_dto.dart';
import 'package:jancargo_app/src/domain/repositories/cart/cart_repo.dart';
import 'package:meta/meta.dart';

import '../../../data/object_request_api/dashboard/top_shop/top_shop_request.dart';
import '../../../data/object_request_api/search/search_seller/search_seller_request.dart';
import '../../../domain/dtos/detail_product/detail_marcari/detail_marcari_dto.dart';
import '../../../domain/dtos/detail_product/rakuten_detail/rakuten_detail_dto.dart';
import '../../../domain/dtos/detail_product/seller_auction/seller_auction_dto.dart';
import '../../../domain/dtos/detail_product/suggestion_rakuten/suggestion_rakuten_dto.dart';
import '../../../domain/dtos/detail_product/y_shopping/y_shopping_dto.dart';
import '../../../domain/dtos/search/search_shop/search_shopping_dto.dart';
import '../../../domain/repositories/dashboard/dashboard_repo.dart';
import '../../../domain/repositories/detail_product/detail_product_repo.dart';
import '../../../general/constants/app_constants.dart';
import '../../../general/inject_dependencies/inject_dependencies.dart';

part 'detail_product_state.dart';

class DetailProductCubit extends Cubit<DetailProductState> {
  DetailProductCubit() : super(DetailProductInitial(state: null));
  DetailProductRepo get = getIt<DetailProductRepo>();
  DetailDto? detailDto = const DetailDto();
  DashBoardRepo getDash = getIt<DashBoardRepo>();
  CartRepo getCart = getIt<CartRepo>();

  final String site = '';

  /// gán data
  List<ShipModeDto> newShip = [];

  void info(
    String code,
    String source,
  ) {
    emit(DetailProductLoading(state: state));

    switch (source) {
      case 'YAC_JP':
        infoProductAuction(code, 'auction');
        break;

      case 'RAK_JP':
        infoProductRakuten(code, 'rakuten');
        break;

      case 'MER_JP':
        infoProductMarcari(code, 'marcari');
        break;
      case 'YSP_JP':
        infoProductYShopping(code, 'y_shopping');
        break;

      default:
        infoProductAuction(code, 'auction');
    }
  }

  void infoProductAuction(String code, String source) async {
    final response = await get.infoProduct(code);
    response.fold((l) {
      print('có lỗi xảy ra $l');
      return emit(DetailProductFailed(state: state));
    }, (r) async {
      emit(DetailProductInfoDataSuccess(state: state));
      detailDto = r;
      await getCom(code, source);
    });
  }

  void infoProductRakuten(String code, String source) async {
    final response = await get.infoProductRakuten(code);
    response.fold((l) {
      emit(DetailProductFailed(state: state));
    }, (r) async {
      emit(DetailProductInfoDataSuccess(state: state)
        ..rakutenDetailDto = r.data);
      await getComRakuten(code, source, r.data!.storeRakuten!.code!);
    });
  }

  void infoProductMarcari(String code, String source) async {
    getComMercari(code, source);
  }

  void infoProductYShopping(String code, String source) async {
    final response = await get.infoProductYShopping(code);
    response.fold((l) {
      emit(DetailProductFailed(state: state));
    }, (r) async {
      emit(DetailProductInfoDataSuccess(state: state)..yShoppingDetailDto = r);
      await getComYShopping(code, source, r.store!.id!);
    });
  }

  Future<void> getCom(String codeProduct, String source) async {
    try {
      List<DetailProductState?> statusListLoadDataSuccess =
          await Future.wait<DetailProductState?>([
            _fetchCart(),
        _fetchDetail(),
        _fetchRelates(codeProduct),
        _fetchWareHouse(),
        _fetchFavorite(codeProduct)
      ]);
      if (statusListLoadDataSuccess.every((element) => element != null) &&
          statusListLoadDataSuccess[0] is DataSuccessProduct &&
          statusListLoadDataSuccess[1] is DataSuccessProduct &&
          statusListLoadDataSuccess[2] is DataSuccessProduct &&
          statusListLoadDataSuccess[3] is DataSuccessProduct &&
          statusListLoadDataSuccess[4] is DataSuccessProduct) {
        emit(
          statusListLoadDataSuccess[0]!
            ..copy(
              statusListLoadDataSuccess[1]
                ?..copy(
                  statusListLoadDataSuccess[2]
                    ?..copy(statusListLoadDataSuccess[3]
                      ?..copy(statusListLoadDataSuccess[4]),
                    ),
                ),
            ),
        );
        await Future.delayed(const Duration(seconds: 1));
      } else {
        // emit(DetailProductFailed(state: state));
      }
    } catch (e) {
      emit(DetailProductFailed(state: state));
      print('${e} có lỗi xảy ra');
    }
  }

  Future<void> getComRakuten(
      String codeProduct, String source, String sellerId) async {
    try {
      List<DetailProductState?> statusListLoadDataSuccess =
          await Future.wait<DetailProductState?>([
            _fetchCart(),
        _fetchFavorite(codeProduct),
        _fetchWareHouse(),
        _fetchSuggestionsRakuten(sellerId),
        _fetchRecentlyViewedRakuten(sellerId),
      ]);
      if (statusListLoadDataSuccess.every((element) => element != null) &&
          statusListLoadDataSuccess[0] is DataSuccessProduct &&
          statusListLoadDataSuccess[1] is DataSuccessProduct &&
          statusListLoadDataSuccess[2] is DataSuccessProduct &&
          statusListLoadDataSuccess[3] is DataSuccessProduct &&
          statusListLoadDataSuccess[4] is DataSuccessProduct) {
        emit(
          statusListLoadDataSuccess[0]!
            ..copy(
              statusListLoadDataSuccess[1]
                ?..copy(
                  statusListLoadDataSuccess[2]
                    ?..copy(statusListLoadDataSuccess[3]
                    ?..copy(statusListLoadDataSuccess[4]),
                    ),
                ),
            ),
        );
        await Future.delayed(const Duration(seconds: 1));
      } else {
        // emit(DetailProductFailed(state: state));
      }
    } catch (e) {
      emit(DetailProductFailed(state: state));
      print('${e} có lỗi xảy ra');
    }
  }

  Future<void> getComYShopping(
      String codeProduct, String source, String sellerId) async {
    try {
      List<DetailProductState?> statusListLoadDataSuccess =
          await Future.wait<DetailProductState?>([
            _fetchCart(),
        _fetchFavorite(codeProduct),
        _fetchSuggestionsYShopping(sellerId),
        _fetchRecentlyViewedYShopping(sellerId),
        _fetchWareHouse(),
      ]);
      if (statusListLoadDataSuccess.every((element) => element != null) &&
          statusListLoadDataSuccess[0] is DataSuccessProduct &&
          statusListLoadDataSuccess[1] is DataSuccessProduct &&
          statusListLoadDataSuccess[2] is DataSuccessProduct &&
          statusListLoadDataSuccess[3] is DataSuccessProduct &&
          statusListLoadDataSuccess[4] is DataSuccessProduct) {
        emit(
          statusListLoadDataSuccess[0]!
            ..copy(
              statusListLoadDataSuccess[1]
                ?..copy(
                  statusListLoadDataSuccess[2]
                    ?..copy(statusListLoadDataSuccess[3]
                    ?..copy(statusListLoadDataSuccess[4]),
                    ),
                ),
            ),
        );
        await Future.delayed(const Duration(seconds: 1));
      } else {
        // emit(DetailProductFailed(state: state));
      }
    } catch (e) {
      emit(DetailProductFailed(state: state));
      print('${e} có lỗi xảy ra');
    }
  }

  Future<void> getComMercari(String codeProduct, String source) async {
    try {
      List<DetailProductState?> statusListLoadDataSuccess =
          await Future.wait<DetailProductState?>([
            _fetchCart(),
        _fetchDetailMercari(codeProduct),
        _fetchFavorite(codeProduct),
        // _fetchRelates(codeProduct),
        _fetchWareHouse(),
        _fetchRecentlyViewed(codeProduct, source),
      ]);
      if (statusListLoadDataSuccess.every((element) => element != null) &&
          statusListLoadDataSuccess[0] is DataSuccessProduct &&
          statusListLoadDataSuccess[1] is DataSuccessProduct &&
          statusListLoadDataSuccess[2] is DataSuccessProduct &&
          statusListLoadDataSuccess[3] is DataSuccessProduct &&
          statusListLoadDataSuccess[4] is DataSuccessProduct) {
        emit(statusListLoadDataSuccess[0]!
          ..copy(statusListLoadDataSuccess[1]
            ?..copy(statusListLoadDataSuccess[2]
            ?..copy(statusListLoadDataSuccess[3]
            ?..copy(statusListLoadDataSuccess[4]),),),),);
        await Future.delayed(const Duration(seconds: 1));
      }
    } catch (e) {
      print('${e} có lỗi xảy ra');
    }
  }

  Future<DetailProductState?> _fetchDetail() async {
    DetailProductState? state;
    if (detailDto != null) {
      emit(DataDetailsSuccess(state: state)..detailDto = detailDto);
    } else {
      emit(DataDetailsSuccess(state: state));
    }

    return state;
  }

  Future<DetailProductState?> _fetchDetailMercari(String code) async {
    final response = await get.infoProductMarcari(code);
    DetailProductState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(DataDetailsSuccess(state: state)..marcariDetailDto = r);
    });
    return state;
  }

  //get list đã xem gần đây
  Future<DetailProductState?> _fetchRecentlyViewed(
      String codeProduct, String source) async {
    DetailProductState? state;
    if (AppConstants.isToken == null) {
      return state;
    }
    final response = await get.recentlyViewed(
        request: LoadItemRequest(
            size: '20', page: '1', source: source, codeProduct: codeProduct));

    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      //list not [] => push data
      if (r.result!.isNotEmpty) {
        emit(RecentlyViewedDataSuccess(state: state)..recentlyDto = r);
      }
    });
    return state;
  }

  //get list tương tự
  Future<DetailProductState?> _fetchRelates(String codeProduct) async {
    final response = await get.relates(codeProduct);
    DetailProductState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      List<RelatesDto> suggests =
          r.data!.where((e) => e.type == 'suggestion').map((e) => e).toList();
      List<RelatesDto> relates =
          r.data!.where((e) => e.type == 'relate').map((e) => e).toList();
      if (suggests.isNotEmpty) {
        emit(SuggestionsDataSuccess(state: state)..suggestionsDto = suggests);
      }
      if (relates.isNotEmpty) {
        emit(RelatesDataSuccess(state: state)..relatesDto = relates);
      }
      state = DataSuccessProduct(state: state)..relatesDto = r.data;
    });
    return state;
  }

  //get list tương tự
  Future<DetailProductState?> _fetchWareHouse() async {
    final response = await get.warehouse();
    DetailProductState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {

      for (int i = 0; i < r.results!.length; i++) {
        newShip.addAll(r.results![i].shipMode!.where((e) => e.active == true));
      }
      emit(WareHouseDataSuccess(state: state)
        ..wareHouseDataDto = (r.results)
        ..shipModeDto = newShip);

      state = DataSuccessProduct(state: state)
        ..wareHouseDataDto = r.results!
        ..shipModeDto = newShip;
    });
    return state;
  }

  /// favorite
  Future<DetailProductState?> _fetchCart() async {
    final response = await getCart.itemCart();
    DetailProductState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {


        emit(CartDataSuccess(state: state)..numberItemCart = r.data!.length);

      state = DataSuccessProduct(state: state)..numberItemCart = r.data!.length;
    });
    return state;
  }

  /// favorite
  Future<DetailProductState?> _fetchFavorite(String code) async {
    final response = await get.favorites();
    DetailProductState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      var isFavorite = r.results!.any((e) => e.code == code);
      if (isFavorite) {
        emit(FavoriteDataSuccess(state: state));
      }
      state = DataSuccessProduct(state: state);
    });
    return state;
  }

  /// y shopping
  //search seller Y shopping
  Future<DetailProductState?> _fetchSuggestionsYShopping(
      String sellerId) async {
    final response = await get.suggestionsYShopping(
        request: SuggestionRequest(
            size: AppConstants.sizeApi, sellerId: sellerId, sort: "-score"));
    DetailProductState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(SuggestionsDataSuccess(state: state)..suggestionsShoppingDto = r);
      state = DataSuccessProduct(state: state)..suggestionsShoppingDto = r;
    });
    return state;
  }

  Future<DetailProductState?> _fetchRecentlyViewedYShopping(
      String sellerId) async {
    final LoadItemRequest request = LoadItemRequest(
        size: '20', page: '1', source: "shopping", codeProduct: sellerId);

    final response = await get.recentlyViewedYShopping(request: request);
    DetailProductState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(RecentlyViewedDataSuccess(state: state)..recentlyDto = r);
      state = DataSuccessProduct(state: state)..recentlyDto = r;
    });
    return state;
  }

  ///rakuten
//search seller Y shopping
  Future<DetailProductState?> _fetchSuggestionsRakuten(String sellerId) async {
    final response = await get.suggestionsRakuten();
    DetailProductState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(SuggestionsDataSuccess(state: state)..suggestionRakutenDto = r);
      state = DataSuccessProduct(state: state)..suggestionRakutenDto = r;
    });
    return state;
  }

  Future<DetailProductState?> _fetchRecentlyViewedRakuten(
      String sellerId) async {
    final LoadItemRequest request = LoadItemRequest(
        size: '20', page: '1', source: "rakuten", codeProduct: sellerId);

    final response = await get.recentlyViewedYShopping(request: request);
    DetailProductState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(RecentlyViewedDataSuccess(state: state)..recentlyDto = r);
      state = DataSuccessProduct(state: state)..recentlyDto = r;
    });
    return state;
  }
}
