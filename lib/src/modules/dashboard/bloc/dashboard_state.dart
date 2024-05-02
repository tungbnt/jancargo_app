part of 'dashboard_cubit.dart';

@immutable
abstract class DashboardState {
  DashboardState({required DashboardState? state}) {
    exchangeDto = state?.exchangeDto;
    biddingDto = state?.biddingDto;
}

  ExchangeDto? exchangeDto;
  BiddingDto? biddingDto;

void copy(DashboardState? state) {
  exchangeDto = state?.exchangeDto;
  biddingDto = state?.biddingDto;
}
}

class DashboardInitial extends DashboardState {
  DashboardInitial({required super.state});
}
class DashboardLoading extends DashboardState {
  DashboardLoading({required super.state});
}
class DashboardDataSuccess extends DashboardState {
  DashboardDataSuccess({required super.state});
}

class OderPersonalSuccess extends DashboardDataSuccess {
  OderPersonalSuccess({required super.state});
}

