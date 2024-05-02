import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/components/resource/molecules/smart_refresher_custom.dart';
import 'package:jancargo_app/src/domain/dtos/dashboard/recently_viewed/recently_viewed_dto.dart';
import 'package:jancargo_app/src/modules/list_seller/widget/item_recently.dart';

import '../../../components/resource/molecules/input.dart';
import '../../../components/resource/organisms/will_refresh_view.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_gap.dart';
import '../bloc/recently_viewed/recently_vieweds_cubit.dart';

class RecentlyVieweds extends StatefulWidget {
  const RecentlyVieweds({super.key, required this.dto});

  final RecentlyDto dto;

  @override
  State<RecentlyVieweds> createState() => _RecentlyViewedsState();
}

class _RecentlyViewedsState extends State<RecentlyVieweds> {
  final RecentlyViewedsCubit _cubit = RecentlyViewedsCubit();
  ValueNotifier<bool> isSearch = ValueNotifier(false);
  String keyWord = '';

  late RecentlyDto dto;
  late RecentlyDto dtoSave ;

  @override
  void initState() {
    super.initState();
    dto = widget.dto;
    dtoSave = widget.dto;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral300Color,
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: AppColors.white,
        leading: InkWell(
          highlightColor: Colors.transparent,
          onTap: () => RouteService.pop(),
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.black03,
          ),
        ),
        title: Text(
          'Đã xem gần đây',
          style: AppStyles.text7018(),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _fieldSearch(
            (keyword) {
              _cubit.load(keyword);
              keyWord = keyword;
            },
          ),
          list(),
        ],
      ),
    );
  }

  Widget _fieldSearch(
    ValueSetter<String> onChange,
  ) =>
      Container(
        padding:
            EdgeInsets.symmetric(horizontal: AppGap.w10, vertical: AppGap.h10),
        margin: EdgeInsets.only(bottom: AppGap.h10),
        color: AppColors.white,
        child: AppInput(
          placeholder: 'Tìm kiếm sán phẩm',
          controller: _cubit.textSearch,
          maxLine: 1,
          prefixIcon: const Icon(Icons.search),
          onChange: onChange,
        ),
      );

  Widget list() => ValueListenableBuilder(
    valueListenable: isSearch,
    builder: (context,_,__) {
      return BlocListener<RecentlyViewedsCubit, RecentlyViewedsState>(
            bloc: _cubit,
            listener: (context, state) {
              if (state is RecentlyViewedsSuccess) {
                setState(() {
                  if (_cubit.textSearch!.text == "") {
                    dto.result!.addAll(state.dto!.result!);
                    isSearch.value = false;
                    print(isSearch.value);
                  } else {
                    dtoSave.result!.addAll(state.dto!.result!);
                    isSearch.value = true;
                    print(isSearch.value);
                  }
                });
              }else  if (state is RecentlyViewedsSearchSuccess) {
                setState(() {
                  if (_cubit.textSearch!.text == keyWord) {
                    dto.result!.addAll(state.dto!.result!);
                    isSearch.value = false;
                    print(isSearch.value);
                  } else {
                    dtoSave.result!.addAll(state.dto!.result!);
                    isSearch.value = true;
                    print(isSearch.value);
                  }
                });
              }
            },
            child: isSearch.value == true
                ? Expanded(
                    child: CustomSmartRefresher(
                      controller: _cubit.refreshController,
                      onLoading: () async {
                        _cubit.load(keyWord);
                      },
                      onRefresh: () async {
                        _cubit.refreshList();
                      },
                      enablePullDown: true,
                      enablePullUp: true,
                      child: ListView.separated(
                        itemCount: dtoSave.result!.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemRecently(dto: dtoSave.result![index]);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return AppGap.sbH10;
                        },
                      ),
                    ),
                  )
                : Expanded(
                    child: CustomSmartRefresher(
                      controller: _cubit.refreshController,
                      onLoading: () async {
                        _cubit.load(null);
                      },
                      onRefresh: () async {
                        _cubit.refreshList();
                      },
                      enablePullDown: true,
                      enablePullUp: true,
                      child: ListView.separated(
                        itemCount: dto.result!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemRecently(dto: dto.result![index]);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return AppGap.sbH10;
                        },
                      ),
                    ),
                  ),
          );
    }
  );
}
