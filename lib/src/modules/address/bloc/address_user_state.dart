part of 'address_user_cubit.dart';

@immutable
abstract class AddressUserState {
  AddressUserState({AddressUserState? state}){
    provinceDto = state?.provinceDto;
    districtDto = state?.districtDto;
    wardDto = state?.wardDto;
    selectedProvincesDto = state?.selectedProvincesDto;
    selectedDistrictDto = state?.selectedDistrictDto;
    selectedWardsDto = state?.selectedWardsDto;
  }
  ProvinceDto? provinceDto;
  DistrictDto? districtDto;
  WardDto? wardDto;
  ProvincesDto? selectedProvincesDto;
  DistrictsDto? selectedDistrictDto;
  WardsDto? selectedWardsDto;
  void copy(AddressUserState? state) {
    provinceDto = state?.provinceDto;
    districtDto = state?.districtDto;
    wardDto = state?.wardDto;
    selectedProvincesDto = state?.selectedProvincesDto;
    selectedDistrictDto = state?.selectedDistrictDto;
    selectedWardsDto = state?.selectedWardsDto;
  }
}

class AddressUserInitial extends AddressUserState {
  AddressUserInitial({required super.state});

}
class AddressUserLoading extends AddressUserState {
  AddressUserLoading({required super.state});
}
class ProvinceAddressUserDataSuccess extends AddressUserState {
  ProvinceAddressUserDataSuccess({required super.state});
}
class DistrictAddressUserDataSuccess extends AddressUserState {
  DistrictAddressUserDataSuccess({required super.state});
}
class WardAddressUserDataSuccess extends AddressUserState {
  WardAddressUserDataSuccess({required super.state});
}
class EditAddressUserLoading extends AddressUserState {
  EditAddressUserLoading({required super.state});
}
class EditAddressUserDataSuccess extends AddressUserState {
  EditAddressUserDataSuccess({required super.state});
}
class EditAddressUserFailed extends AddressUserState {
  EditAddressUserFailed({required super.state});
}
class AddAddressUserDataSuccess extends AddressUserState {
  AddAddressUserDataSuccess({required super.state});
}
class DataAddressSuccess extends AddressUserState {
  DataAddressSuccess({required super.state});
}
class DataProvinceAddressSuccess extends DataAddressSuccess {
  DataProvinceAddressSuccess({required super.state});
}
class DataDistrictAddressSuccess extends DataAddressSuccess {
  DataDistrictAddressSuccess({required super.state});
}
class DataWardAddressSuccess extends DataAddressSuccess {
  DataWardAddressSuccess({required super.state});
}

class ChangeProvinceAddressUserDataSuccess extends AddressUserState {
  ChangeProvinceAddressUserDataSuccess({required super.state});
}
class ChangeDistrictAddressUserDataSuccess extends AddressUserState {
  ChangeDistrictAddressUserDataSuccess({required super.state});
}
class ChangeWardAddressUserDataSuccess extends AddressUserState {
  ChangeWardAddressUserDataSuccess({required super.state});
}
