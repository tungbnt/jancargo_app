import 'package:flutter/material.dart';
import 'package:jancargo_app/src/components/resource/molecules/accordion.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../domain/dtos/user/warehouse/warehouse_dto.dart';

class CustomAccordionShip extends StatefulWidget {
  const CustomAccordionShip({
    super.key,
    required this.dto,
    this.getCurrentIndex,
  });

  final List<ShipModeDto> dto;
  final ValueSetter<int>? getCurrentIndex;

  @override
  State<CustomAccordionShip> createState() => _CustomAccordionShipState();
}

class _CustomAccordionShipState extends State<CustomAccordionShip> {
  ValueNotifier<int?>? currentIndex =  ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Accordion(
      title: 'Phí vận chuyển',
      headerBackgroundColor: AppColors.white,
      titleStyle: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      toggleIconOpen: Icons.keyboard_arrow_down_outlined,
      toggleIconClose: Icons.keyboard_arrow_up_sharp,
      headerIconColor: Colors.black,
      accordionElevation: 0,
      showContent: false,
      widgetItems: SizedBox(
        height: 200,
        child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return _itemShip(
                widget.dto[index].label!,
                widget.dto[index].priceEst ?? '',
                'Dự kiến nhận hàng : ${widget.dto[index].description}',
                index: index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return index < widget.dto.length - 1
                ? const Divider()
                : const SizedBox.shrink();
          },
          itemCount: widget.dto.length,
        ),
      ),
    );
  }

  Widget _itemShip(String methodShip, String amountOfMoney, String time,
      {int? index = 0}) {
    String number = amountOfMoney.replaceAll('/kg', '');
    return ValueListenableBuilder(
      valueListenable: currentIndex ?? ValueNotifier(0),
      builder: (BuildContext context, value, Widget? child) {
        return InkWell(
          onTap: () {
            currentIndex!.value = index;
            widget.getCurrentIndex?.call(index!);
          },
          child: Container(
            color:
                currentIndex!.value == index ? AppColors.primary50Color : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      methodShip,
                      style: AppStyles.text4014(color: AppColors.black03),
                    ),
                    const Spacer(),
                    Text(
                        number != ''
                            ? '${AppConvert.convertVn(int.parse(number))}/kg'
                            : '',
                        style: AppStyles.text4014(
                            color: AppColors.primary700Color)),
                    AppGap.sbW12
                  ],
                ),
                Text(time,
                    style:
                        AppStyles.text4014(color: AppColors.neutral500Color)),
              ],
            ),
          ),
        );
      },
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
