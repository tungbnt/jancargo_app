import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:hive/hive.dart';
import 'package:jancargo_app/src/app_manager.dart';
import 'package:jancargo_app/src/domain/repositories/management/oder_management_repo.dart';
import 'package:jancargo_app/src/domain/services/navigator/route_service.dart';
import 'package:jancargo_app/src/general/inject_dependencies/inject_dependencies.dart';
import 'package:jancargo_app/src/modules/auth/login/screens/login_screen.dart';
import 'package:meta/meta.dart';

import '../../../data/remote/middle-handler/failure.dart';
import '../../../domain/dtos/auth-model/access-token-dto.dart';
import '../../../domain/dtos/auth/get-local-access-token.dart';
import '../../../domain/repositories/auth/login/base_user_res/base_user.dart';
import '../../../domain/repositories/auth/save-access-token.dart';
import '../../../general/constants/app_constants.dart';

part 'init_app_state.dart';

class InitAppCubit extends Cubit<InitAppState> {
  InitAppCubit() : super(InitAppInitial(state: null));
  final AuthRepo authRepo = AuthRepo();
  OderManagementRepo getOder = getIt<OderManagementRepo>();
  bool isCheckToken = false;

  Future<void> initEvent() async {
    _checkFirst();
    try {
      final accessTokenResponse = await GetLocalAccessToken().get();
      accessTokenResponse.fold((l) async {
        if (l is! FailureDefault) {
          await Future.delayed(const Duration(seconds: 2));
          _saveToken("", "");
          emit(InitDataSuccess(state: state));
        }
      }, (r) async {
        //check token
        if (r.accessToken == "") {
          isCheckToken = true;
          return emit(InitDataSuccess(state: state));
        }
        //Push device to server. Importance is low. It not effect app work.

        // Fetch data for application
        List<InitAppState?> statusListLoadDataSuccess =
            await Future.wait<InitAppState?>([_fetch()]);
        if (statusListLoadDataSuccess.every((element) => element != null) &&
            statusListLoadDataSuccess[0] is InitHomeDataState ) {
          emit(statusListLoadDataSuccess[0]!);
          await Future.delayed(const Duration(seconds: 1));
        }
        // The call api error. It will pendding on splash screen.
      });
    } catch (e) {
      await Future.delayed(const Duration(seconds: 2));
      _saveToken("", "");
      return emit(InitDataSuccess(state: state));
    }
  }

  Future<InitAppState?> _fetch() async {
    InitAppState? state;

    if (isCheckToken) {
      emit(InitDataSuccess(state: state));
      isCheckToken = false;
      return state;
    }
    final response = authRepo.refreshToken();
    response.fold((left) {
      return RouteService.routePushReplacementPage(const LoginScreen());
    }, (right) async {
      await Future.delayed(const Duration(seconds: 1));
      _saveToken(right.accessToken!, right.refreshToken!);
      emit(InitDataSuccess(state: state));
      state = InitDataSuccess(state: state)..token = right.accessToken;

    });

    return state;
  }

  Future<InitAppState?> _fetchExchange() async {
    InitAppState? state;

    final response = getOder.exchangePrice();
    response.fold((left) {
      return RouteService.routePushReplacementPage(const LoginScreen());
    }, (right) async {
      await Future.delayed(const Duration(seconds: 1));


    });

    return state;
  }

  void _saveToken(String token, String refresh) async {
    await SaveAccessToken().put(AccessTokenDto(token));
    Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
    hiveBox.put(AppConstants.REFRESH_TOKEN, refresh);
  }

  void _checkFirst() async{
    Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
    final isFirstApp = hiveBox.get(AppConstants.IS_FIRST, defaultValue: null);
    if (isFirstApp == null) {
      hiveBox.put(AppConstants.IS_FIRST, "chào mừng bạn");
      await Future.delayed(const Duration(seconds: 2));
      return emit(InitOnBoarding(state: state));
    }

  }

  Future<void> refreshToken() async {
    final timePause = AppManager.appSession.isPauseApp;
    DateTime now = DateTime.now();
    Duration difference = timePause!.difference(now);
    int stopPeriodApp = difference.inDays;
    if (stopPeriodApp > 2) {
      final accessTokenResponse = await GetLocalAccessToken().get();
      accessTokenResponse.fold((l) {
        if (l is! FailureDefault) {
          //error
          refreshToken();
        }
      }, (r) async {
        //kiểm tra refresh
        print('Success refresh');
      });
    }
  }
}
