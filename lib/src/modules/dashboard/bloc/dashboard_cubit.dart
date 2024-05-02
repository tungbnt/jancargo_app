import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:jancargo_app/src/app_manager.dart';
import 'package:jancargo_app/src/domain/repositories/management/oder_management_repo.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/constants/app_constants.dart';
import 'package:jancargo_app/src/modules/home/screen/home_screens.dart';
import 'package:meta/meta.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../domain/dtos/user/bidding_user/bidding_user_dto.dart';
import '../../../domain/dtos/user/exchange_price/exchange_price_dto.dart';
import '../../../general/inject_dependencies/inject_dependencies.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial(state: null));
  int currentTabIndex = 0;
  PersistentTabController persistentTabController =
  PersistentTabController(initialIndex: 0);


  OderManagementRepo getOder = getIt<OderManagementRepo>();

  Future<void> initEvent() async {
    emit(DashboardLoading(state: null));
    try {
      List<DashboardState?> statusListLoadDataSuccess = await Future.wait<
          DashboardState?>([_fetchExchangePrice(),_fetchUserBidding()]);
      if (statusListLoadDataSuccess.every((element) => element != null) &&
          statusListLoadDataSuccess[0] is DashboardDataSuccess &&
          statusListLoadDataSuccess[1] is DashboardDataSuccess
      ) {
        emit(statusListLoadDataSuccess[0]!
          ..copy(statusListLoadDataSuccess[1])

        );
        await Future.delayed(const Duration(seconds: 1));
      }
    }catch(e){
      print('${e} có lỗi xảy ra');
    }
  }

  //get list flash sale
  Future<DashboardState?> _fetchExchangePrice() async {

    final response = await getOder.exchangePrice();
    DashboardState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {
      AppManager.appSession.saveExchange(r.data!.firstWhere((e) => e.currencyCode == 'JPY').sell);
      print('tiền nhật có giá \$\$\$\$: ${AppManager.appSession.exchange}');

      state = DashboardDataSuccess(state: state)
        ..exchangeDto = r;

    });
    return state;
  }

  Future<DashboardState?> _fetchUserBidding() async {

    final response = await getOder.userBidding();
    DashboardState? state;
    response.fold((l) {
      // no action need analytics in future
    }, (r) async {

      state = DashboardDataSuccess(state: state)
        ..biddingDto = r;

    });
    return state;
  }




  void onItemsSelected(int index) {
    if (currentTabIndex == index && index == 0) {
     RouteService.routeGoOnePage(const HomeScreen());
    } else if (index == 1) {

    } else if (index == 2) {

    } else if (index == 3 ) {

    } else if (index == 4 ) {
      // Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
      // final token = hiveBox.get(AppConstants.ACCESS_TOKEN);
      // if(token == null || token == ""){
      //   RouteService.routeGoOnePage(const LoginScreen());
      // }
      // RouteService.routeGoOnePage(const PersonalScreen());
    }
    currentTabIndex = index;
    persistentTabController.index = index;
  }
}
