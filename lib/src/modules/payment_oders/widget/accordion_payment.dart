import 'package:flutter/material.dart';
import 'package:jancargo_app/src/components/resource/molecules/accordion.dart';
import 'package:jancargo_app/src/general/app_strings/app_strings.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../domain/dtos/user/warehouse/warehouse_dto.dart';

class AccordionPayment extends StatefulWidget {
  const AccordionPayment({
    super.key, required this.shipService, required this.shipPay, required this.shipInland,

  });

  final String shipService;
  final String shipPay;
  final String shipInland;

  @override
  State<AccordionPayment> createState() => _AccordionPaymentState();
}

class _AccordionPaymentState extends State<AccordionPayment> {
  ValueNotifier<int?>? currentIndex =  ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Accordion(
      title: AppStrings.of(context).serviceCharge,
      headerBackgroundColor: AppColors.white,
      titleStyle: AppStyles.text5014(color: AppColors.neutral700Color),
      toggleIconOpen: Icons.keyboard_arrow_down_outlined,
      toggleIconClose: Icons.keyboard_arrow_up_sharp,
      accordionElevation: 0,
      showContent: false,

      widgetItems: SizedBox(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _row('Tổng tiền sản phẩm',widget.shipService),
            _row(AppStrings.of(context).paymentFees,widget.shipPay),
            _row(AppStrings.of(context).serviceCharge,widget.shipInland),
          ],
        )
      ),
    );
  }

  Widget _row(String ship,String number) {
    return Row(
      children: [
        Text(ship),
        const Spacer(),
        Text(number == '0' ? 'Đang cập nhật' : AppConvert.convertAmountJp(int.parse(number),),),
      ],
    );
  }

}

class MyInputForm extends StatelessWidget //__
    {
  const MyInputForm({super.key});

  @override
  Widget build(context) //__
  {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            label: const Text('Some text goes here ...'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Submit'),
        )
      ],
    );
  }
}
