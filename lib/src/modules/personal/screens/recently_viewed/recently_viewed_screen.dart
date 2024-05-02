import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';
import 'package:jancargo_app/src/util/app_gap.dart';
import 'package:slivers/slivers.dart';

import '../../../../components/resource/molecules/app_loading.dart';
import '../../../../components/resource/molecules/input.dart';
import '../../../../domain/dtos/dashboard/recently_viewed/recently_viewed_dto.dart';
import '../../../../domain/services/navigator/route_service.dart';
import '../../../../general/constants/app_colors.dart';
import '../../../../general/constants/app_images.dart';
import '../../../searchs/widget/field_search.dart';
import '../../bloc/recently_viewed/recently_viewed_cubit.dart';
import '../../components/recently_viewed_item.dart';

class RecentlyViewedScreen extends StatefulWidget {
  const RecentlyViewedScreen({super.key});

  @override
  State<RecentlyViewedScreen> createState() => _RecentlyViewedScreenState();
}

class _RecentlyViewedScreenState extends State<RecentlyViewedScreen> {
  final RecentlyViewedCubit _cubit = RecentlyViewedCubit();

  @override
  void initState() {
    super.initState();
    _cubit.getRecentlyViewed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral200Color,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(AppStrings.of(context).recentlyViewed),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          _fieldSearch(
            (keyword) {
              _cubit.getRecentlyViewed(searchKey: keyword);
            },
          ),
          _recently(),
        ],
      ),
    );
  }

  Widget _recently() => BlocBuilder<RecentlyViewedCubit, RecentlyViewedState>(
        bloc: _cubit,
        buildWhen: (prv, state) =>
            state is RecentlyViewedLoading ||
            state is RecentlyViewedSuccess ||
            state is RecentlyViewedEmpty,
        builder: (context, state) {
          if (state is RecentlyViewedLoading) {
            return  SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - AppGap.h78,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.yellow800Color,
                  ),
                ),
              ),
            );
          }
          // if (state is FavoritesSuccess) {
          ///
          // favoriteDto.value = _cubit.favoriteDto!.data;
          if (state is RecentlyViewedEmpty) {
            return const SliverToBoxAdapter(
              child: Center(
                child: Text('Hiện chưa có sản phẩm nào!'),
              ),
            );
          }
          if (state is RecentlyViewedSuccess) {
            return SliverList.separated(
                itemBuilder: (context, int i) {
                  return RecentlyViewItem(
                    item: state.recentlyDto!.result![i],
                  );
                },
                separatorBuilder: (context, int i) {
                  return AppGap.sbH10;
                },
                itemCount: state.recentlyDto!.result!.length);
          }

          return const SliverToBoxAdapter(child: SizedBox.shrink());
        },
      );

  Widget _fieldSearch(
    ValueSetter<String> onChange,
  ) =>
      SliverToBoxAdapter(
        child: Container(
          height: AppGap.h50,
          width: double.infinity,
          padding:
              EdgeInsets.symmetric(horizontal: AppGap.w10,),
          margin: EdgeInsets.only(bottom: AppGap.h10),
          decoration: const BoxDecoration(
            color: AppColors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: AppGap.w290,
                child: AppInput(
                  placeholder: 'Tìm kiếm sán phẩm',
                  controller: _cubit.textSearch,
                  maxLine: 1,
                  prefixIcon: const Icon(Icons.search),
                  onChange: onChange,
                ),
              ),
              SizedBox(
                child: IconButton(
                  onPressed: () => _cubit.getRecentlyViewed(),
                  icon: SvgPicture.asset(AppImages.icRefresh),
                ),
              ),
            ],
          ),
        ),
      );
}
