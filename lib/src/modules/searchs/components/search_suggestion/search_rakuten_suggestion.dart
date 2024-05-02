import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_popular/search_popular_dto.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_suggestion/search_suggestion_dto.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/rakuten_search/rakuten_search_cubit.dart';

import '../../widget/row_suggestion.dart';
import '../../widget/search_popular_widget.dart';

class SearchRakutenSuggestion extends StatefulWidget {
  const SearchRakutenSuggestion({
    super.key,
    this.getCurrentIndex,
    required this.cubit,
  });

  final ValueSetter<String>? getCurrentIndex;
  final RakutenSearchCubit cubit;

  @override
  State<SearchRakutenSuggestion> createState() =>
      _SearchRakutenSuggestionState();
}

class _SearchRakutenSuggestionState extends State<SearchRakutenSuggestion> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [_containerSuggest(), _containerPopular()],
      ),
    );
  }

  Widget _containerSuggest() =>  BlocBuilder<RakutenSearchCubit, RakutenSearchState>(
          bloc: widget.cubit,
          buildWhen: (prv, state) => state is RakutenSearchSuggestionSuccess,
          builder: (context, state) {
            return switch (state) {
              RakutenSearchSuggestionSuccess(
                dtoSuggest: final SearchSuggestionDto dto
              ) =>
                RowSuggestion(
                  dto: dto.data!,
                  getCurrentIndex: widget.getCurrentIndex,
                ),
              _ => const SizedBox.shrink(),
            };
          });

  Widget _containerPopular() => widget.cubit.searchPopularDto.data != null && widget.cubit.searchPopularDto.data!.isNotEmpty
     ? SearchPopularWidget(
    getSearchIndex: (String keyName) {
      widget.cubit.load(keyName);
      widget.cubit.controller!.value.text = keyName;
    },
    populars: widget.cubit.searchPopularDto.data!,
  ) : BlocBuilder<RakutenSearchCubit, RakutenSearchState>(
          bloc: widget.cubit,
          buildWhen: (prv, state) => state is RakutenSearchPopularSuccess,
          builder: (context, state) {
            return switch (state) {
              RakutenSearchPopularSuccess(
                dtoPopular: final SearchPopularDto dto
              ) =>
                SearchPopularWidget(
                  populars: dto.data!,
                  getSearchIndex: (String keyName) {
                    widget.cubit.load(keyName);
                    widget.cubit.controller!.value.text = keyName;
                  },
                ),
              _ => const SizedBox.shrink(),
            };
          });
}
