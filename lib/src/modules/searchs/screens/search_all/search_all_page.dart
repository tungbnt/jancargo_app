import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/domain/dtos/search/search_all/search_all_dto.dart';
import 'package:jancargo_app/src/domain/services/dialog/dialog_service.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/general/utils/model_func_utils.dart';
import 'package:jancargo_app/src/modules/detail_product_rakuten/screens/detail_product_rakuten.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/all_search/all_search_cubit.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/rakuten_search/rakuten_search_cubit.dart';
import 'package:jancargo_app/src/modules/searchs/components/item_search/search_all.dart';
import 'package:jancargo_app/src/modules/searchs/widget/field_search.dart';
import 'package:jancargo_app/src/modules/searchs/widget/shimmer_grid_search.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:jancargo_app/src/util/app_gap.dart';
import 'package:sliver_tools/sliver_tools.dart';


class SearchAllPage extends StatefulWidget {
  const SearchAllPage({super.key, required this.keyWord, required this.cubit});
  final String keyWord;
  final AllSearchCubit cubit;

  @override
  State<SearchAllPage> createState() => _SearchAllPageState();
}

class _SearchAllPageState extends State<SearchAllPage> {
  ValueNotifier<int> current = ValueNotifier(0);
  late AllSearchCubit _cubit ;
  
  Timer? _debounceTimer;
  @override
  void initState() {
    super.initState();
    init();
  }

  void init(){
    /// khởi tạo
    _cubit = widget.cubit;

    _cubit.controller!.value.text = widget.keyWord;
    if(widget.keyWord.isNotEmpty && widget.keyWord != ''){
      _cubit.load(widget.keyWord);
    }else{
      _cubit.loadNokeyWord();
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
      _cubit.loadNokeyWord();
    } else {
      bool hasUrl =  AppConvert.regexHasUrl(
          keyWord,);
      if (keyWord.contains('https://item.rakuten.co.jp/')) {
        await _cubit.objectResolverRakuten(keyWord);
        _cubit.controller!.value.text = '';
        return;
      }else
      if (hasUrl) {
        await AppConvert.regexSearch(context,keyWord);
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
                    (keyword) =>_onSearchTextChanged(keyword),
              ),
              _searchResult(),
            ],
          );
        }
      ),
    );
  }

  Widget _fieldSearch(
    ValueSetter<String> onChange,
  ) {
    return SliverToBoxAdapter(
      child: BlocListener<AllSearchCubit, AllSearchState>(
        bloc: _cubit,
        listenWhen: (prv, state) =>
        state is AllSearchObjectResolverLoading ||
            state is AllSearchObjectResolverSuccess || state is AllSearchObjectResolverFailed,
        listener: (context, state) async{
          if (state is AllSearchObjectResolverLoading) {
            openDialogBox(
              context,
              const Center(
                child: CircularProgressIndicator(
                  color: AppColors.yellow800Color,
                ),
              ),
            );
          } else if (state is AllSearchObjectResolverSuccess) {
            await  RouteService.pop();
            await RouteService.routeGoOnePage(
              RakutenDetailProductScreen(
                code:
                '${state.rakutenResolverDto!.result!.shopUrl}:${state.rakutenResolverDto!.result!.productId}',
                source: AppConstants.rakutenSource,
              ),
            );
          }else if(state is AllSearchObjectResolverFailed){
            await  RouteService.pop();
            await DialogService.showNotiBannerFailed(context, AppColors.white, 'Link sản phẩm không có hoặc chưa được hỗ trợ');
          }
        },
  child: ValueListenableBuilder(
        valueListenable: _cubit.controller!,
        builder: (context,_,__) {
          return FieldSearch(
            onChange: onChange,
            controller:  _cubit.controller!.value,
            valueFilter: (value) {
              if (value) {
                _cubit.load(AppConvert.regexUrl("a",''));
              }
            },
          );
        }
      ),
),
    );
  }

  Widget _searchResult() => ValueListenableBuilder(
        valueListenable: current,
        builder: (BuildContext context, value, Widget? child) {
          return AllSearchTabs(
            cubit: _cubit,
          );
        },
      );
}

class AllSearchTabs extends StatefulWidget {
  const AllSearchTabs({super.key, required this.cubit});

  final AllSearchCubit cubit;

  @override
  State<AllSearchTabs> createState() => _AllSearchTabsState();
}

class _AllSearchTabsState extends State<AllSearchTabs> {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllSearchCubit, AllSearchState>(
      bloc: widget.cubit,
      listener: (prv, state) {
        if (state is AllSearchItemKeySearchEmpty) {
          DialogService.showNotiBannerInfo(context, 'Không tìm thấy kết quả!');
        } else if (state is AllSearchFailure) {
          DialogService.showNotiBannerFailed(
              context, AppColors.primary800Color, 'Đã có lỗi xảy ra!');
          widget.cubit.prepare();
        }
      },
      listenWhen: (prv, state) =>
          state is AllSearchItemKeySearchEmpty || state is AllSearchFailure,
      buildWhen: (prv, state) =>
          state is AllSearchLoading ||
          state is AllSearchItemKeySearchEmpty || state is AllSearchFailure ||
          state is AllSearchItemKeySearchSuccess,
      builder: (context, state) {
        return switch (state) {
          AllSearchItemKeySearchEmpty() ||
          AllSearchFailure()  =>
             SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - AppGap.h235,
                child: Center(child: Text('Kết quả tìm kiếm trống!',style: AppStyles.text6016(),)),
              ),
            ),
          AllSearchLoading() => const SearchShimmerGrid(),
          AllSearchItemKeySearchSuccess(
            data: final SearchAllDto data,
          ) =>
              SearchAll(
              dto: data,cubit: widget.cubit,
            ),
          _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
        };
      },
    );
  }
}
