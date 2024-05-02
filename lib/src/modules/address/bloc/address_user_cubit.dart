import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:jancargo_app/src/domain/dtos/user/address_user/address_user_dto.dart';
import 'package:jancargo_app/src/domain/dtos/user/location_user/location_user_dto.dart';
import 'package:jancargo_app/src/domain/repositories/components/user/user_repo.dart';
import 'package:jancargo_app/src/general/inject_dependencies/inject_dependencies.dart';
import 'package:meta/meta.dart';

part 'address_user_state.dart';

class AddressUserCubit extends Cubit<AddressUserState> {
  AddressUserCubit() : super(AddressUserInitial(state: null)) {
    getProvince();
  }
  UserRepo get = getIt<UserRepo>();
  final formKey = GlobalKey<FormState>();

  TextEditingController controllerFullName = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerNote = TextEditingController();
  TextEditingController controllerAddressOder = TextEditingController();

  Future<void> getData(int provinceId,int districtId) async {
    try {
      List<AddressUserState?> statusListLoadDataSuccess = await Future.wait<AddressUserState?>(
          [_fetchProvince(), _fetchDistrict(provinceId), _fetchWard(districtId), ]);
      if (statusListLoadDataSuccess.every((element) => element != null) &&
          statusListLoadDataSuccess[0] is DataAddressSuccess &&
          statusListLoadDataSuccess[1] is DataAddressSuccess &&
          statusListLoadDataSuccess[2] is DataAddressSuccess
         ) {
        emit(
          statusListLoadDataSuccess[0]!
            ..copy(
              statusListLoadDataSuccess[1]
                ?..copy(
                  statusListLoadDataSuccess[2]
                ),
            ),
        );
        await Future.delayed(const Duration(seconds: 1));
      } else {
        // emit(DetailProductFailed(state: state));
      }
    } catch (e) {
      // emit(DetailProductFailed(state: state));
      print('${e} có lỗi xảy ra');
    }
  }

  Future<AddressUserState?> _fetchProvince() async {
    final response = await get.getProvince();
    AddressUserState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {

      await Future.delayed(const Duration(seconds: 1));
      emit(DataAddressSuccess(state: state)
        ..provinceDto = r);

    });
    return state;
  }
  Future<AddressUserState?> _fetchDistrict(int provinceId) async {
    final response = await get.getDistrict(provinceId: provinceId.toString());
    AddressUserState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {

      await Future.delayed(const Duration(seconds: 1));
      emit(DataAddressSuccess(state: state)
        ..districtDto = r);

    });
    return state;
  }
  Future<AddressUserState?> _fetchWard(int districtId) async {
    final response = await get.getWard(districtId: districtId.toString());
    AddressUserState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {

      await Future.delayed(const Duration(seconds: 1));
      emit(DataAddressSuccess(state: state)
        ..wardDto = r);

    });
    return state;
  }

  void getProvince() async {
    final response = await get.getProvince();

    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(ProvinceAddressUserDataSuccess(state: state)
        ..provinceDto = r
        ..districtDto = null
        ..wardDto = null);
    });
  }

  void getDistrict(String provinceId) async {
    final response = await get.getDistrict(provinceId: provinceId);

    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(DistrictAddressUserDataSuccess(state: state)
        ..districtDto = r
        ..wardDto = null);
    });
  }

  void getWard(String districtId) async {
    final response = await get.getWard(districtId: districtId);

    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      emit(WardAddressUserDataSuccess(state: state)..wardDto = r);
    });
  }

  void changeProvince(ProvincesDto item) {
    emit(ChangeProvinceAddressUserDataSuccess(state: state)
      ..wardDto = null
      ..districtDto = null
      ..selectedProvincesDto = item
      ..selectedDistrictDto = null
      ..selectedWardsDto = null);
    getDistrict(item.id!.toString());
  }

  void changeDistrict(DistrictsDto item) {

    // emit
    emit(ChangeDistrictAddressUserDataSuccess(state: state)..wardDto = null..selectedDistrictDto = item..selectedWardsDto = null);
    getWard(item.id!.toString());
  }

  void changeWard(WardsDto item) {
    emit(ChangeWardAddressUserDataSuccess(state: state)..selectedWardsDto = item);
  }

  void saveAddress(ItemsAddressUser item)async{
    if(formKey.currentState!.validate()){
      emit(EditAddressUserLoading(state: state));
      final response = await get.editAddress(item);

      response.fold((l) {
        // no action need analytics in future
      }, (r) async {
        if(r){
          emit(EditAddressUserDataSuccess(state: state));
        }else{
          emit(EditAddressUserFailed(state: state));
        }
      });
    }else{

    }
  }

  void addAddress(ItemsAddressUser item)async{

      emit(EditAddressUserLoading(state: state));
      final response = await get.addAddress(item);

      response.fold((l) {
        // no action need analytics in future
      }, (r) async {
          emit(AddAddressUserDataSuccess(state: state));
      });
  }
}
