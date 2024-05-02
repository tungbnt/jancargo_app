import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_popular/search_popular_dto.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_suggestion/search_suggestion_dto.dart';

import '../../bloc/amazon_js_search/amazon_js_search_cubit.dart';
import '../../bloc/amazon_us_search/amazon_us_search_cubit.dart';
import '../../widget/row_suggestion.dart';
import '../../widget/search_popular_widget.dart';

class SearchAmazonUsSuggestion extends StatefulWidget {
  const SearchAmazonUsSuggestion({
    super.key,
    this.getCurrentIndex,
    required this.cubit,
  });

  final ValueSetter<String>? getCurrentIndex;
  final AmazonUsSearchCubit cubit;

  @override
  State<SearchAmazonUsSuggestion> createState() =>
      _SearchAmazonUsSuggestionState();
}

class _SearchAmazonUsSuggestionState extends State<SearchAmazonUsSuggestion> {
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
      : BlocBuilder<AmazonUsSearchCubit, AmazonUsSearchState>(
          bloc: widget.cubit,
          buildWhen: (prv, state) => state is AmazonJsSearchSuggestionSuccess,
          builder: (context, state) {
            return switch (state) {
              AmazonUsSearchSuggestionSuccess(
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
      : BlocBuilder<AmazonUsSearchCubit, AmazonUsSearchState>(
          bloc: widget.cubit,
          buildWhen: (prv, state) => state is AmazonUsSearchPopularSuccess,
          builder: (context, state) {
            return switch (state) {
              AmazonUsSearchPopularSuccess(
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
