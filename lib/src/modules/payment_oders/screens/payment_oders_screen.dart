
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jancargo_app/src/components/resource/molecules/input.dart';
import 'package:jancargo_app/src/domain/dtos/cart/calculate_cart/calculate_cart_dto.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/payment_oders/components/coupon_payment.dart';
import 'package:jancargo_app/src/modules/payment_oders/components/service_extras.dart';
import 'package:jancargo_app/src/modules/payment_oders/components/shipping_method.dart';
import 'package:jancargo_app/src/modules/payment_oders/components/store_prod.dart';
import 'package:jancargo_app/src/util/app_convert.dart';

import '../../../components/resource/molecules/app_button.dart';
import '../../../components/resource/molecules/app_loading.dart';
import '../../../domain/dtos/cart/item_cart/item_cart_dto.dart';
import '../../../domain/dtos/user/address_user/address_user_dto.dart';
import '../../../domain/services/navigator/route_service.dart';
import '../../../general/constants/app_colors.dart';
import '../../../general/constants/app_images.dart';
import '../../../util/app_gap.dart';
import '../../address/screen/address_list_screen.dart';
import '../../auction/components/wallet.dart';
import '../../auth/login/screens/login_screen.dart';
import '../bloc/payment_oders_cubit.dart';
import '../bloc/payment_order_item.dart';
import '../components/payment_one.dart';
import '../components/payment_tw0.dart';
import '../widget/wallet_oders.dart';

class PaymentOderScreen extends StatefulWidget {
  const PaymentOderScreen({super.key, required this.calculatePay});

  final ValueNotifier<CalculateCartDto> calculatePay;

  @override
  State<PaymentOderScreen> createState() => _PaymentOdersScreenState();
}

class _PaymentOdersScreenState extends State<PaymentOderScreen> with TickerProviderStateMixin {
  final PaymentOdersCubit _cubit = PaymentOdersCubit();
  ValueNotifier<bool> isActive = ValueNotifier(false);
  ValueNotifier<int?> selectedIndex = ValueNotifier<int?>(null);

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

  ValueNotifier<bool> isDetailCart = ValueNotifier(false);



  @override
  void initState() {
    super.initState();
    _cubit.totalAmount.value = widget.calculatePay.value.payment!.totalFirst!;
    _cubit.calculate( widget.calculatePay.value);
    _cubit.getData(dto: widget.calculatePay.value);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => RouteService.pop(),
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.black03,
          ),
        ),
        title: Text(AppStrings.of(context).paymentOrders),
        elevation: 0,
      ),
      backgroundColor: AppColors.neutral200Color,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _addressUser(),
              _infoPayProduct(),
              _sizedBox(),
              _wallet(),
              _sizedBox(),
              // _paymentOne(),
              // _sizedBox(),
              _paymentTwo(),
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
            child: FadeTransition(
              opacity: _animationOpacity,
              child: SizeTransition(
                sizeFactor: _animationSized,
                axisAlignment: -1,
                child: Container(
                  color: AppColors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: AppGap.h10),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text('Chi tiết'),
                                ),
                              ],
                            ),
                          ),
                          const Divider(color: AppColors.neutral300Color),
                          Wallet(
                            color: AppColors.white,
                            number: widget.calculatePay.value.payment!.totalFirst!,
                          ),
                          _buildDetailPay(),
                        ],
                      ),
                      Positioned(
                        top: -5,
                        right: 0,
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: AppColors.white,
        height: AppGap.h90,
        padding: EdgeInsets.symmetric(horizontal: AppGap.h10),
        child: Column(
          children: [
            ValueListenableBuilder(
                valueListenable: _cubit.isActiveAgreeCondition,
                builder: (context, valueNoti, _) {
                  return Row(
                    children: [
                      SizedBox(
                        width: 28.w,
                        height: 28.h,
                        child: Checkbox(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
                          side: const BorderSide(color: AppColors.neutral300Color, width: 2),
                          activeColor: AppColors.yellow700Color,
                          value: valueNoti,
                          onChanged: ((value) {
                            _cubit.isActiveAgreeCondition.value = !_cubit.isActiveAgreeCondition.value;
                            _cubit.isActivePay(widget.calculatePay.value.payment!.totalFirst!);
                          }),
                        ),
                      ),
                      AppGap.sbW8,
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(style: AppStyles.text4012(color: AppColors.neutral600Color), children: [
                          const TextSpan(text: "Đồng ý với "),
                          TextSpan(
                            text: AppStrings.of(context).termsAndPolicies,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => RouteService.routePushReplacementPage(
                                const LoginScreen(),
                              ),
                            style: AppStyles.text4012(color: AppColors.primary800Color),
                          ),
                          const TextSpan(text: " của Jancargo"),
                        ]),
                      ),
                    ],
                  );
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ValueListenableBuilder(
                  valueListenable: _cubit.totalAmount,
                  builder: (BuildContext context, value, Widget? child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ValueListenableBuilder(
                          builder: (context, _, __) {
                            return GestureDetector(
                              onTap: () {
                                _controller.forward();
                                isDetailCart.value = true;
                              },
                              child: Row(
                                children: [
                                  const Text(
                                    "Thanh toán lần 1(100%)",
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
                          AppConvert.convertNumberVn(_cubit.totalAmount.value),
                          style: AppStyles.text6020(color: AppColors.primary800Color),
                        ),
                      ],
                    );
                  },
                ),
                BlocListener<PaymentOdersCubit, PaymentOdersState>(
                  bloc: _cubit,
                  listenWhen: (prv, state) =>
                  state is ConfirmPaymentOdersLoading ||
                      state is ConfirmPaymentOdersDataSuccess ||
                      state is IsActivePayPaymentOders,
                  listener: (context, state) async {
                    if (state is ConfirmPaymentOdersDataSuccess) {
                    } else if (state is ConfirmPaymentOdersLoading) {
                      return await AppLoading.openSpinkit(context);
                    } else if (state is IsActivePayPaymentOders) {
                      _cubit.isActivePayment.value = state.isActivePay!;
                    }
                  },
                  child: ValueListenableBuilder(
                      valueListenable: _cubit.isActivePayment,
                      builder: (context, value, _) {
                        return AppButton(
                          enable: _cubit.isActivePayment.value,
                          height: AppGap.h40,
                          onPressed: () {
                            _cubit.paymentOder();
                          },
                          text: "Xác nhận",
                          radius: AppGap.r4,
                          color: AppColors.yellow700Color,
                          borderColor: AppColors.neutral200Color,
                        );
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _addressUser() {
    return SliverToBoxAdapter(
      child: BlocBuilder<PaymentOdersCubit, PaymentOdersState>(
        bloc: _cubit,
        buildWhen: (prv, state) => state is AddressUserPaymentOdersDataSuccess,
        builder: (context, state) {
          if (state is AddressUserPaymentOdersDataSuccess) {
            _cubit.itemsAddressUser =
                state.addressUserDto!.data!.firstWhere((e) => e.primary == true, orElse: () => ItemsAddressUser(status: ValueNotifier(false)));
            return Container(
              padding: EdgeInsets.symmetric(horizontal: AppGap.w8, vertical: AppGap.h10),
              margin: EdgeInsets.symmetric(vertical: AppGap.h10),
              color: AppColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Địa chỉ nhận hàng',
                        style: AppStyles.text6016(color: AppColors.neutral800Color),
                      ),
                      GestureDetector(
                        onTap: ()=>RouteService.routeGoOnePage(AddressListScreen(cubit: _cubit,)),
                        child: Text(
                          'Thay đổi',
                          style: AppStyles.text6016(color: AppColors.neutral800Color),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${_cubit.itemsAddressUser.name}  ${_cubit.itemsAddressUser.phone}',
                    style: AppStyles.text6014(color: AppColors.neutral800Color),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${_cubit.itemsAddressUser.address},${_cubit.itemsAddressUser.ward},${_cubit.itemsAddressUser.district},${_cubit.itemsAddressUser.province}",
                            style: AppStyles.text4014(color: AppColors.neutral800Color),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: AppGap.w5),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary800Color),
                      color: AppColors.white,
                    ),
                    child: Text(
                      "Mặc định",
                      style: AppStyles.text4014(color: AppColors.primary800Color),
                    ),
                  )
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _infoPayProduct() => BlocBuilder<PaymentOdersCubit, PaymentOdersState>(
    bloc: _cubit,
    buildWhen: (prv, state) => state is GetItemCartPaymentOdersDataSuccess,
    builder: (context, state) {
      if (state is GetItemCartPaymentOdersDataSuccess) {
        _cubit.paymentOrderItems = state.paymentOrderItems;

        if (_cubit.paymentOrderItems == null) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return Container(
                color: AppColors.white,
                margin: EdgeInsets.only(bottom: AppGap.h10),
                child: Column(
                  children: [
                    _itemPayment(_cubit.paymentOrderItems![index].cartItem),
                    _componentsOder(_cubit.paymentOrderItems![index]),
                  ],
                ),
              );
            },
            childCount: _cubit.paymentOrderItems!.length,
          ),
        );
      }
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    },
  );

  Widget _itemPayment(ItemCartDto? items) => StoreProd(
    dto: items!,
  );

  Widget _methodShip(PaymentOrderItem items) {
    return ShippingMethod(
      // key: ValueKey(items),
      cubit: _cubit,
      selectedShippingMethod: items.selectedShipMethod,
      onChanged: () {
        setState(() {
          _cubit.isActivePay(widget.calculatePay.value.payment!.totalFirst!);
        });
      },
    );

    /*
    return BlocBuilder<PaymentOdersCubit, PaymentOdersState>(
      bloc: _cubit,
      buildWhen: (prv, state) => state is WareHousePaymentOdersDataSuccess,
      builder: (context, state) {
        final shipModeDto = state.shipModeDto ?? _cubit.shipModeDto;

        if (state is WareHousePaymentOdersDataSuccess) {
          if (shipModeDto == null || shipModeDto.isEmpty) {
            return const SizedBox();
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: AppGap.w10, vertical: AppGap.h10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Phương thức vận chuyển',
                  style: AppStyles.text5016(),
                ),
                AppGap.sbH10,
                ValueListenableBuilder(
                  valueListenable: items.selectedShipMethod,
                  builder: (context, value, __) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: AppGap.h78,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final shippingMethod = shipModeDto[index];
                          final isSelected = items.selectedShipMethod.value == shippingMethod;

                          return ItemMethod(
                            dto: shippingMethod,
                            isSelected: isSelected,
                            onTap: () {
                              if (items.selectedShipMethod.value != shippingMethod) {
                                items.selectedShipMethod.value = shippingMethod;
                              }

                              setState(() {
                                _cubit.isActivePay(widget.total.value);
                              });
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return AppGap.sbW8;
                        },
                        itemCount: state.shipModeDto!.length,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
    */
  }

  Widget _divider() => const Divider();

  Widget _sizedBox() => SliverToBoxAdapter(child: AppGap.sbH10);

  Widget _wallet() => SliverToBoxAdapter(
    child: BlocBuilder<PaymentOdersCubit, PaymentOdersState>(
      bloc: _cubit,
      buildWhen: (prv, state) => state is GetTranAuctionPaymentOdersDataSuccess,
      builder: (context, state) {
        if (state is GetTranAuctionPaymentOdersDataSuccess) {
          return WalletOders(
            number: state.tranDto!.total!,
            color: AppColors.yellow700Color,
          );
        }
        return const SizedBox.shrink();
      },
    ),
  );

  Widget _paymentOne() => const SliverToBoxAdapter(
      child: PaymentOne(
        shipService: '10000000',
        shipPay: '10000000',
        shipInland: '10000000',
      ));

  Widget _paymentTwo() => const SliverToBoxAdapter(
      child: PaymentTwo(
        shipService: '0',
        shipPay: '0',
        shipInland: '0',
      ));

  Widget _componentsOder(PaymentOrderItem items) => Container(
    color: AppColors.white,
    padding: EdgeInsets.only(bottom: AppGap.h16),
    child: Column(
      children: [
        _methodShip(items),
        _divider(),
        _note(),
        _divider(),
        _service(items),
        _divider(),
        _buildCoupon(items),
        _divider(),
        _buildTotalPayStore(items.cartItem),
      ],
    ),
  );

  Widget _note() {
    return NotePaymentItem();
  }



  Widget _buildCoupon(PaymentOrderItem item) {
    return CouponPayment(
     cubit: _cubit,
    );
  }

  Widget _service(PaymentOrderItem item) {
    return ServiceExtras(
      cubit: _cubit,
      item: item,
    );

    /*
    return BlocBuilder<PaymentOdersCubit, PaymentOdersState>(
      bloc: _cubit,
      buildWhen: (prv, state) => state is GetServiceExtrasPaymentOdersDataSuccess,
      builder: (context, state) {
        if (state is GetServiceExtrasPaymentOdersDataSuccess) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              await DialogService.openDialog(
                _UpdateToServiceExtrasDialog(
                  item: item,
                  serviceExtrasDto: state.serviceExtrasDto!,
                ),
                barrierDismissible: true,
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Dịch vụ GTGT', style: AppStyles.text5014(color: AppColors.neutral800Color)),
                    const Icon(Icons.navigate_next_outlined)
                  ],
                ),
              ),
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Dịch vụ GTGT', style: AppStyles.text5014(color: AppColors.neutral800Color)),
              const Icon(Icons.navigate_next_outlined)
            ],
          ),
        );
      },
    );
    */
  }

  Widget _buildTotalPayStore(ItemCartDto? items) => Padding(
    padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Tổng', style: AppStyles.text5014(color: AppColors.neutral800Color)),
        Text(
          AppConvert.convertAmountVn((items!.price! * items.selectedAmount.value)),
          style: AppStyles.text5020(color: AppColors.primary800Color),
        ),
      ],
    ),
  );

  Widget _buildDetailPay() {

    return ValueListenableBuilder(
      valueListenable: _cubit.calculateModel,
      builder: (context,value,__) {
        return Padding(
        padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text('Thanh toán lần 1',style: AppStyles.text6016(),),
            _row('Tổng tiền sản phẩm', value.paymentCurrent),
            _row('Phí dịch vụ', value.feeService),
            _row('Phí thanh toán', value.feePayment),
            const Divider(color: AppColors.neutral300Color),
            // _row('Cước vận chuyển quốc tế(*)', 0.0),
            // _row('Gói cơ bản', 0.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text('Tạm tính',style: AppStyles.text6016(),),
                 Text(AppConvert.convertNumberVn(value.totalCurrent.toInt()),style: AppStyles.text7018(color: AppColors.primary800Color),),
              ],
            ),
            _row('Thanh toán trước(100%)', value.subCurrent),
            AppGap.sbH5,
            _buildNotePayment(),
          ],
        ),
          );
      }
    );
  }
  Widget _buildNotePayment() => RichText(
    textAlign: TextAlign.left,
    text: TextSpan(style: AppStyles.text4012(color: AppColors.neutral600Color), children: [
      TextSpan(
        text: "*",
        style: AppStyles.text4012(color: AppColors.primary800Color),
      ),
       TextSpan(text: "Quý khách nên thanh toán ngay tránh sản phẩm bị tăng giá do chênh lệch tỉ giá",),
    ]),
  );

  Widget _row(String ship, double number) {
    return Row(
      children: [
        Text(ship),
        const Spacer(),
        Text(
          number == 0.0
              ? AppConvert.convertNumberVn(
              0,
    )
              : AppConvert.convertNumberVn(
            number.toInt().round(),
          ),
        ),
      ],
    );
  }


}

class NotePaymentItem extends StatefulWidget {
  const NotePaymentItem({super.key});

  @override
  State<NotePaymentItem> createState() => _NotePaymentItemState();
}

class _NotePaymentItemState extends State<NotePaymentItem> {
  ValueNotifier<String> note = ValueNotifier('Để lại lời nhắn ...');

  Future<String?> _dialogLikeSeller(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String content = '';

        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            height: AppGap.h221,
            color: AppColors.white,
            margin: EdgeInsets.symmetric(horizontal: AppGap.w10),
            padding: EdgeInsets.symmetric(
                horizontal: AppGap.w15, vertical: AppGap.h24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Ghi chú',
                    style: AppStyles.text6016(color: AppColors.neutral800Color),
                  ),
                ),
                AppGap.sbH20,
                AppInput(
                  maxLine: 5,
                  height: AppGap.h55,
                  initialValue: note.value == 'Để lại lời nhắn ...' ? null : note.value,
                  placeholder: "Nhập nội dung ghi chú",
                  onChange: (text) {
                    content = text;
                  },
                ),
                AppGap.sbH20,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _btnCustom(() => Navigator.of(context).pop(), 'Đóng',
                        AppColors.white, AppColors.neutral800Color),
                    AppGap.sbW8,
                    _btnCustom(() => Navigator.of(context).pop(content),
                        'Lưu lại', AppColors.yellow800Color,
                        AppColors.yellow800Color),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async{
        print('content : ${note.value}');
        String? result =  await _dialogLikeSeller(context,);
        print('content : ${note.value}');
        if(result!.isNotEmpty){
          print('content : ${note.value}');
          note.value = result;
          print('content : ${note.value}');
        }
      },
      child: ValueListenableBuilder(
          valueListenable: note,
          builder: (context,content,_) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: AppGap.w10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Ghi chú', style: AppStyles.text5014(color: AppColors.neutral800Color)),
                  AppGap.sbW50,
                  Expanded(child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                      children: [Text(note.value, style: AppStyles.text4014(color: AppColors.neutral500Color),overflow: TextOverflow.ellipsis,)])),
                ],
              ),
            );
          }
      ),
    );
  }

  Widget _btnCustom(void Function()? onTap, String name, Color btnColors,
      Color borderColors) =>
      InkWell(
        onTap: onTap,
        child: Container(
          width: AppGap.w90,
          height: AppGap.h32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: btnColors,
              borderRadius: BorderRadius.circular(AppGap.r4),
              border: Border.all(width: 1, color: borderColors)),
          child: Text(
            name,
            style: AppStyles.text4012(color: AppColors.neutral800Color),
            textAlign: TextAlign.center,
          ),
        ),
      );

}

