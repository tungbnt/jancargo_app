import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';

import '../../../components/resource/molecules/custom_accordion.dart';
import '../../../components/resource/molecules/custom_expand_text.dart';
import '../../../components/widget/widget_error.dart';
import '../../../domain/dtos/detail_product/list/relates_dto.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_constants.dart';
import '../../../general/constants/app_styles.dart';
import '../../../util/app_gap.dart';
import '../bloc/detail_product_cubit.dart';
import '../components/info_product.dart';
import '../components/primary_img.dart';
import '../components/recentlys.dart';
import '../components/scaffold.dart';
import '../components/similar_product_list.dart';
import '../components/suggestions.dart';
import '../widget/store_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen(
      {super.key, required this.code, required this.source});

  final String code;
  final String source;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final DetailProductCubit _cubit = DetailProductCubit();
  ValueNotifier<int> numberItemCart = ValueNotifier(0);
  ValueNotifier<bool> isFavorite = ValueNotifier(false);
  List<RelatesDto>? suggestionsDto = [];
  String? valueShip;

  @override
  void initState() {
    super.initState();
    _cubit.info(widget.code, widget.source);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailProductCubit, DetailProductState>(
      bloc: _cubit,
      listenWhen: (prv,state)=> state is CartDataSuccess,
      listener: (context, state) {
        if(state is CartDataSuccess){
          numberItemCart.value = state.numberItemCart!;
        }
      },
  child: ScaffoldCustom(
      cubit: _cubit,
      numberItemCart: numberItemCart,
      onPressed: () {
        _cubit.info(widget.code, widget.source);
      },
      cartKey: GlobalKey<CartIconKey>(),
      body: BlocBuilder<DetailProductCubit, DetailProductState>(
        bloc: _cubit,
        buildWhen: (prv, state) =>
            state is DetailProductLoading ||
            state is DetailProductInfoDataSuccess ||
            state is DetailProductFailed,
        builder: (context, state) {
          if (state is DetailProductLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is DetailProductInfoDataSuccess) {
            return CustomScrollView(
              slivers: [
                _primaryImagerProduct(),
                _sizedBox(),
                _accordion(),
                _sizedBox(),
                _infStore(),
                _sizedBox(),
                _infoProduct(),
                _sizedBox(),
                _readMore(),
                _sizedBox(),
                _similars(),
                _sizedBox(),
                _recentlys(),
                _sizedBox(),
                _titleSuggestion(),
                _sizedBox(),
                _suggestions(),
                _sizedBox(),
                _sizedBoxBottom(),
              ],
            );
          }
          if (state is DetailProductFailed) {
            return const ErrorCustomWidget();
          }
          return const SizedBox.shrink();
        },
      ),
    ),
);
  }

  Widget _sizedBox() => SliverToBoxAdapter(child: AppGap.sbH10);

  Widget _sizedBoxBottom() => SliverToBoxAdapter(child: AppGap.sbH48);

  Widget _primaryImagerProduct() {
    return SliverToBoxAdapter(
      child: BlocConsumer<DetailProductCubit, DetailProductState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is FavoriteDataSuccess) {
            isFavorite.value = true;
          }
        },
        listenWhen: (prv, state) => state.runtimeType == FavoriteDataSuccess,
        buildWhen: (prv, state) => state is DataDetailsSuccess,
        builder: (context, state) {
          if (state is DataDetailsSuccess) {
            if (state.detailDto != null) {
              return PrimaryImg(
                name: state.detailDto!.name!,
                price: state.detailDto!.price! != 0
                    ? state.detailDto!.price!
                    : state.detailDto!.priceBuy!,
                priceBuy: state.detailDto!.priceBuy!,
                images: state.detailDto!.thumbnails,
                imagesThum: state.detailDto!.thumbnails!,
                code: state.detailDto!.code!,
                endTime: state.detailDto!.endTime!,
                url: state.detailDto!.url!,
                siteCode: AppConstants.auctionShoppingSource,
                urlSite:
                    "https://page.auctions.yahoo.co.jp/jp/auction/${widget.code}",
                nameSite: "Yahoo! Auction",
                buy: state.detailDto!.methods!.buy ?? false,
                isBid: state.detailDto!.methods!.bid ?? false,
                isLineTime: true,
                isFavorite: isFavorite,
                bid: state.detailDto!.bids,
              );
            }
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _titleSuggestion() =>
      BlocBuilder<DetailProductCubit, DetailProductState>(
        bloc: _cubit,
        buildWhen: (prv, state) => state.runtimeType == SuggestionsDataSuccess,
        builder: (context, state) {
          if (state is SuggestionsDataSuccess) {
            return SliverToBoxAdapter(
              child: Container(
                color: AppColors.white,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: AppGap.w10),
                width: double.infinity,
                height: AppGap.h40,
                child: Text(
                  AppStrings.of(context).suggestionToday,
                  style: AppStyles.text7018(),
                ),
              ),
            );
          }
          return const SliverToBoxAdapter(
            child: SizedBox.shrink(),
          );
        },
      );

  Widget _accordion() => SliverToBoxAdapter(
        child: BlocBuilder<DetailProductCubit, DetailProductState>(
          bloc: _cubit,
          buildWhen: (prv, state) => state.runtimeType == WareHouseDataSuccess,
          builder: (context, state) {
            if (state is WareHouseDataSuccess) {
              return Container(
                color: AppColors.white,
                child: CustomAccordionShip(
                  getCurrentIndex: (index) {
                    valueShip = state.shipModeDto![index].value;
                  },
                  dto: state.shipModeDto!,
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      );

  Widget _readMore() => SliverToBoxAdapter(
        child: BlocBuilder<DetailProductCubit, DetailProductState>(
          bloc: _cubit,
          buildWhen: (prv, state) => state is DataDetailsSuccess,
          builder: (context, state) {
            if (state is DataDetailsSuccess) {
              return state.detailDto!.description!.isEmpty
                  ? const SizedBox.shrink()
                  : Container(
                      color: AppColors.white,
                      child: CustomExpandText(
                        code: state.detailDto!.code!,
                        descriptions: state.detailDto!.description!,
                        site: "auction",
                      ),
                    );
            }
            return const SizedBox.shrink();
          },
        ),
      );

  //thông tin sản phẩm
  Widget _infoProduct() => SliverToBoxAdapter(
        child: BlocBuilder<DetailProductCubit, DetailProductState>(
          bloc: _cubit,
          buildWhen: (prv, state) => state is DataDetailsSuccess,
          builder: (context, state) {
            if (state is DataDetailsSuccess) {
              if (state.detailDto != null) {
                return InfoProduct(cubit: _cubit, detailDto: state.detailDto!);
              }
            }
            return const SizedBox.shrink();
          },
        ),
      );

  Widget _infStore() => SliverToBoxAdapter(
          child: BlocBuilder<DetailProductCubit, DetailProductState>(
        bloc: _cubit,
        buildWhen: (prv, state) => state is DataDetailsSuccess,
        builder: (context, state) {
          if (state is DataDetailsSuccess) {
            if (state.detailDto != null) {
              return StoreWidget(
                url: state.detailDto!.sellerDto!.avatar!,
                name: state.detailDto!.sellerDto!.name!,
                code: state.detailDto!.sellerDto!.id!,
                totalRate: state.detailDto!.sellerDto!.total!.toString(),
                percent: state.detailDto!.sellerDto!.percent!,
                detailsStore: state.detailDto!.sellerDto!.details,
              );
            }
          }
          return const SizedBox.shrink();
        },
      ));

  //danh sách sản phẩm tương tự
  Widget _similars() => SliverToBoxAdapter(
          child: BlocBuilder<DetailProductCubit, DetailProductState>(
        bloc: _cubit,
        buildWhen: (prv, state) => state.runtimeType == RelatesDataSuccess,
        builder: (context, state) {
          if (state is RelatesDataSuccess) {
            return SimilarProduct(
              dto: state.relatesDto!,
            );
          }
          return const SizedBox.shrink();
        },
      ));

  //danh sách gợi ý hôm nay
  Widget _suggestions() => SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: AppGap.w8),
        sliver: BlocConsumer<DetailProductCubit, DetailProductState>(
          bloc: _cubit,
          buildWhen: (prv, state) =>
              state.runtimeType == SuggestionsDataSuccess,
          listener: (context, state) {
            if (state is SuggestionsDataSuccess) {
              setState(() {
                suggestionsDto = state.suggestionsDto!;
              });
            }
          },
          builder: (context, state) {
            if (state is SuggestionsDataSuccess) {
              return SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  mainAxisExtent: AppGap.h240,
                  crossAxisSpacing: AppGap.w10,
                  mainAxisSpacing: AppGap.w10,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Suggestions(
                      dto: state.suggestionsDto![index],
                    );
                  },
                  childCount: suggestionsDto?.length ?? 0,
                ),
              );
            }
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          },
        ),
      );

  //danh sách xem gần đây
  Widget _recentlys() => SliverToBoxAdapter(
          child: BlocBuilder<DetailProductCubit, DetailProductState>(
        bloc: _cubit,
        buildWhen: (prv, state) =>
            state.runtimeType == RecentlyViewedDataSuccess,
        builder: (context, state) {
          if (state is RecentlyViewedDataSuccess) {
            return Recentlys(
              dto: state.recentlyDto!.result!,
            );
          }
          return const SizedBox.shrink();
        },
      ));
}
