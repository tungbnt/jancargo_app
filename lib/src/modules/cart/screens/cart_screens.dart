import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jancargo_app/src/components/bloc/cart_items/cart_items_cubit.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_images.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/cart/widget/item_cart.dart';
import 'package:jancargo_app/src/modules/payment_oders/screens/payment_oders_screen.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:jancargo_app/src/util/app_gap.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../components/resource/molecules/app_button.dart';
import '../../../domain/dtos/cart/item_cart/item_cart_dto.dart';
import '../../../domain/services/dialog/dialog_service.dart';
import '../../../general/utils/model_func_utils.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  final CartItemsCubit _cubit = CartItemsCubit();
  late ValueNotifier<List<GroupCartsDto>> groupCarts;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );

  late final Animation<double> _animationSized = Tween(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Cubic(0.645, 0.045, 0.355, 1.0),
    ),
  );

  late final Animation<double> _animationOpacity = Tween(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Cubic(0.645, 0.045, 0.355, 1.0),
    ),
  );

  bool _isVisible = true;

  ValueNotifier<bool> isDetailCart = ValueNotifier(false);

  //save item remove failed
  ItemCartDto itemCart = ItemCartDto(
      isSelected: ValueNotifier(false),
      selectedAmount: ValueNotifier(0),
      selectedShip: ValueNotifier(0),
      selectedService: ValueNotifier(0));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _cubit.itemCart();
  }

  void removeItem(int index, int indexCart, List<GroupCartsDto> data) async {
    // Clone data để tí nữa update
    // P/S: Chỉ là đưa các item sang 1 list mới
    //      các item này vẫn đang đc dùng để hiển thị trên UI
    //      => cần clone item mà tí nữa sắp bị xóa
    final dataValue = data.toList();

    // Clone group
    final group = dataValue[index].clone();
    // Thay item trong dataValue bằng cái clone để tí nữa xóa
    dataValue.setAll(index, [group]);

    final groupData = group.data ?? [];
    // isRemoveAll
    bool isRemoveAll = false;
    if (dataValue.length == 1) {
      try {

        if (groupData.length <= 1) {
          dataValue.remove(group);
          isRemoveAll = true;
        }
        final removedItemProduct = groupData.removeAt(indexCart);
        itemCart = removedItemProduct;

        _cubit.removeItemCart([removedItemProduct.id!], removedItemProduct, isRemoveAll, dataValue);

      } catch (e) {
        print('có lỗi khi xoá $e');
      }
    } else {
      final removedItemProduct = groupData.removeAt(indexCart);
      itemCart = removedItemProduct;

      if (groupData.length <= 1) {
        dataValue.remove(group);
      }

      try {
        _cubit.removeItemCart([removedItemProduct.id!], removedItemProduct, isRemoveAll, dataValue);
      } catch (e) {
        print('có lỗi khi xoá $e');
      }
    }
    // gán lại giá trị sau khi call api
    isRemoveAll = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.yellow800Color,
          centerTitle: true,
          title: Text(AppStrings.of(context).cart),
          elevation: 0,
        ),
        backgroundColor: AppColors.neutral100Color,
        body: VisibilityDetector(
          key: const Key("cart"),
          onVisibilityChanged: (info) {
            _isVisible = info.visibleFraction == 1;

            if (_isVisible) {
              // kiểm tra sau lần vào đầu tiên
              if (isDetailCart.value) {
                _controller.reverse();
                isDetailCart.value = false;
                return;
              }
              // reload lại cart
              _cubit.itemCart();
            }
          },
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  _selectedAll(),
                  _list(),
                ],
              ),
              ValueListenableBuilder(
                  valueListenable: isDetailCart,
                  builder: (context, value, _) {
                    if (isDetailCart.value) {
                      return Positioned.fill(
                        child: FadeTransition(
                          opacity: _animationOpacity,
                          child: ColoredBox(
                            color: AppColors.black03.withOpacity(0.45),
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: BlocListener<CartItemsCubit, CartItemsState>(
                  bloc: _cubit,
                  listenWhen: (prv, state) =>
                  state is CalculateCartItemsLoading || state is GetCalculateCartItemsSuccess,
                  listener: (context, state) {
                    if (state is CalculateCartItemsLoading) {
                      // hide sheet số tiền chi tiết
                      if (isDetailCart.value) {
                        _controller.reverse();
                        isDetailCart.value = false;
                      }
                      _cubit.isLoading = true;
                    } else if (state is GetCalculateCartItemsSuccess) {
                      _cubit.isLoading = false;
                    }
                    setState(() {});
                  },
                  child: FadeTransition(
                    opacity: _animationOpacity,
                    child: SizeTransition(
                      sizeFactor: _animationSized,
                      axisAlignment: -1,
                      child: Container(
                        color: AppColors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Stack(children: [
                              SizedBox(
                                width: double.infinity,
                                height: AppGap.h40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Chi tiết',
                                      style: AppStyles.text6020(color: AppColors.neutral800Color),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 8.w,
                                child: IconButton(
                                  onPressed: () {
                                    if (isDetailCart.value) {
                                      _controller.reverse();
                                      isDetailCart.value = false;
                                    }
                                  },
                                  icon: SvgPicture.asset(AppImages.icX),
                                ),
                              )
                            ]),
                            const Divider(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
                              child: ValueListenableBuilder(
                                  valueListenable: _cubit.calculateModel,
                                  builder: (context, value, __) {
                                    return Column(
                                      children: [
                                        ValueListenableBuilder(
                                          builder: (context, _, __) {
                                            return _row(
                                                'Tiền hàng(${_cubit.selectedCount.value.toString()})',
                                                _cubit.isLoading
                                                    ? 1
                                                    : _cubit.calculateModel.value.paymentCurrent.toInt() ,
                                                true);
                                          },
                                          valueListenable: _cubit.selectedCount,
                                        ),
                                        _row(
                                            'Phí dịch vụ',
                                            _cubit.isLoading
                                                ? 1
                                                : _cubit.calculateModel.value.feeService.toInt()),
                                        _row(
                                            'Phí thanh toán',
                                            _cubit.isLoading
                                                ? 1
                                                : _cubit.calculateModel.value.feePayment.toInt()),
                                        const Divider(),
                                        _row('Tổng tiền', _cubit.isLoading ? 1 : _cubit.calculateModel.value.totalCurrent.toInt()),
                                      ],
                                    );
                                  }),
                            ),
                            AppGap.sbH10,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: AppColors.white,
          height: AppGap.h55,
          padding: EdgeInsets.symmetric(horizontal: AppGap.h10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ValueListenableBuilder(
                valueListenable: _cubit.calculateModel,
                builder: (BuildContext context, value, Widget? child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ValueListenableBuilder(
                        builder: (context, _, __) {
                          return GestureDetector(
                            onTap: () {
                              if (isDetailCart.value) {
                                _controller.reverse();
                                isDetailCart.value = false;
                                return;
                              }
                              _controller.forward();
                              isDetailCart.value = true;
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Tổng(${_cubit.isLoading ? 0 : _cubit.selectedCount.value} mặt hàng)",
                                ),
                                AppGap.sbW8,
                                SvgPicture.asset(isDetailCart.value ? AppImages.icArrowdown2 : AppImages.icArrowup2),
                              ],
                            ),
                          );
                        },
                        valueListenable: isDetailCart,
                      ),
                      Text(
                        AppConvert.convertNumberVn(_cubit.isLoading ? 0 : _cubit.calculateModel.value.totalCurrent.toInt()),
                        style: AppStyles.text6020(color: AppColors.primary800Color),
                      ),
                    ],
                  );
                },
              ),
              ValueListenableBuilder(
                  valueListenable: _cubit.calculateModel,
                  builder: (context, value, _) {
                    return AppButton(
                      enable: value.paymentCurrent > 0 && _cubit.isLoading == false ? true : false,
                      height: AppGap.h40,
                      onPressed: () {
                        List<GroupCartsDto> originalList = _cubit.groupCarts; // Danh sách gốc của GroupCartsDto
                        List<GroupCartsDto> filteredList = AppConvert.filterSelectedCountTrue(originalList);

                        RouteService.routeGoOnePage(
                          PaymentOderScreen(
                            calculatePay: ValueNotifier(_cubit.calculateCartDto!),
                          ),
                        );
                      },
                      text: AppStrings.of(context).payment,
                      radius: AppGap.r4,
                      color: AppColors.yellow700Color,
                      borderColor: AppColors.neutral200Color,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectedAll() => SliverToBoxAdapter(
    child: BlocBuilder<CartItemsCubit, CartItemsState>(
      builder: (context, state) {
        if (state is CartItemsSuccess) {
          groupCarts = state.groupCarts!;
          if (groupCarts.value.isEmpty) {
            return const SizedBox.shrink();
          }

          return Container(
            color: AppColors.white,
            height: AppGap.h40,
            padding: EdgeInsets.symmetric(horizontal: AppGap.h10),
            child: Row(
              children: [
                Container(
                  width: 20.w,
                  height: 20.h,
                  margin: EdgeInsets.only(right: AppGap.h5),
                  child: ValueListenableBuilder(
                      valueListenable: _cubit.selectedCount,
                      builder: (BuildContext context, _, Widget? child) {
                        return Checkbox(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                          side: const BorderSide(color: AppColors.neutral300Color, width: 1),
                          activeColor: AppColors.yellow700Color,
                          value: _cubit.selectedCount.value != 0 ? true : false,
                          onChanged: (value) {
                            _cubit.toggleAllSelection(groupCarts.value, value!);
                          },
                        );
                      }),
                ),
                ValueListenableBuilder(
                    valueListenable: _cubit.selectedCount,
                    builder: (context, value, __) {
                      return Text(
                        'Chọn tất cả(${value.toString()} mặt hàng)',
                      );
                    }),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    ),
  );

  Widget _list() => SliverPadding(
    padding: EdgeInsets.symmetric(vertical: AppGap.h10),
    sliver: BlocBuilder<CartItemsCubit, CartItemsState>(
      bloc: _cubit,
      buildWhen: (prv, state) => state is CartItemsLoading || state is CartItemsSuccess || state is CartItemsEmpty,
      builder: (context, state) {
        print(state);
        if (state is CartItemsLoading) {
          return SliverToBoxAdapter(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            ),
          );
        }

        if (state is CartItemsSuccess) {
          //add data
          groupCarts = state.groupCarts!;
          return SliverPadding(
            padding: EdgeInsets.zero,
            sliver: ValueListenableBuilder(
                valueListenable: groupCarts,
                builder: (context, groupCartsValue, Widget? child) {
                  return groupCartsValue.isEmpty || groupCartsValue == []
                      ? SliverToBoxAdapter(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: Center(
                        child: Text(
                          'Tiếp tục mua sắm',
                          style: AppStyles.text5020(color: AppColors.black03),
                        ),
                      ),
                    ),
                  )
                      : SliverList.separated(
                    itemCount: groupCartsValue.length,
                    itemBuilder: (BuildContext context, int indexGroup) {
                      return BlocListener<CartItemsCubit, CartItemsState>(
                        bloc: _cubit,
                        listenWhen: (prv, state) {
                          return state is RemoveLoadingCartItemsSuccess ||
                              state is RemoveCartItemsSuccess ||
                              state is RemoveCartItemsFailed;
                        },
                        listener: (context, state) async {
                          if (state is RemoveLoadingCartItemsSuccess) {
                            openDialogBox(
                                context,
                                const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.yellow800Color,
                                  ),
                                ),
                                isBarrierDismissible: false);
                          } else if (state is RemoveCartItemsSuccess) {
                            await RouteService.pop();
                            DialogService.showNotiBannerSuccess(context, 'Xoá thành công sản phẩm!');
                          } else if (state is RemoveCartItemsFailed) {
                            RouteService.pop();
                            DialogService.showNotiBannerFailed(
                                context, AppColors.primary800Color, 'Xoá sản phẩm không thành công!');

                            /// return data remove
                            groupCartsValue[indexGroup].data!.add(itemCart);
                          }
                        },
                        child:  ItemCart(
                          dto: groupCartsValue[indexGroup],
                          listGroupCarts: groupCartsValue,
                          nameShop: groupCartsValue[indexGroup].data![0].siteCode!,
                          cubit: _cubit,
                          getCurrentIndex: (indexCart) {
                            removeItem(indexGroup, indexCart, groupCartsValue);
                          },
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return AppGap.sbH10;
                    },
                  );
                }),
          );
        }
        if (state is CartItemsEmpty) {
          return SliverToBoxAdapter(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: Center(
                child: Text(
                  'Tiếp tục mua sắm',
                  style: AppStyles.text5020(color: AppColors.black03),
                ),
              ),
            ),
          );
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    ),
  );

  Widget _row(String title, int number, [bool isAmountVn = false]) {
    return Row(
      children: [
        Text(title),
        const Spacer(),
        Text(
          isAmountVn
              ? AppConvert.convertNumberVn(number)
              : (number == 1
              ? '__'
              : AppConvert.convertNumberVn(
            number,
          )),
        ),
      ],
    );
  }
}
