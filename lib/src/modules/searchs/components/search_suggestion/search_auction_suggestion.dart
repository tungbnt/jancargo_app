import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_popular/search_popular_dto.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_suggestion/search_suggestion_dto.dart';

import '../../../../app_manager.dart';
import '../../bloc/auction_search/auction_search_cubit.dart';
import '../../widget/row_suggestion.dart';
import '../../widget/search_popular_widget.dart';

class SearchAuctionSuggestion extends StatefulWidget {
  const SearchAuctionSuggestion({
    super.key,
    this.getCurrentIndex,
    required this.cubit, this.category,
  });

  final ValueSetter<String>? getCurrentIndex;
  final AuctionSearchCubit cubit;
  final String? category;

  @override
  State<SearchAuctionSuggestion> createState() => _SearchAuctionSuggestionState();
}

class _SearchAuctionSuggestionState extends State<SearchAuctionSuggestion> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [_containerSuggest(), _containerPopular()],
      ),
    );
  }

  Widget _containerSuggest() =>
      BlocBuilder<AuctionSearchCubit, AuctionSearchState>(
          bloc: widget.cubit,
          buildWhen: (prv, state) => state is AuctionSearchSuggestionSuccess,
          builder: (context, state) {
            return switch (state) {
              AuctionSearchSuggestionSuccess(dtoSuggest: final SearchSuggestionDto dto) =>
                  RowSuggestion(
                    dto: dto.data!,  getCurrentIndex: (String keyName) {
                    widget.cubit.load(widget.category,keyName);
                    AppManager.appSession.saveCodeCategory(keyName);


                  },
                  ),
              _ => const SizedBox.shrink(),
            };
          }
      );

  Widget _containerPopular() =>widget.cubit.searchPopularDto.data != null && widget.cubit.searchPopularDto.data!.isNotEmpty
      ? SearchPopularWidget(
    getSearchIndex: (String keyName) {
      widget.cubit.load(widget.category,keyName);
      widget.cubit.controller!.value.text = keyName;
    },
    populars: widget.cubit.searchPopularDto.data!,
  ) :
      BlocBuilder<AuctionSearchCubit, AuctionSearchState>(
          bloc: widget.cubit,
          buildWhen: (prv, state) => state is AuctionSearchPopularSuccess,
          builder: (context, state) {
            return switch (state) {
              AuctionSearchPopularSuccess(dtoPopular: final SearchPopularDto dto) =>
                  SearchPopularWidget(
                    getSearchIndex: (String keyName) {
                      widget.cubit.load(widget.category,keyName);
                      AppManager.appSession.saveCodeCategory(keyName);

                    },
                    populars: dto.data!,
                  ),
              _ => const SizedBox.shrink(),
            };
          });
}
