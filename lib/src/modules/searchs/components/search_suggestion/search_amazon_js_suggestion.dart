import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_popular/search_popular_dto.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_suggestion/search_suggestion_dto.dart';

import '../../bloc/amazon_js_search/amazon_js_search_cubit.dart';
import '../../widget/row_suggestion.dart';
import '../../widget/search_popular_widget.dart';

class SearchAmazonJsSuggestion extends StatefulWidget {
  const SearchAmazonJsSuggestion({
    super.key,
    this.getCurrentIndex,
    required this.cubit,
  });

  final ValueSetter<String>? getCurrentIndex;
  final AmazonJsSearchCubit cubit;

  @override
  State<SearchAmazonJsSuggestion> createState() =>
      _SearchAmazonJsSuggestionState();
}

class _SearchAmazonJsSuggestionState extends State<SearchAmazonJsSuggestion> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [_containerSuggest(), _containerPopular()],
      ),
    );
  }

  Widget _containerSuggest() => widget
          .cubit.searchSuggestionDto.data!.isNotEmpty
      ? RowSuggestion(
          dto: widget.cubit.searchSuggestionDto.data!,
          getCurrentIndex: widget.getCurrentIndex,
        )
      : BlocBuilder<AmazonJsSearchCubit, AmazonJsSearchState>(
          bloc: widget.cubit,
          buildWhen: (prv, state) => state is AmazonJsSearchSuggestionSuccess,
          builder: (context, state) {
            return switch (state) {
              AmazonJsSearchSuggestionSuccess(
                dtoSuggest: final SearchSuggestionDto dto
              ) =>
                RowSuggestion(
                  dto: dto.data!,
                  getCurrentIndex: widget.getCurrentIndex,
                ),
              _ => const SizedBox.shrink(),
            };
          });

  Widget _containerPopular() => widget.cubit.searchPopularDto.data != null &&
          widget.cubit.searchPopularDto.data!.isNotEmpty
      ? SearchPopularWidget(
          getSearchIndex: (String keyName) {
            widget.cubit.load(keyName);
            widget.cubit.controller!.value.text = keyName;
          },
          populars: widget.cubit.searchPopularDto.data!,
        )
      : BlocBuilder<AmazonJsSearchCubit, AmazonJsSearchState>(
          bloc: widget.cubit,
          buildWhen: (prv, state) => state is AmazonJsSearchPopularSuccess,
          builder: (context, state) {
            return switch (state) {
              AmazonJsSearchPopularSuccess(
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
