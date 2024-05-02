import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/app_manager.dart';
import 'package:jancargo_app/src/components/widget/custom_refresh_indicator.dart';
import 'package:jancargo_app/src/components/widget/will_scroll_position_change.dart';
import 'package:jancargo_app/src/domain/services/dialog/dialog_service.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/general/utils/model_func_utils.dart';
import 'package:jancargo_app/src/modules/detail_product_rakuten/screens/detail_product_rakuten.dart';
import 'package:jancargo_app/src/modules/searchs/widget/arrange_auction_search.dart';
import 'package:jancargo_app/src/modules/searchs/widget/field_search.dart';
import 'package:jancargo_app/src/modules/searchs/widget/shimmer_grid_search.dart';
import 'package:jancargo_app/src/modules/web_view/screen/web_view.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../domain/dtos/auction/auction_search/auction_search_dto.dart';
import '../../../../domain/dtos/dashboard/auction/auction_dto.dart';
import '../../../../util/app_convert.dart';
import '../../bloc/auction_search/auction_search_cubit.dart';
import '../../components/fillter_search/auction_filter.dart';
import '../../components/item_search/search_auction_items.dart';
import '../../components/item_search/search_auction_keyword_item.dart';
import '../../components/search_suggestion/search_auction_suggestion.dart';
import '../../widget/fillter_search_bottomsheet.dart';

class SearchAuctionPage extends StatefulWidget {
  const SearchAuctionPage(
      {super.key,
        required this.category,
        required this.categoryId,
        this.keyWord});

  final String? keyWord;

  final String category;
  final String categoryId;


  @override
  State<SearchAuctionPage> createState() => _SearchAuctionPageState();
}

class _SearchAuctionPageState extends State<SearchAuctionPage> {
  ValueNotifier<int> current = ValueNotifier(0);
  final AuctionSearchCubit _cubit = AuctionSearchCubit();
  ValueNotifier<bool> isShowFilter = ValueNotifier(false);

  Timer? _debounceTimer;

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
    //add
    _cubit.controller!.value.text = keyWord;
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
        _cubit..discardTempSelectedBrandAuction()..load(widget.category, keyWord);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    if (widget.keyWord!.isNotEmpty) {
      _cubit.controller!.value.text = widget.keyWord!;
      _cubit.load(widget.category, widget.keyWord!,false);
      return;
    } else if (widget.category != "" && widget.categoryId == "") {
      _cubit.load(widget.category, AppManager.appSession.codeCategory,false);
      return;
    } else if (widget.category != "" && widget.categoryId != "") {
      _cubit.loadCategoryId(
        widget.categoryId,
      );
      return;
    } else {
      _cubit.prepare();
      return;
    }
  }

  @override
  void dispose() {
    isShowFilter.dispose();
    _cubit.controller!.dispose();
    _debounceTimer?.cancel();
    super.dispose();
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
        child: ValueListenableBuilder(
            valueListenable: _cubit.controller!,
            builder: (context, _, __) {
              return BlocListener<AuctionSearchCubit, AuctionSearchState>(
                  bloc: _cubit,
                  listenWhen: (prv, state) =>
                  state is AuctionFailure ||
                      state is AuctionSearchLoading ||
                      state is AuctionSearchPopularSuccess ||
                      state is AuctionSearchObjectResolverLoading ||
                      state is AuctionSearchObjectResolverSuccess ||
                      state is AuctionSearchObjectResolverFailed ||
                      state is AuctionSearchSuggestionSuccess ||  state is AuctionItemKeySearchCategory ||
                      state is AuctionItemKeySearchSuccess,
                  listener: (prv, state) async{
                    if (state is AuctionFailure ||
                        state is AuctionSearchLoading ||
                        state is AuctionSearchSuggestionSuccess ||
                        state is AuctionSearchPopularSuccess) {
                      isShowFilter.value = false;

                    } else if (state is AuctionItemKeySearchCategory ||
                        state is AuctionItemKeySearchSuccess) {
                      isShowFilter.value = true;
                    }else  if (state is AuctionSearchObjectResolverLoading) {
                      openDialogBox(
                        context,
                        const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.yellow800Color,
                          ),
                        ),
                      );
                    } else if (state is AuctionSearchObjectResolverSuccess) {
                      await RouteService.pop();
                      await RouteService.routeGoOnePage(
                        RakutenDetailProductScreen(
                          code:
                          '${state.rakutenResolverDto!.result!.shopUrl}:${state.rakutenResolverDto!.result!.productId}',
                          source: AppConstants.rakutenSource,
                        ),
                      );
                    } else if (state is AuctionSearchObjectResolverFailed) {
                      await RouteService.pop();
                      await DialogService.showNotiBannerFailed(context, AppColors.white,
                          'Link sản phẩm không có hoặc chưa được hỗ trợ');
                    }
                  },
                  child: ValueListenableBuilder(
                      valueListenable: isShowFilter,
                      builder: (context,value,__) {
                        return SizedBox(
                          child:
                          value == false
                              ? FieldSearch(
                            onChange: onChange,
                            controller: TextEditingController(
                                text: AppManager.appSession.nameCategory ?? ""),
                          )
                              :
                          FieldSearch(
                            onChange: onChange,
                            filterSheetBuilder: _filterSheetBuilder,
                            arrangeSheetBuilder: _arrangeSheetBuilder,
                            controller: widget.keyWord != null
                                ? _cubit.controller!.value
                                : TextEditingController(
                                text: AppManager.appSession.nameCategory ?? ""),
                            valueFilter: (value) {
                              if (value) {
                                _cubit.load(AppManager.appSession.codeCategory,
                                    _cubit.controller!.value.text);
                              }
                            },
                            valueArrange: (value) {
                              if (value) {
                                _cubit.load(AppManager.appSession.codeCategory,
                                    _cubit.controller!.value.text);
                              }
                            },
                          ),
                        );
                      }
                  )
              );
            }),
      );

  Widget _filterSheetBuilder(BuildContext context) {
    return FilterSearchBottomSheet(
      widgetCustom: BlocBuilder<AuctionSearchCubit, AuctionSearchState>(
          bloc: _cubit,
          buildWhen: (prv,state)=> state is AuctionItemKeySearchSuccess,
          builder: (context,state) {
            return BlocProvider.value(
              value: _cubit,
              child: AuctionFilterSearch(
                auctionSearchFiltersDto: state.auctionSearchDto!.data!.filters!,
                count: state.auctionSearchDto!.data!.tabs!.firstWhere((e) => e.isActive == true).count ?? 0,
                cubit: _cubit,
              ),
            );
          }
      ),
    );
  }

  Widget _arrangeSheetBuilder(BuildContext context) {
    return FilterSearchBottomSheet(
      widgetCustom: BlocProvider.value(
        value: _cubit,
        child: BlocBuilder<AuctionSearchCubit, AuctionSearchState>(
            bloc: _cubit,
            buildWhen: (prv,state)=> state is AuctionItemKeySearchSuccess,
            builder: (context,state) {
              return BlocProvider.value(
                value: _cubit,
                child: ArrangeAuctionSearch(
                  dto: state.auctionSearchDto!.data!.sorters!,
                  currentSort: state.auctionSearchDto!.data!.currentSort!,
                  cubit: _cubit,
                ),
              );
            }
        ),
      ),
    );
  }

  Widget _searchResult() => ValueListenableBuilder(
    valueListenable: current,
    builder: (BuildContext context, value, Widget? child) {
      return AuctionSearchTabs(
        nameStore: 'Yahoo Auction',
        cubit: _cubit,
        category: widget.category,
      );
    },
  );
}

class AuctionSearchTabs extends StatefulWidget {
  const AuctionSearchTabs(
      {super.key,
        required this.nameStore,
        required this.cubit,
        required this.category});

  final String nameStore;
  final AuctionSearchCubit cubit;

  final String category;

  @override
  State<AuctionSearchTabs> createState() => _AuctionSearchTabsState();
}

class _AuctionSearchTabsState extends State<AuctionSearchTabs> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionSearchCubit, AuctionSearchState>(
      listener: (prv, state) {
        if (state is AuctionFailure || state is AuctionItemKeySearchEmpty) {
          widget.cubit.prepare();
        }
      },
      bloc: widget.cubit,
      buildWhen: (prv, state) =>
      state is AuctionSearchPopularSuccess ||
          state is AuctionSearchSuggestionSuccess ||
          state is AuctionSearchLoading ||
          state is AuctionItemKeySearchCategory ||
          state is AuctionItemKeySearchSuccess,
      builder: (context, state) {
        return switch (state) {
          AuctionSearchSuggestionSuccess() ||
          AuctionSearchPopularSuccess() ||
          AuctionFailure() =>
              SearchAuctionSuggestion(
                cubit: widget.cubit,
                category: widget.category,
              ),
          AuctionSearchLoading() ||
          AuctionItemKeySearchEmpty() =>
          const SearchShimmerGrid(),
          AuctionItemKeySearchCategory(
          data: final AuctionDto data,
          canLoadMore: final bool canLoadMore
          ) =>
              SearchIAuctionItems(
                nameStore: widget.nameStore,
                dto: data,
              ),
          AuctionItemKeySearchSuccess(
          auctionSearchDto: final AuctionSearchDto data,
          canLoadMore: final bool canLoadMore
          ) =>
              CustomRefreshIndicator(
                  onRefresh: () {
                    return widget.cubit.load(AppManager.appSession.codeCategory,
                        widget.cubit.controller!.value.text);
                  },
                  indicator: LoadingSpinkit(),
                  builder: (context, bool isbool) {
                  return WillScrollPositionChange(
                    onNextExtent: () {
                      if(!canLoadMore)return;
                      widget.cubit.loadMore(
                          widget.cubit.controller!.value.text);
                    },
                    onEnd: () {
                      if(!canLoadMore)return;
                      widget.cubit.loadMore(
                          widget.cubit.controller!.value.text);
                    },
                    designItemExtent: 500,
                    child: SearchAuctionKeyWordItems(
                      nameStore: widget.nameStore,
                      dto: data,
                      cubit: widget.cubit,
                    ),
                  );
                }
              ),
          _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
        };
      },
    );
  }
}
