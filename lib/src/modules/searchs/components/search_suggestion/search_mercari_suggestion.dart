import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_popular/search_popular_dto.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_suggestion/search_suggestion_dto.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/mercari_search/mercari_search_cubit.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/rakuten_search/rakuten_search_cubit.dart';
import '../../widget/row_suggestion.dart';
import '../../widget/search_popular_widget.dart';

class SearchMercariSuggestion extends StatefulWidget {
  const SearchMercariSuggestion({
    super.key,
    this.getCurrentIndex,
    required this.cubit,
  });

  final ValueSetter<String>? getCurrentIndex;
  final MercariSearchCubit cubit;

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
      BlocBuilder<MercariSearchCubit, MercariSearchState>(
          bloc: widget.cubit,
          buildWhen: (prv, state) => state is MercariSearchSuggestionSuccess,
        builder: (context, state) {
          return switch (state) {
            MercariSearchSuggestionSuccess(dtoSuggest: final SearchSuggestionDto dto) =>
                RowSuggestion(
                  dto: dto.data!, getCurrentIndex: widget.getCurrentIndex,
                ),
            _ => const SizedBox.shrink(),
          };
        }
      );

  Widget _containerPopular() =>
      BlocBuilder<MercariSearchCubit, MercariSearchState>(
          bloc: widget.cubit,
          buildWhen: (prv, state) => state is MercariSearchPopularSuccess,
          builder: (context, state) {
            return switch (state) {
              MercariSearchPopularSuccess(dtoPopular: final SearchPopularDto dto) =>
                  SearchPopularWidget(
                    getSearchIndex: (String keyName) {
                      widget.cubit.load(keyName);

                    },
                    populars: dto.data!,
                  ),
              _ => const SizedBox.shrink(),
            };
          });
}
