// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../components/resource/molecules/custom_accordion.dart';
// import '../../../components/resource/molecules/custom_expand_text.dart';
// import '../../../general/constants/app_colors.dart';
// import '../../../general/constants/app_styles.dart';
// import '../../../util/app_gap.dart';
//
//
// class FlashSaleDetailScreen extends StatefulWidget {
//   const FlashSaleDetailScreen({super.key});
//
//   @override
//   State<FlashSaleDetailScreen> createState() => _FlashSaleDetailScreenState();
// }
//
// class _FlashSaleDetailScreenState extends State<FlashSaleDetailScreen> {
//   final DetailProductCubit _cubit = DetailProductCubit();
//
//   @override
//   void initState() {
//     super.initState();
//     _cubit.info(widget.code, widget.source);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldCustom(
//       cubit: _cubit,
//       body: BlocBuilder<DetailProductCubit, DetailProductState>(
//         bloc: _cubit,
//         builder: (context, state) {
//           if (state is DetailProductInitial) {
//             return const Center(
//               child: CupertinoActivityIndicator(),
//             );
//           }
//           if (state is DetailProductInfoDataSuccess) {
//             return CustomScrollView(
//               slivers: [
//                 _primaryImagerProduct(),
//                 _sizedBox(),
//                 _accordion(),
//                 _sizedBox(),
//                 _infoProduct(),
//                 _sizedBox(),
//                 _readMore(),
//                 _sizedBox(),
//                 _similars(),
//                 _sizedBox(),
//                 _recentlys(),
//                 _sizedBox(),
//                 _titleSuggestion(),
//                 _sizedBox(),
//                 _suggestions(),
//                 _sizedBox(),
//               ],
//             );
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
//
//   Widget _sizedBox() => SliverToBoxAdapter(child: AppGap.sbH10);
//
//   Widget _primaryImagerProduct() {
//     return SliverToBoxAdapter(
//       child: BlocBuilder<DetailProductCubit, DetailProductState>(
//         bloc: _cubit,
//         buildWhen: (prv, state) =>
//         state.runtimeType == DetailProductInfoDataSuccess,
//         builder: (context, state) {
//           if (state is DetailProductInfoDataSuccess) {
//             return PrimaryImg(
//               name: state.detailDto!.name!,
//               price: state.detailDto!.price!,
//               images: state.detailDto!.thumbnails,
//             );
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
//
//   Widget _titleSuggestion() => SliverToBoxAdapter(
//     child: Container(
//       color: AppColors.white,
//       alignment: Alignment.centerLeft,
//       padding: EdgeInsets.only(left: AppGap.w10),
//       width: double.infinity,
//       height: AppGap.h40,
//       child: Text(
//         'Gợi ý hôm nay',
//         style: AppStyles.text7018(),
//       ),
//     ),
//   );
//
//   Widget _accordion() => SliverToBoxAdapter(
//     child: Container(
//       color: AppColors.white,
//       child: const CustomAccordionShip(),
//     ),
//   );
//
//   Widget _readMore() => SliverToBoxAdapter(
//     child: Container(
//       color: AppColors.white,
//       child: const CustomExpandText(),
//     ),
//   );
//
//   //thông tin sản phẩm
//   Widget _infoProduct() => SliverToBoxAdapter(
//     child: BlocBuilder<DetailProductCubit, DetailProductState>(
//       builder: (context, state) {
//         if (state is DetailProductInfoDataSuccess) {
//           return InfoProduct(cubit: _cubit, detailDto: state.detailDto!);
//         }
//         return const SizedBox.shrink();
//       },
//     ),
//   );
//
//
//   //danh sách gợi ý hôm nay
//   Widget _suggestions() => SliverPadding(
//     padding: EdgeInsets.symmetric(horizontal: AppGap.w8),
//     sliver: BlocConsumer<DetailProductCubit, DetailProductState>(
//       bloc: _cubit,
//       buildWhen: (prv, state) =>
//       state.runtimeType == SuggestionsDataSuccess,
//       listener: (context, state) {
//         if (state is SuggestionsDataSuccess) {
//           setState(() {
//             suggestionsDto = state.suggestionsDto!;
//           });
//         }
//       },
//       builder: (context, state) {
//         if (state is SuggestionsDataSuccess) {
//           return SliverGrid(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               childAspectRatio: 3 / 2,
//               mainAxisExtent: AppGap.h240,
//               crossAxisSpacing: AppGap.w10,
//               mainAxisSpacing: AppGap.w10,
//             ),
//             delegate: SliverChildBuilderDelegate(
//                   (context, index) {
//                 return Suggestions(
//                   dto: state.suggestionsDto![index],
//                 );
//               },
//               childCount: suggestionsDto?.length ?? 0,
//             ),
//           );
//         }
//         return const SliverToBoxAdapter(child: SizedBox.shrink());
//       },
//     ),
//   );
//
//   //danh sách xem gần đây
//   Widget _recentlys() => SliverToBoxAdapter(
//       child: BlocBuilder<DetailProductCubit, DetailProductState>(
//         bloc: _cubit,
//         buildWhen: (prv, state) =>
//         state.runtimeType == RecentlyViewedDataSuccess,
//         builder: (context, state) {
//           if (state is RecentlyViewedDataSuccess) {
//             return Recentlys(
//               dto: state.recentlyDto!.result!,
//             );
//           }
//           return const SizedBox.shrink();
//         },
//       ));
// }
//
