import 'package:either_dart/either.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../data/datasource/auth/auth_source.dart';
import '../../../data/remote/middle-handler/failure.dart';
import '../../../general/inject_dependencies/inject_dependencies.dart';
import '../../dtos/auth-model/access-token-dto.dart';

@Singleton()
class SaveAccessToken {
  AuthSource get dataSource => getIt<AuthSource>();
  Future<Either<SaveLocalFailure, bool>> put(AccessTokenDto accessToken) async {
    try {
      dataSource.saveAccessToken(accessToken);
      return const Right(true);
    } on HiveError {
      return Left(SaveLocalFailure());
    }
  }
}
