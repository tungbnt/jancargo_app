import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import '../../../app_manager.dart';
import '../../../core/exception.dart';
import '../../../domain/dtos/auth-model/access-token-dto.dart';
import '../../../general/constants/app_constants.dart';
import '../../../general/inject_dependencies/inject_dependencies.dart';
import '../../remote/app-client.dart';


abstract class BaseDateSource {
  AppClient get appClient => getIt<AppClient>();
  Box hiveBox = Hive.box(AppConstants.APP_NAME_ID);
  BuildContext get context => AppManager.globalKeyRootMaterial.currentContext!;


  AccessTokenDto getLocalAccessToken() {
    final accessToken =
    hiveBox.get(AppConstants.ACCESS_TOKEN, defaultValue: null);
    if (accessToken == null) {
      throw NullException();
    }
    return AccessTokenDto(accessToken);
  }
}