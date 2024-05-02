import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_mercari/search_mercari_dto.dart';
import 'package:meta/meta.dart';

import '../../../../data/object_request_api/key_word/search_key_word_request.dart';
import '../../../../data/object_request_api/search/search_seller/search_seller_request.dart';
import '../../../../data/remote/middle-handler/failure.dart';
import '../../../../domain/dtos/search/mecari_search_key_word/mecari_search_key_word_dto.dart';
import '../abstract_store_search/abstract_store_search_cubit.dart';

class MarcariSearchCubit extends AbstractStoreSearchCubit<MercariSearchKeyWordDto> {
  MarcariSearchCubit() : super();

  @override
  Future<void> prepare() async {
    // goi api de lay goi y
    try {
    List<StoreSearchSuggestion<MercariSearchKeyWordDto>?> list = await Future.wait(
          [_fetchSuggestion(),_fetchPopular(),]);
    if (list.every((element) => element != null) &&
        list[0] is StoreSearchSuggestion &&
        list[1] is StoreSearchSuggestion
    ) {
      emit(list[0]!
        ..copy(list[1])
      );
    }
        await Future.delayed(const Duration(seconds: 1));

    }catch(e){
      print('${e} có lỗi xảy ra');
    }
  }
  //call api suggestion => suggestion && popular
  Future<StoreSearchSuggestion<MercariSearchKeyWordDto>?> _fetchSuggestion() async {
    final response = await get.searchSuggestion(request: SearchSellerRequest(typeCode: 'mercari'));
    StoreSearchSuggestion<MercariSearchKeyWordDto>? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(StoreSearchSuggestion(state: state)..dtoSuggest = r);
      emit(SearchSuggestions( state: state)..dtoSuggest = r);
    });
    return state;
  }
  Future<StoreSearchSuggestion<MercariSearchKeyWordDto>?> _fetchPopular() async {
    final response = await get.searchPopular(request: SearchSellerRequest(typeCode: 'mercari',size: '20'));
    StoreSearchSuggestion<MercariSearchKeyWordDto>? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(StoreSearchSuggestion(state: state)..dto = r);
      emit(SearchPopular(state: state)..dto = r);
    });
    return state;
  }

  @override
  Future<Either<Failure, MercariSearchKeyWordDto>> getData() async{
    return get.searchMercariKeyWord(request: requestKeyWord);
  }

  @override
  void onRight(MercariSearchKeyWordDto value) {
    Future.delayed(Duration(seconds: 1));
    emit(StoreSearchSuccess(data: value, canLoadMore: canLoadMore));
  }

}

