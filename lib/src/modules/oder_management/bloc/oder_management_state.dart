part of 'oder_management_cubit.dart';

@immutable
abstract class OderManagementState {
  OderManagementState({required OderManagementState? state}) {
    managementDto = state?.managementDto;
  }
  ManagementDto? managementDto;

  void copy(OderManagementState? state) {
    managementDto = state?.managementDto;
  }
}

class OderManagementInitial extends OderManagementState {
  OderManagementInitial({required super.state});
}
class OderManagementLoading extends OderManagementState {
  OderManagementLoading({required super.state});
}
class OderManagementAllSuccess extends OderManagementState {
  OderManagementAllSuccess({required super.state});
}
class OderManagementWaitForPaySuccess extends OderManagementState {
  OderManagementWaitForPaySuccess({required super.state});
}
class OderManagementPurchaseSuccess extends OderManagementState {
  OderManagementPurchaseSuccess({required super.state});
}
class OderManagementTransportSuccess extends OderManagementState {
  OderManagementTransportSuccess({required super.state});
}
class OderManagementProcessingSuccess extends OderManagementState {
  OderManagementProcessingSuccess({required super.state});
}
class OderManagementCreatedTicketSuccess extends OderManagementState {
  OderManagementCreatedTicketSuccess({required super.state});
}
class OderManagementDeliveringSuccess extends OderManagementState {
  OderManagementDeliveringSuccess({required super.state});
}
class OderManagementSuccessDelivery extends OderManagementState {
  OderManagementSuccessDelivery({required super.state});
}
class OderManagementCancelledSuccess extends OderManagementState {
  OderManagementCancelledSuccess({required super.state});
}
class OderManagementEmpty extends OderManagementState {
  OderManagementEmpty({required super.state});
}
class OderManagementFailed extends OderManagementState {
  OderManagementFailed({required super.state});
}
