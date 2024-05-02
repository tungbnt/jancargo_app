import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jancargo_app/src/components/bloc/favorite/favorite_cubit.dart';
import 'package:jancargo_app/src/domain/services/dialog/dialog_service.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/general/utils/model_func_utils.dart';
import 'package:jancargo_app/src/modules/favorite/widget/item_favorite.dart';
import 'package:jancargo_app/src/modules/favorite/widget/widget_filter_favorite.dart';
import 'package:jancargo_app/src/modules/searchs/widget/fillter_search_bottomsheet.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:jancargo_app/src/util/app_gap.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../components/resource/molecules/input.dart';
import '../../../domain/dtos/favorite/favorite_dto.dart';
import '../../../general/app_strings/app_strings.dart';
import '../../../general/constants/app_colors.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final FavoriteCubit _cubit = FavoriteCubit();
  ValueNotifier<List<FavoriteItems>?> favoriteDto = ValueNotifier([]);

  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _cubit.favorites();
  }

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

  void search(String query) {
    if (query.isEmpty && query == '') {
      favoriteDto.value = _cubit.favoriteDto!.data!;
    } else {
      _cubit.search(query, _cubit.filterModel
          .conditionsFilterController.groupValue.value?.remoteValue,_cubit
          .filterModel
          .conditionsArrangeController
          .groupValue
          .value
          ?.remoteValue ?? '');
    }
  }

  Widget _filterSheetBuilder(BuildContext context) {
    return FilterSearchBottomSheet(
      widgetCustom: WidgetFilterFavorite(
        filterModel: _cubit.filterModel,
        contextFavorite: context,
      ),
    );
  }

  Widget _arrangeSheetBuilder(BuildContext context) {
    return FilterSearchBottomSheet(
      widgetCustom: WidgetArrangeFavorite(
        filterModel: _cubit.filterModel,
        contextFavorite: context,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        backgroundColor: AppColors.neutral100Color,
        appBar: AppBar(
          backgroundColor: AppColors.yellow800Color,
          title: Text(AppStrings.of(context).favorite),
          centerTitle: true,
          actions: [
            IconButton(
                icon: SvgPicture.asset(AppImages.icFilter),
                onPressed: () async {
                  showCupertinoModalBottomSheet(
                    enableDrag: false,
                    context: context,
                    builder: _filterSheetBuilder,
                  ).then((value) {
                    if (value != true) return;

                    _cubit.search(_cubit.textSearch.text,_cubit.filterModel
                        .conditionsFilterController.groupValue.value?.remoteValue ?? '',_cubit
                        .filterModel
                        .conditionsArrangeController
                        .groupValue
                        .value
                        ?.remoteValue ?? '');
                  });
                }),
            IconButton(
                icon: SvgPicture.asset(AppImages.icArrange),
                onPressed: () async {
                  showCupertinoModalBottomSheet(
                    enableDrag: false,
                    context: context,
                    builder: _arrangeSheetBuilder,
                  ).then((value) {
                    if (value != true) return;
                    _cubit.search(_cubit.textSearch.text,_cubit.filterModel
                        .conditionsFilterController.groupValue.value?.remoteValue ?? '',_cubit
                        .filterModel
                        .conditionsArrangeController
                        .groupValue
                        .value
                        ?.remoteValue ?? '');
                  });
                }),
          ],
        ),
        body: VisibilityDetector(
          key: const Key("favorite"),
          onVisibilityChanged: (info) {
            _isVisible = info.visibleFraction == 1;

            if (_isVisible) {
              // reload lại cart
              // _cubit.favorites();
            }
          },
          child: CustomScrollView(
            slivers: [
              _fieldSearch(
                (keyword) => _onSearchTextChanged(keyword),
              ),
              _favorites(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _favorites() => BlocConsumer<FavoriteCubit, FavoriteState>(
        bloc: _cubit,
        listenWhen: (prv, state) =>
            state is FavoritesSearchLoading ||
            state is FavoritesSearchSuccess ||
            state is FavoritesSuccess ||
            state is DeletedFavoritesSuccess ||
            state is FavoritesSearchEmpty,
        listener: (context, state) async {
          if (state is FavoritesSearchSuccess) {
            RouteService.pop();
            favoriteDto.value = state.data;
          } else if (state is FavoritesSuccess) {
            favoriteDto.value = _cubit.favoriteDto!.data;
          } else if (state is FavoritesSearchLoading) {
            return openDialogBox(
              context,
              const Center(
                child: CircularProgressIndicator(
                  color: AppColors.yellow800Color,
                ),
              ),
            );
          } else if (state is DeletedFavoritesSuccess) {
            DialogService.showNotiBannerInfo(context, 'Xoá thành công!');
          } else if (state is FavoritesSearchEmpty) {
            favoriteDto.value = [];
          }
        },
        buildWhen: (prv, state) =>
            state is FavoriteLoading ||
            state is FavoritesSuccess ||
            state is FavoritesSearchSuccess ||
            state is FavoritesSearchEmpty,
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.of(context).size.height / 1.5,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: AppColors.yellow800Color,
                ),
              ),
            );
          }
          // if (state is FavoritesSuccess) {
          ///
          // favoriteDto.value = _cubit.favoriteDto!.data;
          // if (favoriteDto.value == null && favoriteDto.value!.isEmpty ) {
          //   return const Center(
          //     child: Text('Không có sản phẩm nào!'),
          //   );
          // }
          if (state is FavoritesSearchEmpty) {
            return const Center(
              child: Text('Không có sản phẩm nào phù hợp!'),
            );
          }
          return ValueListenableBuilder(
              valueListenable: favoriteDto,
              builder: (context, value, _) {
                return SliverList.separated(
                    itemBuilder: (context, int i) {
                      return FavoriteItem(
                        item: favoriteDto.value![i],
                        index: i,
                        cubit: _cubit,
                        getIndex: (index) {
                          setState(() {
                            favoriteDto.value!.removeAt(index);
                          });
                        },
                      );
                    },
                    separatorBuilder: (context, int i) {
                      return AppGap.sbH10;
                    },
                    itemCount: favoriteDto.value!.length);
              });
          // }
          // return const SliverToBoxAdapter(child: SizedBox.shrink());
        },
      );

  Widget _fieldSearch(
    ValueSetter<String> onChange,
  ) =>
      SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: AppGap.w10, vertical: AppGap.h10),
          margin: EdgeInsets.only(bottom: AppGap.h10),
          color: AppColors.white,
          child: AppInput(
            placeholder: 'Tìm kiếm sản phẩm',
            controller: _cubit.textSearch,
            maxLine: 1,
            prefixIcon: SizedBox(
                height: 20.h,
                width: 20.w,
                child: Center(
                    child: SvgPicture.asset(
                  AppImages.icSearchSmall,
                  color: AppColors.neutral400Color,
                  height: 20.h,
                  width: 20.w,
                  fit: BoxFit.contain,
                ))),
            onChange: onChange,
          ),
        ),
      );

// Widget _fieldSearch() => SliverToBoxAdapter(
//       child: Container(
//         height: 70,
//         margin: EdgeInsets.only(bottom: AppGap.h10),
//         color: AppColors.white,
//       ),
//     );
}
