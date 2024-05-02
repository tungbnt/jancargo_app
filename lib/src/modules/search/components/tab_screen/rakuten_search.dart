import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/modules/search/store_search_cubit/marcari_search/marcari_search_cubit.dart';

import '../../../../domain/dtos/search/search_rakuten/search_rakuten_dto.dart';
import '../../store_search_cubit/abstract_store_search/abstract_store_search_cubit.dart';
import '../../store_search_cubit/rakuten_search/rakuten_search_cubit.dart';
import '../../widget/shimmer_grid_search.dart';
import '../search_suggestions/search_rakuten_suggestion.dart';

class SearchRakutenResult extends StatefulWidget {
  const SearchRakutenResult({super.key});

  @override
  State<SearchRakutenResult> createState() => _SearchRakutenResultState();
}

class _SearchRakutenResultState extends State<SearchRakutenResult> {
  final RakutenSearchCubit _cubit = RakutenSearchCubit();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RakutenSearchCubit, StoreSearchState<SearchRakutenDto>>(
      builder: (context, state) {
        return switch (state) {
          StoreSearchSuggestion() =>  SearchRakutenSuggestion(cubit: _cubit,),
          StoreSearchLoading() => const SearchShimmerGrid(),
          StoreSearchSuccess(
          data: final SearchRakutenDto data,
          canLoadMore: final bool canLoadMore
          ) => SearchRakutenResult(),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
