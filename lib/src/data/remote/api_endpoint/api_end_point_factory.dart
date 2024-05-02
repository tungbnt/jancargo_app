library api_endpoint;
import 'package:flutter/material.dart';
import 'package:jancargo_app/src/app_manager.dart';

import '../../../general/app_flavor/app_config.dart';
import '../../../general/constants/app_environment.dart';
import '../api-endpoint.dart';

part './implements_api_endpoint/jan_api_end_point.dart';


class ApiEndPointFactory {
  static BuildContext get _context => AppManager.globalKeyRootMaterial.currentContext!;
  static AppEnvironment get _environment => AppConfig.of(_context)?.environment??AppEnvironment.DEVELOPMENT;




  static ApiEndpoint get jancargoServerEndPoint => _JanApiEndPoint(environment: _environment);



}
