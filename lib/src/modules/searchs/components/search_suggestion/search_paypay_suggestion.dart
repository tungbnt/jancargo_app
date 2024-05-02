import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_popular/search_popular_dto.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_suggestion/search_suggestion_dto.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/paypay_search/paypay_search_cubit.dart';

import '../../widget/row_suggestion.dart';
import '../../widget/search_popular_widget.dart';

class SearchPaypaySuggestion extends StatefulWidget {
  const SearchPaypaySuggestion({
    super.key,
    this.getCurrentIndex,
    required this.cubit,
  });

  final ValueSetter<String>? getCurrentIndex;
  final PaypaySearchCubit cubit;

  @override
  State<SearchPaypaySuggestion> createState() => _SearchPaypaySuggestionState();
}

class _SearchPaypaySuggestionState extends State<SearchPaypaySuggestion> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [_containerSuggest(), _containerPopular()],
      ),
    );
  }

  Widget _containerSuggest() =>
      BlocBuilder<PaypaySearchCubit, PaypaySearchState>(
              bloc: widget.cubit,
              buildWhen: (prv, state) => state is PaypaySearchSuggestionSuccess,
              builder: (context, state) {
                return switch (state) {
                  PaypaySearchSuggestionSuccess(
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
      : BlocBuilder<PaypaySearchCubit, PaypaySearchState>(
          bloc: widget.cubit,
          buildWhen: (prv, state) => state is PaypaySearchPopularSuccess,
          builder: (context, state) {
            return switch (state) {
              PaypaySearchPopularSuccess(
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
