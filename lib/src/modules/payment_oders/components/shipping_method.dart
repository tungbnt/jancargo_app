import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jancargo_app/src/domain/dtos/user/warehouse/warehouse_dto.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/payment_oders/bloc/payment_oders_cubit.dart';
import 'package:jancargo_app/src/modules/payment_oders/widget/item_method.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

class ShippingMethod extends StatefulWidget {
  const ShippingMethod({
    super.key,
    required this.cubit,
    required this.selectedShippingMethod,
    required this.onChanged,
  });

  final PaymentOdersCubit cubit;
  final ValueNotifier<ShipModeDto?> selectedShippingMethod;
  final VoidCallback onChanged;

  @override
  State<ShippingMethod> createState() => _ShippingMethodState();
}

class _ShippingMethodState extends State<ShippingMethod> {
  late List<ShipModeDto>? shipModeDto = widget.cubit.shipModeDto;

  @override
  Widget build(BuildContext context) {
    final Widget child;

    if (shipModeDto == null || shipModeDto?.isEmpty == true) {
      child = const SizedBox();
    } else {
      child = Padding(
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
              valueListenable: widget.selectedShippingMethod,
              builder: (context, selectedShippingMethod, __) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: AppGap.h78,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final shippingMethod = shipModeDto![index];
                      final isSelected = selectedShippingMethod == shippingMethod;

                      return ItemMethod(
                        dto: shippingMethod,
                        isSelected: isSelected,
                        onTap: () {
                          if (selectedShippingMethod != shippingMethod) {
                            widget.selectedShippingMethod.value = shippingMethod;
                          }

                          widget.onChanged();
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return AppGap.sbW8;
                    },
                    itemCount: shipModeDto!.length,
                  ),
                );
              },
            ),
          ],
        ),
      );
    }

    return BlocListener<PaymentOdersCubit, PaymentOdersState>(
      bloc: widget.cubit,
      listenWhen: (prv, state) => state is WareHousePaymentOdersDataSuccess,
      listener: (context, state) {
        if (state.shipModeDto == null) return;

        setState(() {
          shipModeDto = state.shipModeDto;
        });
      },
      child: child,
    );
  }
}
