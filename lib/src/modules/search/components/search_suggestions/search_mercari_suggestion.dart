import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_popular/search_popular_dto.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_suggestion/search_suggestion_dto.dart';

import '../../../../domain/dtos/search/mecari_search_key_word/mecari_search_key_word_dto.dart';
import '../../../../domain/dtos/search/search_mercari/search_mercari_dto.dart';
import '../../store_search_cubit/abstract_store_search/abstract_store_search_cubit.dart';
import '../../store_search_cubit/marcari_search/marcari_search_cubit.dart';
import '../../widget/row_suggestion.dart';
import '../../widget/search_popular_widget.dart';

class SearchMercariSuggestion extends StatefulWidget {
  const SearchMercariSuggestion({
    super.key,
    this.getCurrentIndex,
    required this.cubit,
  });

  final ValueSetter<String>? getCurrentIndex;
  final MarcariSearchCubit cubit;

  @override
  State<SearchMercariSuggestion> createState() => _SearchMercariSuggestionState();
}

class _SearchMercariSuggestionState extends State<SearchMercariSuggestion> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [_containerSuggest(), _containerPopular()],
      ),
    );
  }

  Widget _containerSuggest() =>
      BlocBuilder<MarcariSearchCubit, StoreSearchState<MercariSearchKeyWordDto>>(
          bloc: widget.cubit,
          buildWhen: (prv, state) => state is SearchSuggestions,
        builder: (context, state) {
          return switch (state) {
            SearchSuggestions(dtoSuggest: final SearchSuggestionDto dto) =>
                RowSuggestion(
                  dto: dto.data!, getCurrentIndex: widget.getCurrentIndex,
                ),
            _ => const SizedBox.shrink(),
          };
        }
      );

  Widget _containerPopular() =>
      BlocBuilder<MarcariSearchCubit, StoreSearchState<MercariSearchKeyWordDto>>(
          bloc: widget.cubit,
          buildWhen: (prv, state) => state is SearchPopular,
          builder: (context, state) {
            return switch (state) {
              // SearchPopular(dto: final SearchPopularDto dto) =>
              //     SearchPopularWidget(
              //       populars: dto.data!,
              //     ),
              _ => const SizedBox.shrink(),
            };
          });
}
