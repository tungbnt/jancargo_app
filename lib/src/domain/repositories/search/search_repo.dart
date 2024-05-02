import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:jancargo_app/src/domain/dtos/dashboard/auction/auction_dto.dart';
import 'package:jancargo_app/src/domain/dtos/object_resolver/rakuten_resolver/rakuten_resolver_dto.dart';
import 'package:jancargo_app/src/domain/dtos/search/producer_search/producer_search_dto.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_suggestion/search_suggestion_dto.dart';
import 'package:jancargo_app/src/modules/search/store_search_cubit/abstract_store_search/abstract_store_search_cubit.dart';

import '../../../data/datasource/search/search_auction_datasource.dart';
import '../../../data/object_request_api/dashboard/auction/auction_request.dart';
import '../../../data/object_request_api/key_word/search_key_word_request.dart';
import '../../../data/object_request_api/search/search_seller/search_seller_request.dart';
import '../../../data/remote/middle-handler/failure.dart';
import '../../../data/remote/middle-handler/result-handler.dart';
import '../../../general/inject_dependencies/inject_dependencies.dart';
import '../../dtos/auction/auction_search/auction_search_dto.dart';
import '../../dtos/search/amazon_js_search_keyword/amazon_js_search_keyword_dto.dart';
import '../../dtos/search/mecari_search_key_word/mecari_search_key_word_dto.dart';
import '../../dtos/search/paypay_search_keyword/paypay_search_keyword_dto.dart';
import '../../dtos/search/rakuten_search_key_word/rakuten_search_key_word_dto.dart';
import '../../dtos/search/search_all/search_all_dto.dart';
import '../../dtos/search/search_mercari/search_mercari_dto.dart';
import '../../dtos/search/search_popular/search_popular_dto.dart';
import '../../dtos/search/search_rakuten/search_rakuten_dto.dart';
import '../../dtos/search/search_shop/search_shopping_dto.dart';

@Singleton()
class SearchRepo {
  SearchDatasource get _searchSource => getIt<SearchDatasource>();
  //search seller
  Future<Either<Failure, SearchShoppingDto>> searchYShopping(
      {required SearchKeyWordRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _searchSource.yahooShoppingKeyWord(request: request);
    });
  }
  Future<Either<Failure, SearchAllDto>> allSearchKeyWord(
      String? keySearch) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _searchSource.allSearchKeyWord(keySearch);
    });
  }
  Future<Either<Failure, SearchMercariDto>> searchMercari() async {
    return ResultMiddleHandler.checkResult(() async {
      return await _searchSource.searchMercari();
    });
  }
  Future<Either<Failure, SearchRakutenDto>> searchRakuten(
      {required SearchSellerRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _searchSource.searchRakuten(request: request);
    });
  }

  //repo suggestion search
  Future<Either<Failure, SearchSuggestionDto>> searchSuggestion(
      {required SearchSellerRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _searchSource.searchSuggestion(request: request);
    });
  }
  Future<Either<Failure, SearchPopularDto>> searchPopular(
      {required SearchSellerRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _searchSource.searchPopular(request: request);
    });
  }
  //repo keyword
  Future<Either<Failure, MercariSearchKeyWordDto>> searchMercariKeyWord(
      {required SearchKeyWordRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _searchSource.searchMercariKeyWord(request: request);
    });
  }
  Future<Either<Failure, RakutenSearchKeyWordDto>> searchRakutenKeyWord(
      {required SearchKeyWordRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _searchSource.searchRakutenKeyWord(request: request);
    });
  }
  Future<Either<Failure, RakutenResolverDto>> objectResolverRakuten(
      {required String url}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _searchSource.objectResolverRakuten(url);
    });
  }
  Future<Either<Failure, AuctionDto>> yAuctionSearchCategory(
      {required AuctionRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _searchSource.yAuctionSearchCategory(request: request);
    });
  }
  Future<Either<Failure, ProducerSearchDto>> getBrandAuction(
      String urlApi) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _searchSource.getBrandAuction(urlApi);
    });
  }
  Future<Either<Failure, AuctionSearchDto>> yAuctionSearchKeyWord(
      {required AuctionSearchRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _searchSource.yAuctionSearchKeyWord(request: request);
    });
  }
  Future<Either<Failure, PaypaySearchKeyWordDto>> payPaySearchKeyWord(
      {required SearchKeyWordRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _searchSource.payPaySearchKeyWord(request: request);
    });
  }
  Future<Either<Failure, AmazonSearchKeyWordDto>> amazonJsSearchKeyWord(
      {required SearchKeyWordRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _searchSource.amazonJsSearchKeyWord(request: request);
    });
  }
  Future<Either<Failure, AmazonSearchKeyWordDto>> amazonUsSearchKeyWord(
      {required SearchKeyWordRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _searchSource.amazonUsSearchKeyWord(request: request);
    });
  }
}