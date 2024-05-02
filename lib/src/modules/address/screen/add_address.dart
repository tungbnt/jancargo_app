import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jancargo_app/src/components/resource/molecules/app_button.dart';
import 'package:jancargo_app/src/components/resource/molecules/input.dart';
import 'package:jancargo_app/src/components/resource/molecules/widget_label.dart';
import 'package:jancargo_app/src/domain/dtos/user/address_user/address_user_dto.dart';
import 'package:jancargo_app/src/domain/dtos/user/location_user/location_user_dto.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/domain/services/utils/validation.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/general/utils/model_func_utils.dart';
import 'package:jancargo_app/src/modules/address/bloc/address_user_cubit.dart';
import 'package:jancargo_app/src/modules/address/screen/update_address_screen.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key,});


  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final AddressUserCubit _cubit = AddressUserCubit();
  ValueNotifier<bool> isActiveBtn = ValueNotifier(false);
  ValueNotifier<bool> isActiveAddressDefault = ValueNotifier(false);
  ValueNotifier<bool> isToggleType = ValueNotifier(false);
  late WardsDto wardsDto;
  late DistrictsDto districtsDto;
  late ProvincesDto provincesDto;
  _btnSave() {
    if(_cubit.formKey.currentState!.validate()) {
      _cubit.addAddress(ItemsAddressUser(address: _cubit.controllerAddressOder.text,
      name:  _cubit.controllerFullName.text,
        phone: _cubit.controllerPhone.text,
        remark: _cubit.controllerNote.text,
        type: isToggleType.value ? "Home" : "Office",
        primary: isActiveAddressDefault.value, status: ValueNotifier(false),
        

      ),);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
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
          'Thêm Địa chỉ',
          style: AppStyles.text7018(),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: AppColors.white,
        padding: EdgeInsets.symmetric(horizontal: AppGap.w10,),
        child: Form(
          key: _cubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sizedBox(),
              _widgetLabel('Người liên hệ'),
              _field(
                  controller: _cubit.controllerFullName,
                  hint: 'Nhập họ và tên',
                  validator: (value) {
                    return Validation.validateName(value!);
                  },
                  onChange: (value) {
                    isActiveBtn.value = true;
                  }),
              _sizedBox(),
              _widgetLabel('Số ĐT'),
              _field(
                  controller: _cubit.controllerFullName,
                  hint: 'Nhập số điện thoại',
                  validator: (value) {
                    return Validation.validatorPhone(value!);
                  },
                  onChange: (value) {
                    isActiveBtn.value = true;
                  }),
              _sizedBox(),
              _widgetLabelNoRequire('Ghi chú'),
              _field(
                  controller: _cubit.controllerFullName,
                  hint: 'Nhập ghi chú',
                  onChange: (value) {
                    isActiveBtn.value = true;
                  }),
              _sizedBox(),
              _defaultAddress(),
              _sizedBox(),
              _widgetLabel('Địa chỉ nhận hàng'),
              _field(
                  controller: _cubit.controllerFullName,
                  hint: 'Nhập địa chỉ nhận hàng',
                  validator: (value) {
                    return Validation.validate(value: value!);
                  },
                  onChange: (value) {
                    isActiveBtn.value = true;
                  }),
              _sizedBox(),
              _widgetLabel('Tỉnh/Thành phố'),
              _getProvince(),
              _sizedBox(),
              _widgetLabel('Quận/Huyện'),
              _getDistrict(),
              _sizedBox(),
              _widgetLabel('Phường/Xã'),
              _getWard(),
              _sizedBox(),
              _toggleType(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sizedBox() => AppGap.sbH10;

  Widget _field({
    required TextEditingController controller,
    String? hint,
    String? Function(String?)? validator,
    Function(String value)? onChange,
  }) =>
      AppInput(
        placeholder: hint,
        controller: controller,
        maxLine: 1,
        validator: validator,
        onChange: onChange,
      );

  Widget _widgetLabelNoRequire(String label) =>
      WidgetLabel(label: label, isRequire: true);

  Widget _widgetLabel(String label) =>
      WidgetLabel(label: label, isRequire: true);

  Widget _defaultAddress() => ValueListenableBuilder(
      valueListenable: isActiveAddressDefault,
      builder: (context, _, __) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 28.w,
              height: 28.h,
              child: Checkbox(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r)),
                side: const BorderSide(
                    color: AppColors.neutral300Color, width: 2),
                activeColor: AppColors.yellow700Color,
                value: isActiveAddressDefault.value,
                onChanged: ((value) {
                  isActiveAddressDefault.value = !isActiveAddressDefault.value;
                  isActiveBtn.value = true;
                }),
              ),
            ),
            AppGap.sbW8,
            Text('Địa chỉ mặc định',
                style: AppStyles.text4014(color: AppColors.neutral800Color),
                textAlign: TextAlign.center),
          ],
        );
      });

  Widget _getProvince() => BlocBuilder<AddressUserCubit, AddressUserState>(
    bloc: _cubit,
    builder: (context, state) {
      print("_getProvince $state");
      return dropdown<ProvincesDto>(
        selectedItem: state.selectedProvincesDto,
        itemLabelGetter: (item) {
          return item.name!;
        },
        getData: state.provinceDto?.data,
        hintTextBuilder: (selectedItem) => selectedItem == null
            ? 'Chọn Tỉnh/Thành Phố'
            : selectedItem.name!,
        validator: (value) {
          return Validation.validate(value: value?.name!);
        },
        onChanged: (ProvincesDto? item) {
          _cubit.changeProvince(item!);
          isActiveBtn.value = true;
        },
      );
    },
  );

  Widget _getDistrict() => BlocBuilder<AddressUserCubit, AddressUserState>(
    bloc: _cubit,
    builder: (context, state) {
      print("_getDistrict $state");
      return dropdown<DistrictsDto>(
        selectedItem: state.selectedDistrictDto,
        itemLabelGetter: (item) => item.name!,
        getData: state.districtDto?.data,
        hintTextBuilder: (selectedItem) =>
        selectedItem == null ? 'Chọn Quận/Huyện' : selectedItem.name!,
        validator: (value) {
          return Validation.validate(value: value?.name!);
        },
        onChanged: (DistrictsDto? item) {
          _cubit.changeDistrict(item!);
          isActiveBtn.value = true;
        },
      );
    },
  );

  Widget _getWard() => BlocBuilder<AddressUserCubit, AddressUserState>(
    bloc: _cubit,
    builder: (context, state) {
      return dropdown<WardsDto>(
        selectedItem: state.selectedWardsDto,
        itemLabelGetter: (item) => item.name!,
        getData: state.wardDto?.data,
        hintTextBuilder: (selectedItem) =>
        selectedItem == null ? 'Chọn Phường/Xã' : selectedItem.name!,
        validator: (value) {
          return Validation.validate(value: value?.name!);
        },
        onChanged: (WardsDto? item) {
          _cubit.changeWard(item!);
          isActiveBtn.value = true;
        },
      );
    },
  );

  Widget _toggleType() => ValueListenableBuilder(
      valueListenable: isToggleType,
      builder: (context, value, __) {
        return InkWell(
          onTap: () {
            isToggleType.value = !isToggleType.value;
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  AppGap.r4,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: AppGap.h5),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: value
                              ? AppColors.primary800Color
                              : AppColors.neutral400Color),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            AppGap.r4,
                          ),
                          bottomLeft: Radius.circular(
                            AppGap.r4,
                          )),
                      color:
                      value ? AppColors.primary800Color : AppColors.white,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Nhà riêng',
                      style: AppStyles.text4014(
                          color: value
                              ? AppColors.white
                              : AppColors.neutral800Color),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: AppGap.h5),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: value
                              ? AppColors.neutral400Color
                              : AppColors.primary800Color),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(
                            AppGap.r4,
                          ),
                          bottomRight: Radius.circular(
                            AppGap.r4,
                          )),
                      color:
                      value ? AppColors.white : AppColors.primary800Color,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Văn phòng',
                      style: AppStyles.text4014(
                          color: value
                              ? AppColors.neutral800Color
                              : AppColors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });

  Widget _saveBtn() => BlocConsumer<AddressUserCubit, AddressUserState>(
    listenWhen: (prv, state) =>
        state is AddAddressUserDataSuccess || state is EditAddressUserLoading,
    listener: (context, state) {
      if (state is EditAddressUserLoading) {
        openDialogBox(
          context,
          const Center(
            child: CircularProgressIndicator(
              color: AppColors.yellow800Color,
            ),
          ),
        );
      } else if (state is AddAddressUserDataSuccess) {
        Navigator.pop(context, true);
      }
    },

  builder: (context, state) {
    return ValueListenableBuilder(
        valueListenable: isActiveBtn,
        builder: (context, _, __) {
          return AppButton(
              enable: isActiveBtn.value,
              onPressed: (){
                if(_cubit.formKey.currentState!.validate()) {
                  _cubit.addAddress(ItemsAddressUser(address: _cubit.controllerAddressOder.text,
                    name:  _cubit.controllerFullName.text,
                    phone: _cubit.controllerPhone.text,
                    remark: _cubit.controllerNote.text,
                    type: isToggleType.value ? "Home" : "Office",
                    primary: isActiveAddressDefault.value, status: ValueNotifier(false),
                    province: state.selectedProvincesDto!.name,
                    provinceId: state.selectedProvincesDto!.id,
                    district: state.selectedDistrictDto!.name,
                    districtId: state.selectedDistrictDto!.id,
                    ward: state.selectedWardsDto!.name,
                    wardId: state.selectedWardsDto!.id,
                  ),);
                }
              },
              text: 'Lưu lại');
        });
  },

  );

}