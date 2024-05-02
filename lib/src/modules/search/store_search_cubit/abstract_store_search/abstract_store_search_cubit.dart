import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/data/object_request_api/search/search_seller/search_seller_request.dart';
import 'package:jancargo_app/src/data/remote/middle-handler/failure.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_popular/search_popular_dto.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_suggestion/search_suggestion_dto.dart';
import 'package:jancargo_app/src/domain/repositories/search/search_repo.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/general/inject_dependencies/inject_dependencies.dart';

import '../../../../data/object_request_api/key_word/search_key_word_request.dart';

part 'abstract_store_search_state.dart';

abstract class AbstractStoreSearchCubit<T> extends Cubit<StoreSearchState<T>> {
  AbstractStoreSearchCubit() : super(const StoreSearchLoading()) {
    request = SearchSellerRequest(size: AppConstants.sizeApi);
    requestKeyWord = SearchKeyWordRequest(keyword: null);
    prepare();
  }

  late SearchSellerRequest request;
  late SearchKeyWordRequest requestKeyWord;


  int page = 0;

  bool canLoadMore = true;

  SearchRepo get = getIt<SearchRepo>();

  Future<void> prepare() async {}

  Future<Either<Failure, T>> getData();

  void onRight(T value);

  Future<void> load() async {
    emit(const StoreSearchLoading());

    await getData().then(
      (value) => value.fold(
        (left) => emit(const StoreSearchFailed()),
        (right) {
          // check co load more dc ko
          // canLoadMore =
          onRight(right);
        },
      ),
    );
  }

  Future<void> loadMore() async {
    if (!canLoadMore) return;

    page++;

    request = SearchSellerRequest(
      size: request.size,
      query: request.query,
      page: page.toString(),
    );

    load();
  }

  Future<void> search(String? keyword) {
    page = 0;
    canLoadMore =true;

    requestKeyWord = SearchKeyWordRequest(
      keyword: keyword ?? requestKeyWord.keyword,
    );

    return load();
  }
}
