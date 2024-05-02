import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../data/datasource/setting/setting_datasource.dart';
import '../../../data/object_request_api/request_change/request_change_pass.dart';
import '../../../data/remote/middle-handler/failure.dart';
import '../../../data/remote/middle-handler/result-handler.dart';
import '../../../general/inject_dependencies/inject_dependencies.dart';

@Singleton()
class SettingRepo {
  SettingSource get _dataSource => getIt<SettingSource>();

  Future<Either<Failure, bool>> changePass(
      {required ChangePassRequest request}) async {
    return ResultMiddleHandler.checkResult(() async {
      return await _dataSource.changePass(request);
    });
  }
}