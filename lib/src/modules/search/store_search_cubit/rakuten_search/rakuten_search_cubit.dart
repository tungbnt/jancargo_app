import 'package:either_dart/either.dart';
import 'package:jancargo_app/src/data/remote/middle-handler/failure.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_rakuten/search_rakuten_dto.dart';
import 'package:jancargo_app/src/modules/search/store_search_cubit/abstract_store_search/abstract_store_search_cubit.dart';


class RakutenSearchCubit extends AbstractStoreSearchCubit<SearchRakutenDto> {
  RakutenSearchCubit() : super();

  @override
  Future<void> prepare() async {
    // goi api de lay goi y

    // thanh cong thi emit
  }
  
  @override
  Future<Either<Failure, SearchRakutenDto>> getData() {
    return get.searchRakuten(request: request);
  }

  @override
  void onRight(SearchRakutenDto value) {
    emit(StoreSearchSuccess(data: value, canLoadMore: canLoadMore));
  }

}
