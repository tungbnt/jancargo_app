import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/domain/dtos/search/rakuten_search_key_word/rakuten_search_key_word_dto.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/utils/model_func_utils.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/rakuten_search/rakuten_search_cubit.dart';
import 'package:jancargo_app/src/modules/searchs/components/item_search/search_rakuten_items.dart';
import 'package:jancargo_app/src/modules/searchs/components/search_suggestion/search_rakuten_suggestion.dart';
import 'package:jancargo_app/src/modules/searchs/widget/field_search.dart';
import 'package:jancargo_app/src/modules/searchs/widget/shimmer_grid_search.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../domain/services/dialog/dialog_service.dart';
import '../../../../domain/services/navigator/route_service.dart';
import '../../../../general/constants/app_constants.dart';
import '../../../../util/app_convert.dart';
import '../../../detail_product_rakuten/screens/detail_product_rakuten.dart';
import '../../components/fillter_search/rakuten_filter.dart';
import '../../widget/fillter_search_bottomsheet.dart';

class SearchRakutenPage extends StatefulWidget {
  const SearchRakutenPage({super.key, this.keyWord});

  final String? keyWord;

  @override
  State<SearchRakutenPage> createState() => _SearchRakutenPageState();
}

class _SearchRakutenPageState extends State<SearchRakutenPage> {
  ValueNotifier<int> current = ValueNotifier(0);
  final RakutenSearchCubit _cubit = RakutenSearchCubit();
  final RakutenFilterModel filterModel = RakutenFilterModel();

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
      _cubit.savedDataSuggestion();
    } else {
      bool hasUrl = AppConvert.regexHasUrl(
        keyWord,);
      if (hasUrl) {
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
              _fieldSearch((keyword) => _onSearchTextChanged(keyword)),
              _searchResult(),
            ],
          );
        },
      ),
    );
  }

  Widget _fieldSearch(ValueSetter<String> onChange,) =>
      SliverToBoxAdapter(
        child: BlocListener<RakutenSearchCubit, RakutenSearchState>(
          bloc: _cubit,
          listenWhen: (prv, state) =>
          state is RakutenObjectResolverLoading ||
              state is RakutenObjectResolverSuccess,
          listener: (context, state) async{
            if (state is RakutenObjectResolverLoading) {
              openDialogBox(
                context,
                const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.yellow800Color,
                  ),
                ),
              );
            } else if (state is RakutenObjectResolverSuccess) {
              await  RouteService.pop();
              await RouteService.routeGoOnePage(
                RakutenDetailProductScreen(
                  code:
                  '${state.rakutenResolverDto!.result!.shopUrl}:${state.rakutenResolverDto!.result!.productId}',
                  source: AppConstants.rakutenSource,
                ),
              );
            }else if(state is RakutenSearchFailed){
              await  RouteService.pop();
              await DialogService.showNotiBannerFailed(context, AppColors.white, 'Link sản phẩm không có hoặc chưa được hỗ trợ');
            }
          },
          child: ValueListenableBuilder(
            valueListenable: _cubit.controller!,

            builder: (BuildContext context, value, Widget? child) {
              return FieldSearch(
                onChange: onChange,
                filterSheetBuilder: _filterSheetBuilder,
                constraintsHeightBottomSheet: true,
                controller: _cubit.controller!.value, valueFilter: (value) {
                  print('value filter $value');
                if (value) {
                  _cubit.load(_cubit.controller!.value.text);
                } else {
                  _cubit.load(_cubit.controller!.value.text);
                }
              },
              );
            },
          ),
        ),
      );

  Widget _filterSheetBuilder(BuildContext context) {
    return FilterSearchBottomSheet(
      widgetCustom: RakutenFilterSearch(
        filterModel: _cubit.filterModel,
      ),
    );
  }

  Widget _searchResult() =>
      ValueListenableBuilder(
        valueListenable: current,
        builder: (BuildContext context, value, Widget? child) {
          return RakutenSearchTabs(
            cubit: _cubit,
          );
        },
      );
}

class RakutenSearchTabs extends StatefulWidget {
  const RakutenSearchTabs({super.key, required this.cubit});

  final RakutenSearchCubit cubit;

  @override
  State<RakutenSearchTabs> createState() => _RakutenSearchTabsState();
}

class _RakutenSearchTabsState extends State<RakutenSearchTabs> {
  // @override
  // void initState() {
  //   super.initState();
  //   widget.cubit.prepare();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RakutenSearchCubit, RakutenSearchState>(
      bloc: widget.cubit,
      listener: (prv, state) {
        if (state is RakutenItemKeySearchEmpty) {
          widget.cubit.prepare();
          DialogService.showNotiBannerInfo(context, 'Không tìm thấy kết quả!');
        }
        if (state is RakutenSearchFailed) {
          widget.cubit.prepare();
          DialogService.showNotiBannerInfo(context, 'Đã có lỗi xảy ra!');
        }
      },
      listenWhen: (prv, state) =>
      state is RakutenItemKeySearchEmpty || state is RakutenSearchFailed,
      buildWhen: (prv, state) =>
      state is RakutenSearchPopularSuccess ||
          state is RakutenSearchSuggestionSuccess ||
          state is RakutenSearchLoading ||
          state is RakutenItemKeySearchSuccess,
      builder: (context, state) {
        return switch (state) {
          RakutenSearchSuggestionSuccess() ||
          RakutenSearchPopularSuccess() || RakutenItemKeySearchEmpty() || RakutenSearchFailed() =>
              SearchRakutenSuggestion(
                cubit: widget.cubit,
                getCurrentIndex: (key) {
                  widget.cubit.controller!.value.text = key;
                  widget.cubit.load(key);
                },
              ),
          RakutenSearchLoading() => const SearchShimmerGrid(),
          RakutenItemKeySearchSuccess(
          data: final RakutenSearchKeyWordDto data,
          canLoadMore: final bool canLoadMore
          ) =>
              SearchRakutenItems(
                dto: data,
              ),
          _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
        };
      },
    );
  }
}
