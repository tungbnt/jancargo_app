import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/search/bloc/search_cubit.dart';
import 'package:jancargo_app/src/modules/search/store_search_cubit/marcari_search/marcari_search_cubit.dart';
import 'package:jancargo_app/src/modules/search/store_search_cubit/rakuten_search/rakuten_search_cubit.dart';
import 'package:jancargo_app/src/util/app_gap.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../components/resource/molecules/input.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_storage.dart';
import '../components/search_result.dart';
import '../store_search_cubit/abstract_store_search/abstract_store_search_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // final AbstractStoreSearchCubit<T>  _cubit = SearchCubit();
  ValueNotifier<int> current = ValueNotifier(0);

  //
  final TextEditingController textSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.yellow800Color,
        centerTitle: true,
        title: const Text('Tìm kiếm'),
        elevation: 0,
      ),
      backgroundColor: AppColors.neutral200Color,
      body: CustomScrollView(
        slivers: [
          _stores(),
          ValueListenableBuilder(
            valueListenable: current,
            builder: (BuildContext context, value, Widget? child) {
              final storeName = AppStorage.items[current.value]['text'];

              if (storeName == 'Rakuten') {
                return BlocProvider(
                  create: (context) => RakutenSearchCubit(),
                  child: Builder(
                    builder: (context) {
                      return MultiSliver(
                        children: [
                          _fieldSearch(
                            (keyword) {
                              context
                                  .read<RakutenSearchCubit>()
                                  .search(keyword);
                            },
                          ),
                          _searchResult(),
                        ],
                      );
                    },
                  ),
                );
              } else if (storeName == 'Mercari') {
                return BlocProvider(
                  create: (context) => MarcariSearchCubit(),
                  child: Builder(
                    builder: (context) {
                      return MultiSliver(
                        children: [
                          _fieldSearch(
                            (keyword) {
                              context
                                  .read<MarcariSearchCubit>()
                                  .search(keyword);
                            },
                          ),
                          _searchResult(),
                        ],
                      );
                    },
                  ),
                );
              }
              return SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),

          // _suggest(),
        ],
      ),
    );
  }

  Widget _stores() => SliverToBoxAdapter(
        child: Container(
          height: AppGap.h48,
          padding: EdgeInsets.symmetric(
              horizontal: AppGap.w10, vertical: AppGap.h10),
          color: AppColors.white,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, int i) {
                return _itemStore(AppStorage.items[i]['text'], i);
              },
              separatorBuilder: (context, int i) {
                return AppGap.sbW8;
              },
              itemCount: AppStorage.items.length),
        ),
      );

  Widget _itemStore(String text, int i) => ValueListenableBuilder(
        valueListenable: current,
        builder: (BuildContext context, value, Widget? child) {
          return InkWell(
            onTap: () {
              current.value = i;
            },
            child: Container(
              height: AppGap.h32,
              padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: current.value == i
                    ? AppColors.yellow800Color
                    : AppColors.white,
                border: Border.all(
                    width: 1,
                    color: current.value == i
                        ? AppColors.yellow800Color
                        : AppColors.neutral300Color),
                borderRadius: BorderRadius.all(Radius.circular(AppGap.r4)),
              ),
              child: Text(
                text,
                style: AppStyles.text4014(color: AppColors.neutral900Color),
              ),
            ),
          );
        },
      );

  Widget _searchResult() => ValueListenableBuilder(
        valueListenable: current,
        builder: (BuildContext context, value, Widget? child) {
          return SearchResult(
            storeName: AppStorage.items[current.value]['text'],
          );
        },
      );

  Widget _fieldSearch(
    ValueSetter<String> onChange,
  ) =>
      SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: AppGap.w10, vertical: AppGap.h10),
          margin: EdgeInsets.symmetric(vertical: AppGap.h10),
          color: AppColors.white,
          child: AppInput(
            placeholder: 'Tìm kiếm sán phẩm',
            controller: textSearch,
            maxLine: 1,
            prefixIcon: const Icon(Icons.search),
            onChange: onChange,
          ),
        ),
      );
}
