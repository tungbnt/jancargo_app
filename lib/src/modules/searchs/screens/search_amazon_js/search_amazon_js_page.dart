import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/domain/dtos/search/amazon_js_search_keyword/amazon_js_search_keyword_dto.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/utils/model_func_utils.dart';
import 'package:jancargo_app/src/modules/detail_product_rakuten/screens/detail_product_rakuten.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/rakuten_search/rakuten_search_cubit.dart';
import 'package:jancargo_app/src/modules/searchs/widget/field_search.dart';
import 'package:jancargo_app/src/modules/searchs/widget/shimmer_grid_search.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../domain/services/dialog/dialog_service.dart';
import '../../../../general/constants/app_constants.dart';
import '../../../../util/app_convert.dart';
import '../../bloc/amazon_js_search/amazon_js_search_cubit.dart';
import '../../components/item_search/search_amazon_js_items.dart';
import '../../components/search_suggestion/search_amazon_js_suggestion.dart';

class SearchAmazonJsPage extends StatefulWidget {
  const SearchAmazonJsPage({super.key, this.keyWord});
  final String? keyWord;

  @override
  State<SearchAmazonJsPage> createState() => _SearchAmazonJsPageState();
}

class _SearchAmazonJsPageState extends State<SearchAmazonJsPage> {
  ValueNotifier<int> current = ValueNotifier(0);
  final AmazonJsSearchCubit _cubit = AmazonJsSearchCubit();


  Timer? _debounceTimer;
  @override
  void initState() {
    super.initState();
    init();
  }
  void init(){

    if(widget.keyWord!.isNotEmpty && widget.keyWord != ''){
      _cubit.controller!.value.text = widget.keyWord!;
      _cubit.load(widget.keyWord);
    }else{
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

  void search(String keyWord) async{
    // Gọi hàm search với chuỗi query
    if (keyWord.isEmpty || keyWord == "") {
      _cubit.savedDataSuggestion();
    } else {
      bool hasUrl =  AppConvert.regexHasUrl(
        widget.keyWord!,);
      if (keyWord.contains('https://item.rakuten.co.jp/')) {
        await _cubit.objectResolverRakuten(keyWord);
        _cubit.controller!.value.text = '';
        return;
      } else
      if (hasUrl) {
        await AppConvert.regexSearch(context, keyWord);
        _cubit.controller!.value.text = '';
        return;
      }else{
        _cubit.load(_cubit.controller!.value.text);
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
        child: BlocListener<AmazonJsSearchCubit, AmazonJsSearchState>(
          bloc: _cubit,
          listenWhen: (prv, state) =>
          state is AmazonJsSearchObjectResolverLoading ||
              state is AmazonJsSearchObjectResolverSuccess ||
              state is AmazonJsSearchObjectResolverFailed,
          listener: (context, state) async {
            if (state is AmazonJsSearchObjectResolverLoading) {
              openDialogBox(
                context,
                const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.yellow800Color,
                  ),
                ),
              );
            } else if (state is AmazonJsSearchObjectResolverSuccess) {
              await RouteService.pop();
              await RouteService.routeGoOnePage(
                RakutenDetailProductScreen(
                  code:
                  '${state.rakutenResolverDto!.result!.shopUrl}:${state.rakutenResolverDto!.result!.productId}',
                  source: AppConstants.rakutenSource,
                ),
              );
            } else if (state is AmazonJsSearchObjectResolverFailed) {
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
      return AmazonJsSearchTabs(
        cubit: _cubit,
      );
    },
  );
}

class AmazonJsSearchTabs extends StatefulWidget {
  const AmazonJsSearchTabs({super.key, required this.cubit});

  final AmazonJsSearchCubit cubit;

  @override
  State<AmazonJsSearchTabs> createState() => _AmazonJsSearchTabsState();
}

class _AmazonJsSearchTabsState extends State<AmazonJsSearchTabs> {
  // @override
  // void initState() {
  //   super.initState();
  //   widget.cubit.prepare();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AmazonJsSearchCubit, AmazonJsSearchState>(
      bloc: widget.cubit,
      listener: (prv, state) async{
        if (state is AmazonJsItemKeySearchEmpty) {
          widget.cubit.prepare();
         await  DialogService.showNotiBannerInfo(context, 'Không tìm thấy kết quả!');
        }else if (state is AmazonJsSearchFailure) {
          widget.cubit.prepare();
          await DialogService.showNotiBannerInfo(context, 'Không tìm thấy kết quả!');
        }
      },
      listenWhen: (prv, state) => state is AmazonJsItemKeySearchEmpty,
      buildWhen: (prv, state) =>
      state is AmazonJsSearchPopularSuccess ||
          state is AmazonJsSearchSuggestionSuccess ||
          state is AmazonJsSearchLoading ||
          state is AmazonJsItemKeySearchSuccess || state is AmazonJsSearchFailure || state is AmazonJsItemKeySearchEmpty,
      builder: (context, state) {
        return switch (state) {
          AmazonJsSearchSuggestionSuccess() ||
          AmazonJsSearchPopularSuccess() || AmazonJsSearchFailure() || AmazonJsItemKeySearchEmpty() =>
              SearchAmazonJsSuggestion(
                cubit: widget.cubit,
                getCurrentIndex: (key){
                  widget.cubit.controller!.value.text = key;
                  widget.cubit.load(key);
                },
              ),
          AmazonJsSearchLoading() => const SearchShimmerGrid(),
          AmazonJsItemKeySearchSuccess(
          data: final AmazonSearchKeyWordDto data,
          canLoadMore: final bool canLoadMore
          ) =>
              SearchAmazonJsItems(
                dto: data,
              ),
          _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
        };
      },
    );
  }
}
