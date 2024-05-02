import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_mercari/search_mercari_dto.dart';

import '../../../../domain/dtos/search/mecari_search_key_word/mecari_search_key_word_dto.dart';
import '../../store_search_cubit/abstract_store_search/abstract_store_search_cubit.dart';
import '../../store_search_cubit/marcari_search/marcari_search_cubit.dart';
import '../../widget/shimmer_grid_search.dart';
import '../items/search_marcari_items.dart';
import '../search_suggestions/search_mercari_suggestion.dart';

class SearchMarcariResult extends StatefulWidget {
  const SearchMarcariResult({super.key, required this.nameStore});

  final String nameStore;

  @override
  State<SearchMarcariResult> createState() => _SearchMarcariResultState();
}

class _SearchMarcariResultState extends State<SearchMarcariResult> {
  final MarcariSearchCubit _cubit = MarcariSearchCubit();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarcariSearchCubit, StoreSearchState<MercariSearchKeyWordDto>>(
      bloc: _cubit,
      builder: (context, state) {
        return switch (state) {
          StoreSearchSuggestion() => SearchMercariSuggestion(
              cubit: _cubit,
            ),
          StoreSearchLoading() => const SearchShimmerGrid(),
          StoreSearchSuccess(
            data: final SearchMercariDto data,
            canLoadMore: final bool canLoadMore
          ) =>
            SearchIMarcariItems(
              nameStore: widget.nameStore,
              dto: data,
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
