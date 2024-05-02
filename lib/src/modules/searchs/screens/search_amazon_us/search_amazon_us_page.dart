import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/domain/dtos/search/amazon_js_search_keyword/amazon_js_search_keyword_dto.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/general/utils/model_func_utils.dart';
import 'package:jancargo_app/src/modules/detail_product_rakuten/screens/detail_product_rakuten.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/amazon_us_search/amazon_us_search_cubit.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/rakuten_search/rakuten_search_cubit.dart';
import 'package:jancargo_app/src/modules/searchs/components/item_search/search_amazon_us_items.dart';
import 'package:jancargo_app/src/modules/searchs/components/search_suggestion/search_amazon_us_suggestion.dart';
import 'package:jancargo_app/src/modules/searchs/widget/field_search.dart';
import 'package:jancargo_app/src/modules/searchs/widget/shimmer_grid_search.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../domain/services/dialog/dialog_service.dart';
import '../../../../util/app_convert.dart';

class SearchAmazonUsPage extends StatefulWidget {
  const SearchAmazonUsPage({super.key, this.keyWord});

  final String? keyWord;

  @override
  State<SearchAmazonUsPage> createState() => _SearchAmazonUsPageState();
}

class _SearchAmazonUsPageState extends State<SearchAmazonUsPage> {
  ValueNotifier<int> current = ValueNotifier(0);
  final AmazonUsSearchCubit _cubit = AmazonUsSearchCubit();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    if (widget.keyWord!.isNotEmpty && widget.keyWord != '') {
      _cubit.controller!.value.text = widget.keyWord!;
      _cubit.load(widget.keyWord);
    } else {
      _cubit.prepare();
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
    // Gọi hàm search với chuỗi query
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
        await AppConvert.regexSearch(context, widget.keyWord!);
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
                (keyword) {
                  _onSearchTextChanged(keyword);
                },
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
        child: BlocListener<AmazonUsSearchCubit, AmazonUsSearchState>(
          bloc: _cubit,
          listenWhen: (prv, state) =>
              state is AmazonUsSearchObjectResolverLoading ||
              state is AmazonUsSearchObjectResolverSuccess ||
              state is AmazonUsSearchObjectResolverFailed,
          listener: (context, state) async {
            if (state is AmazonUsSearchObjectResolverLoading) {
              openDialogBox(
                context,
                const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.yellow800Color,
                  ),
                ),
              );
            } else if (state is AmazonUsSearchObjectResolverSuccess) {
              await RouteService.pop();
              await RouteService.routeGoOnePage(
                RakutenDetailProductScreen(
                  code:
                      '${state.rakutenResolverDto!.result!.shopUrl}:${state.rakutenResolverDto!.result!.productId}',
                  source: AppConstants.rakutenSource,
                ),
              );
            } else if (state is AmazonUsSearchObjectResolverFailed) {
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
              );
            },
          ),
        ),
      );

  Widget _searchResult() => ValueListenableBuilder(
        valueListenable: current,
        builder: (BuildContext context, value, Widget? child) {
          return AmazonUsSearchTabs(
            cubit: _cubit,
          );
        },
      );
}

class AmazonUsSearchTabs extends StatefulWidget {
  const AmazonUsSearchTabs({super.key, required this.cubit});

  final AmazonUsSearchCubit cubit;

  @override
  State<AmazonUsSearchTabs> createState() => _AmazonUsSearchTabsState();
}

class _AmazonUsSearchTabsState extends State<AmazonUsSearchTabs> {
  // @override
  // void initState() {
  //   super.initState();
  //   widget.cubit.prepare();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AmazonUsSearchCubit, AmazonUsSearchState>(
      bloc: widget.cubit,
      listener: (prv, state) {
        if (state is AmazonUsItemKeySearchEmpty) {
          DialogService.showNotiBannerInfo(context, 'Không tìm thấy kết quả!');
        } else if (state is AmazonUsFailure) {
          DialogService.showNotiBannerInfo(context, 'Đã có lỗi xảy ra!');
        }
      },
      listenWhen: (prv, state) =>
          state is AmazonUsItemKeySearchEmpty || state is AmazonUsFailure,
      buildWhen: (prv, state) =>
          state is AmazonUsSearchPopularSuccess ||
          state is AmazonUsSearchSuggestionSuccess ||
          state is AmazonUsSearchLoading ||
          state is AmazonUsItemKeySearchSuccess ||
          state is AmazonUsFailure,
      builder: (context, state) {
        return switch (state) {
          RakutenSearchSuggestionSuccess() ||
          RakutenSearchPopularSuccess() ||
          AmazonUsFailure() ||
          AmazonUsItemKeySearchEmpty() =>
            SearchAmazonUsSuggestion(
              cubit: widget.cubit,
              getCurrentIndex: (key) {
                widget.cubit.controller!.value.text = key;
                widget.cubit.load(key);
              },
            ),
          RakutenSearchLoading() => const SearchShimmerGrid(),
          RakutenItemKeySearchSuccess(
            data: final AmazonSearchKeyWordDto data,
            canLoadMore: final bool canLoadMore
          ) =>
            SearchAmazonUsItems(
              dto: data,
            ),
          _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
        };
      },
    );
  }
}
