import 'package:jancargo_app/src/general/app_strings/app_strings.dart';

import '../../../data/remote/middle-handler/failure.dart';
import '../navigator/route_service.dart';

abstract class FailureHandler {

  static void HandleUnauthorizedFailure(Failure failure, Function onLogout, Function(String message) onShowMessage){
    if(failure is UnauthorizedFailure){
      onLogout.call();
    } else {
      if(failure.message ==null || failure.message!.isEmpty){
        failure.message = AppStrings.of(RouteService.context).error;
      }
      onShowMessage.call(failure.message ?? AppStrings.of(RouteService.context).error);
    }
  }

}