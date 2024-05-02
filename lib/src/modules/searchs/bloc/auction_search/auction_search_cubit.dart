import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jancargo_app/src/domain/dtos/dashboard/auction/auction_dto.dart';
import 'package:jancargo_app/src/domain/dtos/object_resolver/rakuten_resolver/rakuten_resolver_dto.dart';
import 'package:jancargo_app/src/domain/dtos/search/producer_search/producer_search_dto.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:meta/meta.dart';

import '../../../../data/object_request_api/dashboard/auction/auction_request.dart';
import '../../../../data/object_request_api/key_word/search_key_word_request.dart';
import '../../../../data/object_request_api/search/search_seller/search_seller_request.dart';
import '../../../../domain/dtos/auction/auction_search/auction_search_dto.dart';
import '../../../../domain/dtos/search/search_popular/search_popular_dto.dart';
import '../../../../domain/dtos/search/search_suggestion/search_suggestion_dto.dart';
import '../../../../domain/repositories/search/search_repo.dart';
import '../../../../general/constants/app_storage.dart';
import '../../../../general/inject_dependencies/inject_dependencies.dart';
import '../../widget/filter_radio_horizontal.dart';
import '../filter_search/filter_search_cubit.dart';

part 'auction_search_state.dart';

class AuctionFilterModel {
  final FilterSearchCubit searchCubit = FilterSearchCubit();

  final FilterRadioHorizontalController conditionsFilterController =
      FilterRadioHorizontalController(
    AppStorage.auctionFilterConditions,
    selectedOption: AppStorage.auctionDefaultFilterCondition,
  );

  final FilterRadioHorizontalController conditionsStoreFilterController =
      FilterRadioHorizontalController(
    AppStorage.auctionFilterStoreConditions,
    selectedOption: AppStorage.auctionDefaultFilterStoreCondition,
  );
}

class AuctionSearchCubit extends Cubit<AuctionSearchState> {
  AuctionSearchCubit() : super(AuctionSearchInitial(state: null));
  SearchRepo get = getIt<SearchRepo>();
  final AuctionFilterModel filterModel = AuctionFilterModel();
  final ValueNotifier<int> selectedValue = ValueNotifier(0);
  final ValueNotifier<TextEditingController>? controller =
      ValueNotifier(TextEditingController());
  final ValueNotifier<TextEditingController>? priceFromCtrl =
      ValueNotifier(TextEditingController());
  final ValueNotifier<TextEditingController>? priceToCtrl =
      ValueNotifier(TextEditingController());
  final TextEditingController controllerSearchProducer =
      TextEditingController();
  late SearchKeyWordRequest requestKeyWord;

  AuctionSearchFilterItemDto? auctionSearchFilterItemDto =
      AuctionSearchFilterItemDto(
          isActive: ValueNotifier(false),
          checked: ValueNotifier(false),
          params: {});
  late ProducerSearchDto? producerSearchDto;

  late AuctionSearchDto dataAuction ;

  // save param
  Map<String,dynamic> savedParams = {};

  List<InitialBrandItemsProducerSearchDto> initialBrands = [];

  // lưu lại brand id khi ở màn bộ lọc
  List<int> brandIds = [];
  
  // hiển thị xoá bộ lọc
  ValueNotifier<bool> isRemoveFilter = ValueNotifier(false);

  int page = 1;

  bool canLoadMore = true;
  bool avoidSpam = false;

  Future<void> prepare() async {
    emit(AuctionSearchLoading(state: state));
    // goi api de lay goi y
    try {
      List<AuctionSearchState?> list = await Future.wait([
        _fetchSuggestion(),
        _fetchPopular(),
      ]);
      if (list.every((element) => element != null) &&
          list[0] is AuctionSearchSuccess &&
          list[1] is AuctionSearchSuccess) {
        emit(list[0]!..copy(list[1]));
      }
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      print('${e} có lỗi xảy ra');
    }
  }

  //call api suggestion => suggestion && popular
  Future<AuctionSearchState?> _fetchSuggestion() async {
    final response = await get.searchSuggestion(
        request: SearchSellerRequest(typeCode: 'auction'));
    AuctionSearchState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(AuctionSearchSuggestionSuccess(state: state)..dtoSuggest = r);
    });
    return state;
  }

  Future<AuctionSearchState?> _fetchPopular() async {
    final response = await get.searchPopular(
        request: SearchSellerRequest(typeCode: 'auction', size: '20'));
    AuctionSearchState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(AuctionSearchPopularSuccess(state: state)..dtoPopular = r);
    });
    return state;
  }

  Future<void> loadMore(String? keySearch) async {
    if (avoidSpam  && !canLoadMore) return;
    avoidSpam = true;
    page++;
    print('page đang là bn $page');
    print('length list trước ${dataAuction.data!.results!.length}');
    load(null, keySearch,);
    print('length list sau ${dataAuction.data!.results!.length}');
    avoidSpam = false;
  }
  
  Future<void> load(String? category, String? keySearch,
      [bool? selectedBrand,
      Map<String, dynamic>? param,
      String? priceType,]) async {
    if(!avoidSpam){
      emit(AuctionSearchLoading(state: state));
    }
    // đợi priceToCtrl được gán dữ liệu
    await Future.delayed(Duration(milliseconds: 400));
    // check param
    if(param != null && param.isNotEmpty){
      savedParams = param;
    }

    // final paramBrandId = param?['brand_id'];
    // if (paramBrandId != null) {
    //   if (paramBrandId is String) {
    //     if(paramBrandId.isNotEmpty){
    //       param?.remove('brand_id');
    //     }else{
    //
    //     final brandId = int.tryParse(paramBrandId.toString());
    //
    //     if (brandId != null ) {
    //       selectedBrandAuction.removeWhere((e) => e.id == brandId);
    //     }
    //     }
    //   }
    // }

    keySearch != null
        ? await get
            .yAuctionSearchKeyWord(
            request: selectedBrand == true
                ? AuctionSearchRequest(
                    size: AppConstants.sizeApi,
                    page: page.toString(),
                    keyword: controller?.value.text,
                    query: controller?.value.text,
                    param: savedParams,
                    priceType: priceType,
                    maxVn: priceToCtrl!.value.text
                        .replaceAll(',', '')
                        .replaceAll('.', ''),
                    minVn: priceFromCtrl!.value.text
                        .replaceAll(',', '')
                        .replaceAll('.', ''),
                    brandId: selectedBrandAuction
                        .map((e) => e.id)
                        .whereType<int>()
                        .toList(),
                  )
                : AuctionSearchRequest(
                    size: AppConstants.sizeApi,
                    page: page.toString(),
                    keyword: controller?.value.text,
                    query: controller?.value.text,
                    param: savedParams,
                    priceType: priceType,
                    maxVn: priceToCtrl!.value.text.isNotEmpty
                        ? priceToCtrl!.value.text
                            .replaceAll(',', '')
                            .replaceAll('.', '')
                        : '',
                    minVn: priceFromCtrl!.value.text
                        .replaceAll(',', '')
                        .replaceAll('.', ''),
                    brandId: param?['brand_id'] != null || param?['brand_id'] != "" ? [] : brandIds,
                  ),
          )
            .fold((l) {
            emit(AuctionFailure(state: state));
          }, (r) {
            if (r.data!.results!.isEmpty) {
              canLoadMore = false;
              emit(AuctionItemKeySearchEmpty(state: state));
              return savedDataSuggestion();
            } else {
             if(page == 1){
               dataAuction = r;
             }else{
               dataAuction.data!.results!.addAll(r.data!.results!);
             }
              emit(AuctionItemKeySearchSuccess(state: state)
                ..auctionSearchDto = dataAuction
                ..canLoadMore = canLoadMore);
            }
          })
        : await get
            .yAuctionSearchCategory(
                request: AuctionRequest(
            size: AppConstants.sizeApi,
            page: '1',
            category: category,
          ))
            .fold((l) {}, (r) {
            emit(AuctionItemKeySearchCategory(state: state)
              ..data = r
              ..canLoadMore = canLoadMore);
          });
  }

  Future<void> loadCategoryId(String? categoryId) async {
    emit(AuctionSearchLoading(state: state));

    await get
        .yAuctionSearchCategory(
            request: AuctionRequest(
                size: AppConstants.sizeApi,
                page: '1',
                category: categoryId,
                code: categoryId,
                sort: "score",
                ranking: "popular"))
        .fold((l) {}, (r) {
      emit(AuctionItemKeySearchCategory(state: state)
        ..data = r
        ..canLoadMore = canLoadMore);
    });
  }

  Future<void> getBrandAuction(String urlApi, List<int> brandIds) async {
    emit(BrandAuctionSearchLoading(state: state));

    await get.getBrandAuction(urlApi).fold(
      (l) {},
      (r) {
        for (final item
            in r.brand?.children ?? <ChildrenBrandProducerSearchDto>[]) {
          if (selectedBrandAuction.contains(item)) {
            item.isSelected.value = true;
            tempSelectedBrandAuction.value.add(item);
          } else if (brandIds.contains(item.id!)) {
            item.isSelected.value = true;
          }
        }
        for (final e in r.initialBrand?.initials ??
            <InitialBrandItemsProducerSearchDto>[]) {
          for (final item
              in e.children ?? <InitialBrandChildrenItemProducerSearchDto>[]) {
            if (selectedBrandAuction.contains(item)) {
              item.isSelected.value = true;
              tempSelectedBrandAuction.value.add(item);
            } else if (brandIds.contains(item.id!)) {
              item.isSelected.value = true;
              tempSelectedBrandAuction.value.add(item);
            }
          }
        }
        emit(
          BrandAuctionSearchSuccess(state: state)..producerSearchDto = r,
        );
      },
    );
  }

  final Set<InitialBrandChildrenItemProducerSearchDto> selectedBrandAuction =
      {};

  final ValueNotifier<Set<InitialBrandChildrenItemProducerSearchDto>>
      tempSelectedBrandAuction = ValueNotifier({});

  bool selectBrandAuction(InitialBrandChildrenItemProducerSearchDto item) {
    if (tempSelectedBrandAuction.value.length == 10) return false;

    tempSelectedBrandAuction.value = {...tempSelectedBrandAuction.value, item};

    return true;
  }

  void unselectBrandAuction(InitialBrandChildrenItemProducerSearchDto item) {
    item.isSelected.value = false;
    tempSelectedBrandAuction.value =
        tempSelectedBrandAuction.value.where((e) => e.id != item.id).toSet();
  }

  void discardTempSelectedBrandAuction() {
    tempSelectedBrandAuction.value.clear();
    selectedBrandAuction.clear();
  }

  void saveSelectedBrandAuction() {
    selectedBrandAuction
      ..clear()
      ..addAll(tempSelectedBrandAuction.value);
  }

  Future<void> objectResolverRakuten(String url) async {
    emit(AuctionSearchObjectResolverLoading(state: state));

    await get.objectResolverRakuten(url: url).fold((l) {
      emit(AuctionSearchObjectResolverFailed(state: state));
    }, (r) async {
      await Future.delayed(const Duration(milliseconds: 300), () {
        return emit(AuctionSearchObjectResolverSuccess(state: state)
          ..rakutenResolverDto = r);
      });
    });
  }

  Future<void> removeDataFilter()async {
    priceToCtrl!.value.clear();
    priceFromCtrl!.value.clear();
    brandIds = [];
    // remove param
    savedParams = {};
    // hide xoá bộ lọc
    isRemoveFilter.value = false;
  }

  void savedDataSuggestion() {
    emit(AuctionSearchSuggestionSuccess(state: state)
      ..dtoSuggest = searchSuggestionDto);
    emit(AuctionSearchPopularSuccess(state: state)
      ..dtoPopular = searchPopularDto);
  }

  //
  SearchPopularDto searchPopularDto = const SearchPopularDto();
  SearchSuggestionDto searchSuggestionDto = const SearchSuggestionDto();
}
