import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/domain/dtos/search/paypay_search_keyword/paypay_search_keyword_dto.dart';
import 'package:jancargo_app/src/domain/services/dialog/dialog_service.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/general/utils/model_func_utils.dart';
import 'package:jancargo_app/src/modules/detail_product_rakuten/screens/detail_product_rakuten.dart';
import 'package:jancargo_app/src/modules/details_product_auction/screens/details_product_screen.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/paypay_search/paypay_search_cubit.dart';
import 'package:jancargo_app/src/modules/searchs/components/item_search/search_paypay_items.dart';
import 'package:jancargo_app/src/modules/searchs/components/search_suggestion/search_paypay_suggestion.dart';
import 'package:jancargo_app/src/modules/searchs/widget/field_search.dart';
import 'package:jancargo_app/src/modules/searchs/widget/shimmer_grid_search.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:sliver_tools/sliver_tools.dart';


class SearchPayPayPage extends StatefulWidget {
  const SearchPayPayPage({super.key, this.keyWord});

  final String? keyWord;

  @override
  State<SearchPayPayPage> createState() => _SearchPayPayPageState();
}

class _SearchPayPayPageState extends State<SearchPayPayPage> {
  ValueNotifier<int> current = ValueNotifier(0);
  final PaypaySearchCubit _cubit = PaypaySearchCubit();

  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
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
        widget.keyWord!,);
      if (keyWord.contains('https://item.rakuten.co.jp/')) {
        await _cubit.objectResolverRakuten(keyWord);
        _cubit.controller!.value.text = '';
        return;
      } else
      if (hasUrl) {
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
                    (keyword) => _onSearchTextChanged(keyword),
              ),
              _searchResult(),
            ],
          );
        },
      ),
    );
  }

  Widget _fieldSearch(ValueSetter<String> onChange,) =>
      SliverToBoxAdapter(
        child: BlocListener<PaypaySearchCubit, PaypaySearchState>(
          bloc: _cubit,
          listenWhen: (prv, state) =>
          state is PaypaySearchObjectResolverLoading ||
              state is PaypaySearchObjectResolverSuccess ||
              state is PaypaySearchObjectResolverFailed,
          listener: (context, state) async {
            if (state is PaypaySearchObjectResolverLoading) {
              openDialogBox(
                context,
                const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.yellow800Color,
                  ),
                ),
              );
            } else if (state is PaypaySearchObjectResolverSuccess) {
              await RouteService.pop();
              await RouteService.routeGoOnePage(
                RakutenDetailProductScreen(
                  code:
                  '${state.rakutenResolverDto!.result!.shopUrl}:${state.rakutenResolverDto!.result!.productId}',
                  source: AppConstants.rakutenSource,
                ),
              );
            } else if (state is PaypaySearchObjectResolverFailed) {
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
                valueFilter: (value) {},
              );
            },
          ),
        ),
      );

  Widget _searchResult() =>
      ValueListenableBuilder(
        valueListenable: current,
        builder: (BuildContext context, value, Widget? child) {
          return PaypaySearchTabs(
            cubit: _cubit,
          );
        },
      );
}

class PaypaySearchTabs extends StatefulWidget {
  const PaypaySearchTabs({super.key, required this.cubit});

  final PaypaySearchCubit cubit;

  @override
  State<PaypaySearchTabs> createState() => _PaypaySearchTabsState();
}

class _PaypaySearchTabsState extends State<PaypaySearchTabs> {
  // @override
  // void initState() {
  //   super.initState();
  //   widget.cubit.prepare();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaypaySearchCubit, PaypaySearchState>(
      bloc: widget.cubit,
      listener: (prv, state) async {
        if (state is PaypayItemKeySearchEmpty) {
          widget.cubit.prepare();
          await DialogService.showNotiBannerInfo(
              context, 'Không tìm thấy kết quả!');
        } else if (state is PaypayFailure) {
          widget.cubit.prepare();
          await DialogService.showNotiBannerInfo(context, 'Đã có lỗi xảy ra!');
        }
      },
      listenWhen: (prv, state) => state is PaypayItemKeySearchEmpty,
      buildWhen: (prv, state) =>
      state is PaypaySearchPopularSuccess ||
          state is PaypaySearchSuggestionSuccess ||
          state is PaypaySearchLoading ||
          state is PaypayItemKeySearchSuccess || state is PaypayFailure ||
          state is PaypayItemKeySearchEmpty,
      builder: (context, state) {
        return switch (state) {
          PaypaySearchSuggestionSuccess() ||
          PaypaySearchPopularSuccess() || PaypayFailure() || PaypayItemKeySearchEmpty() =>
              SearchPaypaySuggestion(
                cubit: widget.cubit,
                getCurrentIndex: (key) {
                  widget.cubit.controller!.value.text = key;
                  widget.cubit.load(key);
                },
              ),
          PaypaySearchLoading() => const SearchShimmerGrid(),
          PaypayItemKeySearchSuccess(
          data: final PaypaySearchKeyWordDto data,
          // canLoadMore: final bool canLoadMore
          ) =>
              SearchPaypayItems(
                dto: data,
              ),
          _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
        };
      },
    );
  }
}
