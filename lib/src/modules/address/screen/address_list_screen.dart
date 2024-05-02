import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/modules/address/screen/add_address.dart';
import 'package:jancargo_app/src/modules/payment_oders/bloc/payment_oders_cubit.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../domain/dtos/user/address_user/address_user_dto.dart';
import 'update_address_screen.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key, required this.cubit});

  final PaymentOdersCubit cubit;

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  @override
  void initState() {
    super.initState();
    widget.cubit.fetchAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral100Color,
      appBar: AppBar(
        bottomOpacity: 0.0,
        backgroundColor: AppColors.white,
        leading: IconButton(
          highlightColor: Colors.transparent,
          onPressed: () => Future.delayed(Duration.zero, () {
            RouteService.pop();
          }),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.black03,
          ),
        ),
        title: Text(
          'Địa chỉ',
          style: AppStyles.text7018(),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<PaymentOdersCubit, PaymentOdersState>(
        bloc: widget.cubit,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is AddressUserLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is AddressUserDataSuccess) {
            final ValueNotifier<int?> groupValue = ValueNotifier(state.addressUserDto!.data!
                .indexWhere((e) => e.primary!));

            return Container(
              margin: EdgeInsets.symmetric(vertical: AppGap.h10),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  print(
                      "index: ${state.addressUserDto!.data!.indexWhere((e) => e.primary!)}");
                  return GestureDetector(
                    onTap: () {
                      // RouteService.routeGoOnePage(const UpdateAddress());
                      Navigator.pop(context,state.addressUserDto!.data![index]);
                    },
                    child: _ItemAddress(
                      key: Key(index.toString()),
                      cubit: widget.cubit,
                      itemsAddressUser: state.addressUserDto!.data![index],
                      isDivider: index < state.addressUserDto!.data!.length - 1,
                      value: index,
                      groupValue: groupValue,
                    ),
                  );
                },
                itemCount: state.addressUserDto!.data!.length,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _ItemAddress extends StatefulWidget {
  const _ItemAddress({
    super.key,
    required this.itemsAddressUser,
    required this.isDivider,
    required this.value,
    this.onChanged,
    required this.groupValue, required this.cubit,
  });

  final ItemsAddressUser itemsAddressUser;
  final bool isDivider;
  final int value;
  final ValueNotifier<int?> groupValue;
  final void Function(int?)? onChanged;
  final PaymentOdersCubit cubit;

  @override
  State<_ItemAddress> createState() => _ItemAddressState();
}

class _ItemAddressState<T> extends State<_ItemAddress> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.white,
          padding: EdgeInsets.only(
              top: AppGap.h10, bottom: widget.isDivider ? AppGap.h16 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ValueListenableBuilder(
                      valueListenable: widget.groupValue,
                      builder: (context, value, __) {
                        return Radio<int>(
                          value: widget.value,
                          groupValue: value,
                          onChanged: (int? value) {
                            widget.groupValue.value = value!;
                          },
                        );
                      }),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            (widget.itemsAddressUser).name!,
                            style: AppStyles.text4014(),
                          ),
                          Text(
                            ' |  ${(widget.itemsAddressUser).phone!}',
                            style: AppStyles.text4014(),
                          ),
                          AppGap.sbW20,
                        ],
                      ),
                      Text(
                        (widget.itemsAddressUser).address!,
                        style: AppStyles.text4012(),
                      ),
                      SizedBox(
                        width: AppGap.w290,
                        child: Text(
                          '${(widget.itemsAddressUser).ward}, ${(widget.itemsAddressUser).district}, ${(widget.itemsAddressUser).province}',
                          style: AppStyles.text4012(),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              if ((widget.itemsAddressUser).primary!)
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppGap.w10, vertical: AppGap.h5),
                  margin: EdgeInsets.symmetric(
                      horizontal: AppGap.w10, vertical: AppGap.h5),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(color: AppColors.primary800Color)),
                  child: Text(
                    'Mặc định',
                    style: AppStyles.text4014(color: AppColors.primary800Color),
                  ),
                ),
              if (widget.isDivider) const Divider(),
              if(widget.isDivider == false)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: ()async{
                       var result = await  RouteService.routeGoOnePage(const AddAddress());
                       if(result){
                         widget.cubit.fetchAddress();
                       }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppGap.w10, vertical: AppGap.h5),
                        margin: EdgeInsets.symmetric(
                            horizontal: AppGap.w10, vertical: AppGap.h20),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            border: Border.all(color: AppColors.primary800Color)),
                        child: Text(
                          'Thêm Địa chỉ',
                          style: AppStyles.text4014(color: AppColors.primary800Color),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        Positioned(
          bottom: widget.isDivider == false ? 60.h : 30.h,
          right: 10,
          child: GestureDetector(
            onTap: ()async{
            final result = await RouteService.routeGoOnePage(UpdateAddress(item: widget.itemsAddressUser),);
            if(result){
              widget.cubit.fetchAddress();
            }else{
              print('Không');
            }
            },
              child: const Text('Cập nhật')),)
      ],
    );
  }
}
