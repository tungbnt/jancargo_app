import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:jancargo_app/src/domain/dtos/object_resolver/rakuten_resolver/rakuten_resolver_dto.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/modules/detail_product_rakuten/screens/detail_product_rakuten.dart';
import 'package:meta/meta.dart';

import '../../../../domain/dtos/search/search_all/search_all_dto.dart';
import '../../../../domain/repositories/search/search_repo.dart';
import '../../../../general/inject_dependencies/inject_dependencies.dart';

part 'all_search_state.dart';

class AllSearchCubit extends Cubit<AllSearchState> {
  AllSearchCubit() : super(AllSearchInitial(state: null));
  SearchRepo get = getIt<SearchRepo>();

  final ValueNotifier<TextEditingController>? controller = ValueNotifier(TextEditingController());


  Future<void> prepare() async {
    emit(AllSearchLoading(state: state));
  }

  Future<void> load(String? keySearch) async {
    emit(AllSearchLoading(state: state));

    final future = get.allSearchKeyWord(keySearch);

    await future.fold((l) {
      emit(AllSearchFailure(state: null));
    }, (r) {
      if (r.data![0].products!.isEmpty || r.data![0].products == [] ) {
        emit(AllSearchItemKeySearchEmpty(state: state));
      } else {
        return emit(AllSearchItemKeySearchSuccess(state: state)
          ..data = r
         );
      }
    });
  }

  Future<void> objectResolverRakuten(String url) async {
    emit(AllSearchObjectResolverLoading(state: state));

    await get
        .objectResolverRakuten(url: url).fold((l) {
      emit(AllSearchObjectResolverFailed(state: state));
    }, (r) async {

      await  Future.delayed(Duration(milliseconds: 300),(){
        return emit(AllSearchObjectResolverSuccess(state: state)..rakutenResolverDto = r);
      });

    });
  }

  Future<void> loadNokeyWord()async {
    emit(AllSearchItemKeySearchEmpty(state: state));
  }

  Future<void> changeTab(int currentTab)async {
    emit(AllSearchChangeTab(state: state)..currentTab = currentTab );
  }

}
