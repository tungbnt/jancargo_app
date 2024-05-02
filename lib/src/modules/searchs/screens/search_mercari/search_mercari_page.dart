import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/domain/dtos/search/mecari_search_key_word/mecari_search_key_word_dto.dart';
import 'package:jancargo_app/src/domain/services/dialog/dialog_service.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/general/utils/model_func_utils.dart';
import 'package:jancargo_app/src/modules/detail_product_marcari/screens/detail_product_marcari.dart';
import 'package:jancargo_app/src/modules/detail_product_rakuten/screens/detail_product_rakuten.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/mercari_search/mercari_search_cubit.dart';
import 'package:jancargo_app/src/modules/searchs/components/item_search/search_marcari_items.dart';
import 'package:jancargo_app/src/modules/searchs/components/search_suggestion/search_mercari_suggestion.dart';
import 'package:jancargo_app/src/modules/searchs/widget/field_search.dart';
import 'package:jancargo_app/src/modules/searchs/widget/shimmer_grid_search.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SearchMercariPage extends StatefulWidget {
  const SearchMercariPage({super.key, this.keyWord});

  final String? keyWord;

  @override
  State<SearchMercariPage> createState() => _SearchMercariPageState();
}

class _SearchMercariPageState extends State<SearchMercariPage> {
  ValueNotifier<int> current = ValueNotifier(0);
  final MercariSearchCubit _cubit = MercariSearchCubit();

  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
  }

  void init() {
    if (widget.keyWord == null) {
      _cubit.prepare();
    } else {
      _cubit.load(widget.keyWord);
    }
  }

  @override
  void dispose() {
    _cubit.controller!.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchTextChanged(String text) {
    // Hủy bỏ bất kỳ hẹn giờ đang chạy trước đó
    _debounceTimer?.cancel();

    // Đặt hẹn giờ mới sau
    _debounceTimer = Timer(const Duration(milliseconds: 1600), () {
      // Gọi hàm search sau khi đã chờ đợi 1 giây
      search(text);
    });
  }

  void search(String keyWord) async {
    if (keyWord.isEmpty || keyWord == "") {
      _cubit.prepare();
    } else {
      bool hasUrl = AppConvert.regexHasUrl(
        keyWord,
      );
      if (keyWord.contains('https://item.rakuten.co.jp/')) {
        await _cubit.objectResolverRakuten(keyWord);
        _cubit.controller!.value.text = '';
        return;
      } else if (hasUrl) {
        await AppConvert.regexSearch(context, keyWord);
        _cubit.controller!.value.text = '';
        return;
      } else {
        _cubit.load(keyWord);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Builder(
        builder: (context) {
          return MultiSliver(
            children: [
              _fieldSearch(
                (keyword) => _onSearchTextChanged(keyword),
              ),
              _searchResult(),
            ],
          );
        },
      ),
    );
  }

  Widget _fieldSearch(
    ValueSetter<String> onChange,
  ) =>
      SliverToBoxAdapter(
        child: BlocListener<MercariSearchCubit, MercariSearchState>(
          bloc: _cubit,
          listenWhen: (prv, state) =>
              state is MercariSearchObjectResolverLoading ||
              state is MercariSearchObjectResolverSuccess ||
              state is MercariSearchObjectResolverFailed,
          listener: (context, state) async {
            if (state is MercariSearchObjectResolverLoading) {
              openDialogBox(
                context,
                const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.yellow800Color,
                  ),
                ),
              );
            } else if (state is MercariSearchObjectResolverSuccess) {
              await RouteService.pop();
              await RouteService.routeGoOnePage(
                RakutenDetailProductScreen(
                  code:
                      '${state.rakutenResolverDto!.result!.shopUrl}:${state.rakutenResolverDto!.result!.productId}',
                  source: AppConstants.rakutenSource,
                ),
              );
            } else if (state is MercariSearchObjectResolverFailed) {
              await RouteService.pop();
              await DialogService.showNotiBannerFailed(context, AppColors.white,
                  'Link sản phẩm không có hoặc chưa được hỗ trợ');
            }
          },
          child: FieldSearch(
            onChange: onChange,
            controller: TextEditingController(text: widget.keyWord),
          ),
        ),
      );

  Widget _searchResult() => ValueListenableBuilder(
        valueListenable: current,
        builder: (BuildContext context, value, Widget? child) {
          return MercariSearchTabs(
            nameStore: 'Mercari',
            cubit: _cubit,
          );
        },
      );
}

class MercariSearchTabs extends StatefulWidget {
  const MercariSearchTabs(
      {super.key, required this.nameStore, required this.cubit});

  final String nameStore;
  final MercariSearchCubit cubit;

  @override
  State<MercariSearchTabs> createState() => _MercariSearchTabsState();
}

class _MercariSearchTabsState extends State<MercariSearchTabs> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MercariSearchCubit, MercariSearchState>(
      bloc: widget.cubit,
      buildWhen: (prv, state) =>
          state is MercariSearchPopularSuccess ||
          state is MercariSearchSuggestionSuccess ||
          state is MercariSearchLoading ||
          state is MercariItemKeySearchSuccess,
      builder: (context, state) {
        return switch (state) {
          MercariSearchSuggestionSuccess() ||
          MercariSearchPopularSuccess() =>
            SearchMercariSuggestion(
              cubit: widget.cubit,
            ),
          MercariSearchLoading() => const SearchShimmerGrid(),
          MercariItemKeySearchSuccess(
            data: final MercariSearchKeyWordDto data,
            // canLoadMore: final bool canLoadMore
          ) =>
            SearchIMarcariItems(
              nameStore: widget.nameStore,
              dto: data,
            ),
          _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
        };
      },
    );
  }
}
