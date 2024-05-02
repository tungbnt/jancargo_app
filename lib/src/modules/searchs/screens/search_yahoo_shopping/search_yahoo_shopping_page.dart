import 'dart:async';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/utils/model_func_utils.dart';
import 'package:jancargo_app/src/modules/detail_product_rakuten/screens/detail_product_rakuten.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/yahoo_shopping_search/yahoo_shopping_search_cubit.dart';
import 'package:jancargo_app/src/modules/searchs/widget/field_search.dart';
import 'package:jancargo_app/src/modules/searchs/widget/shimmer_grid_search.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../domain/dtos/search/search_shop/search_shopping_dto.dart';
import '../../../../domain/services/dialog/dialog_service.dart';
import '../../../../domain/services/navigator/route_service.dart';
import '../../../../general/constants/app_constants.dart';
import '../../../detail_product_y_shopping/screens/detail_product_y_shopping.dart';
import '../../components/fillter_search/yahoo_shopping_filter_search.dart';
import '../../components/item_search/search_yahoo_shopping_items.dart';
import '../../components/search_suggestion/search_yahoo_shopping_suggestion.dart';
import '../../widget/fillter_search_bottomsheet.dart';

class SearchYahooShoppingPage extends StatefulWidget {
  const SearchYahooShoppingPage({super.key, this.keyWord});

  final String? keyWord;

  @override
  State<SearchYahooShoppingPage> createState() =>
      _SearchYahooShoppingPageState();
}

class _SearchYahooShoppingPageState extends State<SearchYahooShoppingPage> {
  ValueNotifier<int> current = ValueNotifier(0);
  final YahooShoppingSearchCubit _cubit = YahooShoppingSearchCubit();

  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    if (widget.keyWord!.isNotEmpty && widget.keyWord != '') {
      _cubit.controller!.value.text = widget.keyWord!;
      _cubit.load(widget.keyWord!);
    } else {
      _cubit.prepare();
    }
  }

  @override
  void dispose() {
    _cubit.controller!.dispose();
    _cubit.controller!.value.clear();
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
    // Gọi hàm search với chuỗi query
    if (keyWord.isEmpty || keyWord == "") {
      _cubit.savedDataSuggestion();
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
  ) {
    return SliverToBoxAdapter(
      child: BlocListener<YahooShoppingSearchCubit, YahooShoppingSearchState>(
        bloc: _cubit,
        listenWhen: (prv, state) =>
            state is YahooShoppingSearchObjectResolverLoading ||
            state is YahooShoppingSearchObjectResolverSuccess ||
            state is YahooShoppingSearchObjectResolverFailed,
        listener: (context, state) async {
          if (state is YahooShoppingSearchObjectResolverLoading) {
            openDialogBox(
              context,
              const Center(
                child: CircularProgressIndicator(
                  color: AppColors.yellow800Color,
                ),
              ),
            );
          } else if (state is YahooShoppingSearchObjectResolverSuccess) {
            await RouteService.pop();
            await RouteService.routeGoOnePage(
              RakutenDetailProductScreen(
                code:
                    '${state.rakutenResolverDto!.result!.shopUrl}:${state.rakutenResolverDto!.result!.productId}',
                source: AppConstants.rakutenSource,
              ),
            );
          } else if (state is YahooShoppingSearchObjectResolverFailed) {
            await RouteService.pop();
            await DialogService.showNotiBannerFailed(context, AppColors.white,
                'Link sản phẩm không có hoặc chưa được hỗ trợ');
          }
        },
        child: ValueListenableBuilder(
          valueListenable: _cubit.controller!,
          builder: (BuildContext context, value, Widget? child) {
            return FieldSearch(
              onChange: onChange,
              controller: _cubit.controller!.value,
              filterSheetBuilder: _filterSheetBuilder,
              valueFilter: (value) {
                if (value) {
                  _cubit.load(_cubit.controller!.value.text);
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget _filterSheetBuilder(BuildContext context) {
    return FilterSearchBottomSheet(
      widgetCustom: YahooShoppingFilterSearch(
        filterModel: _cubit.filterModel,
      ),
    );
  }

  Widget _searchResult() => ValueListenableBuilder(
        valueListenable: current,
        builder: (BuildContext context, value, Widget? child) {
          return YahooShoppingSearchTabs(
            cubit: _cubit,
          );
        },
      );
}

class YahooShoppingSearchTabs extends StatefulWidget {
  const YahooShoppingSearchTabs({super.key, required this.cubit});

  final YahooShoppingSearchCubit cubit;

  @override
  State<YahooShoppingSearchTabs> createState() =>
      _YahooShoppingSearchTabsState();
}

class _YahooShoppingSearchTabsState extends State<YahooShoppingSearchTabs> {
  // @override
  // void initState() {
  //   super.initState();
  //   widget.cubit.prepare();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<YahooShoppingSearchCubit, YahooShoppingSearchState>(
      bloc: widget.cubit,
      listener: (prv, state) {
        if (state is YahooShoppingItemKeySearchEmpty) {
          DialogService.showNotiBannerInfo(context, 'Không tìm thấy kết quả!');
          widget.cubit.prepare();
        } else if (state is YahooShoppingFailure) {
          DialogService.showNotiBannerFailed(
              context, AppColors.primary800Color, 'Không tìm thấy kết quả!');
          widget.cubit.prepare();
        }
      },
      listenWhen: (prv, state) =>
          state is YahooShoppingItemKeySearchEmpty ||
          state is YahooShoppingFailure ,
      buildWhen: (prv, state) =>
          state is YahooShoppingSearchPopularSuccess ||
          state is YahooShoppingSearchSuggestionSuccess ||
          state is YahooShoppingSearchLoading ||
          state is YahooShoppingItemKeySearchEmpty ||
          state is YahooShoppingItemKeySearchSuccess,
      builder: (context, state) {
        return switch (state) {
          YahooShoppingSearchSuggestionSuccess() ||
          YahooShoppingSearchPopularSuccess() ||
          YahooShoppingItemKeySearchEmpty() ||
          YahooShoppingFailure() =>
            SearchYahooShoppingSuggestion(
              cubit: widget.cubit,
              getCurrentIndex: (key) {
                widget.cubit.controller!.value.text = key;
                widget.cubit.load(key);
              },
            ),
          YahooShoppingSearchLoading() => const SearchShimmerGrid(),
          YahooShoppingItemKeySearchSuccess(
            data: final SearchShoppingDto data,
            canLoadMore: final bool canLoadMore
          ) =>
            SearchYahooShoppingItems(
              dto: data,
            ),
          _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
        };
      },
    );
  }
}
