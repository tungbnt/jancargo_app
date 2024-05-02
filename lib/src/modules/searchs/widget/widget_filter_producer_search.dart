import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jancargo_app/src/components/resource/molecules/app_button.dart';
import 'package:jancargo_app/src/domain/dtos/search/producer_search/producer_search_dto.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/searchs/bloc/auction_search/auction_search_cubit.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

class WidgetFilterProducerSearch extends StatefulWidget {
  const WidgetFilterProducerSearch({super.key, required this.urlApi, required this.selectedBrandIDs});

  final String urlApi;
  final List<int> selectedBrandIDs;

  @override
  State<WidgetFilterProducerSearch> createState() => _WidgetFilterProducerSearchState();
}

class _WidgetFilterProducerSearchState extends State<WidgetFilterProducerSearch> {
  late AuctionSearchCubit _cubit;
  final ValueNotifier<List<InitialBrandItemsProducerSearchDto>> effectiveInitialBrands = ValueNotifier([]);
  bool isHideProducerPopular = true;

  void _filter([String? keywords]) {
    keywords ??= _cubit.controllerSearchProducer.text;

    keywords = keywords.trim();

    if (keywords.isEmpty) {
      _cubit.initialBrands = _cubit.producerSearchDto!.initialBrand!.initials ?? [];

      // hide _buildPopularProduct
      isHideProducerPopular = true;

      setState(() {});

      return;
    }

    // hide  _buildPopularProduct
    isHideProducerPopular = false;

    final ProducerSearchDto? producerSearchDto = _cubit.producerSearchDto;
    final initialBrand = producerSearchDto?.initialBrand?.initials;

    final effectiveKeywords = keywords.toLowerCase();

    if (initialBrand != null) {
      final newInitialBrands = <InitialBrandItemsProducerSearchDto>[];

      for (final e in _cubit.initialBrands) {
        if (e.children == null || e.children?.isEmpty == true) {
          continue;
        }

        final brand = e.clone();

        for (final item in e.children ?? <InitialBrandChildrenItemProducerSearchDto>[]) {
          final effectiveItemName = item.englishName!.toLowerCase();

          if (!effectiveItemName.contains(effectiveKeywords)) {
            brand.children!.remove(item);
          }
        }

        if (brand.children == null || brand.children?.isEmpty == true) {
          continue;
        }

        newInitialBrands.add(brand);
      }

      effectiveInitialBrands.value = newInitialBrands;

      print(
        'initialBrands: '
            '${newInitialBrands.map((e) => e.children?.map((e) => e.englishName).toString()).join('\n')}',
      );
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    context.read<AuctionSearchCubit>().getBrandAuction(widget.urlApi, widget.selectedBrandIDs);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cubit = context.read<AuctionSearchCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: _Dialog(
        cubit: _cubit,
        body: BlocConsumer(
          bloc: _cubit,
          listener: (context, state) {
            if (state is BrandAuctionSearchSuccess) {
              _cubit.producerSearchDto = state.producerSearchDto!;
              _cubit.initialBrands = _cubit.producerSearchDto!.initialBrand!.initials ?? [];
              effectiveInitialBrands.value = _cubit.initialBrands.where((e) => e.children?.isNotEmpty == true).toList();
            }
          },
          buildWhen: (prv, state) => state is BrandAuctionSearchSuccess || state is BrandAuctionSearchLoading,
          builder: (context, state) {
            if (state is BrandAuctionSearchLoading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }

            if (state is BrandAuctionSearchSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CustomTextFieldWithCopyButton(
                    controller: _cubit.controllerSearchProducer,
                    onChanged: _filter,
                    onTap: _filter,
                  ),
                  if (isHideProducerPopular)
                    ..._buildPopularProduct(
                      _cubit.producerSearchDto!.brand!,
                      onItemChanged: (item) {
                        bool found = false;
                        for (final e in effectiveInitialBrands.value) {
                          for (final brand in e.children ?? <InitialBrandChildrenItemProducerSearchDto>[]) {
                            if (brand.id == item.id) {
                              brand.isSelected.value = item.isSelected.value;
                              found = true;

                              break;
                            }
                          }

                          if (found) break;
                        }
                      },
                    ),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: effectiveInitialBrands,
                      builder: (context, initialBrands, ___) {
                        return WidgetSelectedProducerList(
                          items: initialBrands,
                          onItemChanged: (item) {
                            for (final brand
                            in _cubit.producerSearchDto!.brand!.children ?? <ChildrenBrandProducerSearchDto>[]) {
                              if (brand.id == item.id) {
                                brand.isSelected.value = item.isSelected.value;
                                break;
                              }
                            }
                          },
                        );
                      },
                    ),
                  ),
                  ..._buildSelectedBrandAuction(),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  List<Widget> _buildPopularProduct(
      BrandProducerSearchDto brand, {
        required void Function(ChildrenBrandProducerSearchDto item) onItemChanged,
      }) {
    return [
      Text(
        'Thương hiệu có nhiều sản phẩm',
        style: AppStyles.text4014(
          color: const Color.fromRGBO(0, 0, 0, 0.85),
        ),
      ),
      const SizedBox(height: 15),
      ..._buildCheckboxGrid(
        brand.children?.length,
            (index) {
          final item = brand.children![index];
          return CheckboxTitleProducer(
            item: item,
            onChanged: (isSelected) {
              if (isSelected) {
                _cubit.unselectBrandAuction(item);
              } else {
                final bool canSelect = _cubit.selectBrandAuction(item);

                if (!canSelect) {
                  item.isSelected.value = false;
                  return;
                }
              }
              onItemChanged(item);
            },
          );
        },
      ),
    ];
  }

  List<Widget> _buildSelectedBrandAuction() {
    return [
      ValueListenableBuilder(
        valueListenable: _cubit.tempSelectedBrandAuction,
        builder: (context, value, child) {
          return Text(
            "Đã chọn ${value.length}/10",
            style: AppStyles.text4014(
              color: const Color.fromRGBO(0, 0, 0, 0.85),
            ),
          );
        },
      ),
      const SizedBox(height: 15),
      ValueListenableBuilder(
        valueListenable: _cubit.tempSelectedBrandAuction,
        builder: (context, value, child) {
          return Wrap(
            spacing: 8,
            runSpacing: 8,
            children: value
                .map(
                  (e) => DecoratedBox(
                decoration: const BoxDecoration(
                  color: AppColors.neutral50Color,
                  border: Border.fromBorderSide(
                    BorderSide(color: Color(0xFFd9d9d9)),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: GestureDetector(
                  onTap: () => _cubit.unselectBrandAuction(e),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 7),
                      Text(
                        e.englishName ?? '',
                        style: AppStyles.text4012(
                          color: const Color.fromRGBO(0, 0, 0, 0.85),
                        ),
                      ),
                      SvgPicture.asset(
                        AppImages.icX,
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(width: 7),
                    ],
                  ),
                ),
              ),
            )
                .toList(),
          );
        },
      ),
    ];
  }
}

class WidgetSelectedProducerList extends StatelessWidget {
  const WidgetSelectedProducerList({
    super.key,
    required this.items,
    required this.onItemChanged,
  });

  final Iterable<InitialBrandItemsProducerSearchDto> items;
  final void Function(InitialBrandChildrenItemProducerSearchDto item) onItemChanged;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length * 2,
      itemBuilder: (context, index) {
        final actualIndex = index ~/ 2;
        final actualItem = items.elementAt(actualIndex);

        if (index.isEven) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(2),
            color: const Color(0xFFf3f3f3),
            child: Text(
              actualItem.character ?? '',
              style: AppStyles.text4014(
                color: const Color.fromRGBO(0, 0, 0, 0.85),
              ),
            ),
          );
        }

        final children = actualItem.children ?? [];
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ..._buildCheckboxGrid(
              children.length,
                  (index) {
                final item = children[index];
                return CheckboxTitleProducer(
                  item: item,
                  onChanged: (isSelected) {
                    final cubit = context.read<AuctionSearchCubit>();
                    if (isSelected) {
                      cubit.unselectBrandAuction(item);
                    } else {
                      final bool canSelect = cubit.selectBrandAuction(item);

                      if (!canSelect) {
                        item.isSelected.value = false;
                        return;
                      }
                    }
                    onItemChanged(item);
                  },
                );
              },
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 12),
          ],
        );
      },
    );
  }
}

class CheckboxTitleProducer extends StatelessWidget {
  const CheckboxTitleProducer({
    super.key,
    required this.item,
    this.onChanged,
  });

  final InitialBrandChildrenItemProducerSearchDto item;
  final ValueSetter<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (context.read<AuctionSearchCubit>().tempSelectedBrandAuction.value.length <= 10) {
          item.isSelected.value = !item.isSelected.value;
        }
        onChanged?.call(!item.isSelected.value);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          ValueListenableBuilder(
            valueListenable: item.isSelected,
            builder: (context, isSelected, __) {
              return SizedBox(
                width: 16.w,
                height: 16.h,
                child: Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  side: const BorderSide(color: AppColors.neutral300Color, width: 1),
                  activeColor: AppColors.primary700Color,
                  value: isSelected,
                  onChanged: (value) {
                    if (context.read<AuctionSearchCubit>().tempSelectedBrandAuction.value.length <= 10) {
                      item.isSelected.value = !item.isSelected.value;
                    }
                    onChanged?.call(!item.isSelected.value);
                  },
                ),
              );
            },
          ),
          AppGap.sbW8,
          Expanded(
            child: Text(
              '${item.englishName!}(${item.count})',
              style: AppStyles.text4012(
                color: AppColors.neutral800Color,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> _buildCheckboxGrid<T>(int? count, Widget Function(int index) itemBuilder) {
  final int childCount = count ?? 0;
  const int crossAxisCount = 2;
  // final int rowCount = (value.length / 2).round().toInt();
  //             ==
  final int mainAxisCount = childCount == 0 ? 0 : ((childCount - 1) ~/ crossAxisCount) + 1;

  return [
    for (int row = 0, cell = 0; row < mainAxisCount; row++, cell = row * 2) ...[
      Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          const SizedBox(width: 4),
          Expanded(
            child: itemBuilder(cell),
          ),
          const SizedBox(width: 4),
          const SizedBox(width: 4),
          Expanded(
            child: cell + 1 < childCount ? itemBuilder(cell + 1) : const SizedBox(),
          ),
          const SizedBox(width: 4),
        ],
      ),
      if (cell != childCount - 1) const SizedBox(height: 8),
    ],
  ];
}

class _Dialog extends StatelessWidget {
  const _Dialog({super.key, required this.body, required this.cubit});

  final Widget body;
  final AuctionSearchCubit cubit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: AppColors.white,
        ),
        child: Column(
          children: [
            DecoratedBox(
              decoration: const BoxDecoration(
                  color: Color(0xFFf2f4f8), borderRadius: BorderRadius.vertical(top: Radius.circular(6))),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Chọn nhà sản suất / thương hiệu",
                        style: AppStyles.text5016(
                          color: const Color.fromRGBO(0, 0, 0, 0.85),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () => RouteService.pop(),
                      child: SizedBox.square(
                        dimension: 54,
                        child: SvgPicture.asset(AppImages.icX),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: body,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(
                    onPressed: () {
                      cubit.discardTempSelectedBrandAuction();
                      RouteService.pop();
                    },
                    height: 32,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 4,
                    ),
                    color: AppColors.white,
                    borderColor: const Color(0xFFd9d9d9),
                    text: 'Đóng',
                    textColor: const Color.fromRGBO(0, 0, 0, 0.85),
                    textSize: 14,
                  ),
                  const SizedBox(width: 8),
                  AppButton(
                    onPressed: () {
                      cubit.saveSelectedBrandAuction();
                      RouteService.popBackResult();
                    },
                    height: 32,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 4,
                    ),
                    borderColor: AppColors.yellow800Color,
                    text: 'OK',
                    textSize: 14,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomTextFieldWithCopyButton extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  const _CustomTextFieldWithCopyButton({Key? key, required this.controller, this.onChanged, this.onTap})
      : super(key: key);

  @override
  _CustomTextFieldWithCopyButtonState createState() => _CustomTextFieldWithCopyButtonState();
}

class _CustomTextFieldWithCopyButtonState extends State<_CustomTextFieldWithCopyButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppGap.r6,
          ),
        ),
        color: AppColors.white,
        border: Border.all(color: AppColors.neutral400Color, width: 1),
      ),
      margin: EdgeInsets.symmetric(
        vertical: AppGap.h10,
      ),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: TextField(
              onChanged: widget.onChanged,
              controller: widget.controller,
              style: AppStyles.text4014(color: AppColors.neutral400Color),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  left: AppGap.w5,
                  top: AppGap.h3,
                ),
                isDense: true,
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Khoảng cách giữa TextField và nút sao chép
          GestureDetector(
            onTap: widget.onTap,
            child: Container(
              width: 35.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(
                    AppGap.r4,
                  ),
                  bottomRight: Radius.circular(
                    AppGap.r4,
                  ),
                ),
                color: AppColors.neutral200Color,
              ),
              alignment: Alignment.center, // Màu nút sao chép
              child: SvgPicture.asset(
                AppImages.icSearchSmall,
                height: AppGap.h16,
                width: AppGap.w15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
