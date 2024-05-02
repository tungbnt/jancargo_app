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
import 'package:jancargo_app/src/modules/address/widgets/text_drop_down.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

class UpdateAddress extends StatefulWidget {
  const UpdateAddress({super.key, required this.item});

  final ItemsAddressUser item;

  @override
  State<UpdateAddress> createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {
  final AddressUserCubit _cubit = AddressUserCubit();
  ValueNotifier<bool> isActiveUpdateAddress = ValueNotifier(false);
  late ValueNotifier<bool> isActiveAddressDefault;
  late ValueNotifier<bool> isToggleType;

  @override
  void initState() {
    super.initState();
    _cubit.getData(widget.item.provinceId!, widget.item.districtId!);
    isToggleType.value = widget.item.type == "home" ? true : false;
    isActiveAddressDefault.value = widget.item.primary ?? false;
  }

  _btnSave() {
    _cubit.saveAddress(widget.item);
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
            Navigator.pop(context,false);
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
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.white,
          padding: EdgeInsets.symmetric(
            horizontal: AppGap.w10,
          ),
          child: Form(
            key: _cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _widgetLabel('Người liên hệ'),
                _field(
                    initialValue: widget.item.name,
                    hint: 'Nhập họ và tên',
                    validator: (value) {
                      return Validation.validateName(value!);
                    },
                    onChange: (value) {
                      isActiveUpdateAddress.value = true;
                    }),
                _sizedBox(),
                _widgetLabel('Số ĐT'),
                _field(
                    initialValue: widget.item.phone,
                    hint: 'Nhập số điện thoại',
                    validator: (value) {
                      return Validation.validatorPhone(value!);
                    },
                    onChange: (value) {
                      isActiveUpdateAddress.value = true;
                    }),
                _sizedBox(),
                _widgetLabelNoRequire('Ghi chú'),
                widget.item.remark == null
                    ? AppInput(
                        placeholder: 'Nhập ghi chú',
                        controller:  _cubit.controllerNote,
                        maxLine: 1,
                        validator: (value) {
                          return Validation.validate(value: value!);
                        },
                        onChange: (value) {
                          isActiveUpdateAddress.value = true;
                        })
                    : AppInput(
                        placeholder: 'Nhập ghi chú',
                        initialValue:  widget.item.remark,
                        maxLine: 1,
                        validator: (value) {
                          return Validation.validate(value: value!);
                        },
                        onChange: (value) {
                          isActiveUpdateAddress.value = true;
                        }),
                _sizedBox(),
                _defaultAddress(),
                _sizedBox(),
                _widgetLabel('Địa chỉ nhận hàng'),
                _field(
                    initialValue: widget.item.address,
                    hint: 'Nhập địa chỉ nhận hàng',
                    validator: (value) {
                      return Validation.validate(value: value!);
                    },
                    onChange: (value) {
                      isActiveUpdateAddress.value = true;
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
                _widgetLabelNoRequire('Loại địa chỉ'),
                _toggleType(),
                _sizedBox(),
                _sizedBox(),
                _saveBtn(),
                _sizedBox(),
                _sizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
                  isActiveUpdateAddress.value = true;
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

  Widget _sizedBox() => AppGap.sbH10;

  Widget _field({
    String? hint,
    String? initialValue,
    String? Function(String?)? validator,
    Function(String value)? onChange,
  }) =>
      AppInput(
        placeholder: hint,
        initialValue: initialValue,
        maxLine: 1,
        validator: validator,
        onChange: onChange,
      );

  Widget _widgetLabelNoRequire(String label) =>
      WidgetLabel(label: label, isRequire: true);

  Widget _widgetLabel(String label) =>
      WidgetLabel(label: label, isRequire: true);

  Widget _getProvince() => BlocBuilder<AddressUserCubit, AddressUserState>(
        bloc: _cubit,
        builder: (context, state) {
          return dropdown<ProvincesDto>(
            selectedItem: state.selectedProvincesDto ?? ProvincesDto(countryId: 84,name: widget.item.province,id: widget.item.provinceId),
            itemLabelGetter: (item) => item.name!,
            getData: state.provinceDto?.data,
            validator: (value) {
              return Validation.validate(value: value?.name!);
            },
            hintTextBuilder: (selectedItem) => selectedItem == null
                ? 'Chọn Tỉnh/Thành Phố'
                : selectedItem.name!,
            onChanged: (ProvincesDto? item) {
              _cubit.changeProvince(item!);
              isActiveUpdateAddress.value = true;
            },
          );
        },
      );

  Widget _getDistrict() => BlocBuilder<AddressUserCubit, AddressUserState>(
        bloc: _cubit,
        builder: (context, state) {
          print("_getDistrict $state");
          return dropdown<DistrictsDto>(
            selectedItem: state.selectedDistrictDto ?? DistrictsDto(provinceId: widget.item.provinceId,name: widget.item.district,id: widget.item.districtId),
            itemLabelGetter: (item) => item.name!,
            getData: state.districtDto?.data,
            validator: (value) {
              return Validation.validate(value: value?.name!);
            },
            hintTextBuilder: (selectedItem) =>
                selectedItem == null ? 'Chọn Quận/Huyện' : selectedItem.name!,
            onChanged: (DistrictsDto? item) {
              _cubit.changeDistrict(item!);
              isActiveUpdateAddress.value = true;
            },
          );
        },
      );

  Widget _getWard() => BlocBuilder<AddressUserCubit, AddressUserState>(
        bloc: _cubit,
        builder: (context, state) {
          return dropdown<WardsDto>(
            selectedItem: state.selectedWardsDto ?? WardsDto(districtId: widget.item.districtId,name: widget.item.ward,id: widget.item.wardId),
            itemLabelGetter: (item) => item.name!,
            getData: state.wardDto?.data,
            validator: (value) {
              return Validation.validate(value: value?.name!);
            },
            hintTextBuilder: (selectedItem) =>
                selectedItem == null ? 'Chọn Phường/Xã' : selectedItem.name!,
            onChanged: (WardsDto? item) {
              _cubit.changeWard(item!);
              isActiveUpdateAddress.value = true;
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
            isActiveUpdateAddress.value = true;
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

  Widget _saveBtn() => BlocListener<AddressUserCubit, AddressUserState>(
    bloc: _cubit,
        listenWhen: (prv, state) =>
            state is EditAddressUserDataSuccess ||
            state is EditAddressUserFailed || state is EditAddressUserLoading,
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
          } else if (state is EditAddressUserDataSuccess) {
            Navigator.pop(context, true);
          } else if (state is EditAddressUserFailed) {
            Navigator.pop(context);
          }
        },
        child: ValueListenableBuilder(
            valueListenable: isActiveUpdateAddress,
            builder: (context, _, __) {
              return AppButton(
                  enable: isActiveUpdateAddress.value,
                  onPressed: _btnSave,
                  text: 'Lưu lại');
            }),
      );
}

class dropdown<T> extends StatelessWidget {
  const dropdown(
      {super.key,
      this.onChanged,
      required this.getData,
      this.validator,
      this.selectedItem,
      required this.hintTextBuilder,
      required this.itemLabelGetter});

  final void Function(T? item)? onChanged;
  final List<T>? getData;
  final String? Function(T?)? validator;
  final T? selectedItem;
  final String Function(T? selectedItem) hintTextBuilder;
  final String Function(T item) itemLabelGetter;

  @override
  Widget build(BuildContext context) {
    return DropdownFormField(
      selectedItem: selectedItem,
      searchTextStyle: AppStyles.text4014(color: AppColors.neutral800Color),
      hintTextBuilder: hintTextBuilder,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintStyle: AppStyles.text4014(color: AppColors.neutral300Color),
        contentPadding: const EdgeInsets.symmetric(horizontal: 11),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(color: AppColors.neutral300Color),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(color: AppColors.neutral300Color),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(color: AppColors.neutral300Color),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(color: AppColors.neutral400Color),
        ),
        suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
      ),
      dropdownDecoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.neutral300Color),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 6,
            spreadRadius: -4,
            color: Color.fromRGBO(0, 0, 0, 0.12),
          ),
          BoxShadow(
            offset: Offset(0, 6),
            blurRadius: 16,
            spreadRadius: 0,
            color: Color.fromRGBO(0, 0, 0, 0.08),
          ),
          BoxShadow(
            offset: Offset(0, 9),
            blurRadius: 28,
            spreadRadius: 8,
            color: Color.fromRGBO(0, 0, 0, 0.05),
          ),
        ],
      ),
      findFn: (keywords) async => getData,
      selectedItemBuilder: _buildDropdownSelectedItem,
      onChanged: onChanged,
      validator: validator,
      emptyText: 'Không có dữ liệu',
      dropdownItemFn: (item, position, focused, selected, onTap) {
        return InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Text(itemLabelGetter(item)),
          ),
        );
      },
    );
  }

  Widget _buildDropdownSelectedItem(dynamic item) {
    if (item == null) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(itemLabelGetter(item)),
    );
  }
}
