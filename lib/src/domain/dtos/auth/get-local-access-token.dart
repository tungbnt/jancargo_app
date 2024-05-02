import 'package:either_dart/either.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../data/datasource/auth/auth_source.dart';
import '../../../data/remote/middle-handler/failure.dart';
import '../../../general/inject_dependencies/inject_dependencies.dart';
import '../auth-model/access-token-dto.dart';

@Singleton()
class GetLocalAccessToken {
  AuthSource get datasource => getIt<AuthSource>();

  Future<Either<LoadLocalFailure, AccessTokenDto>> get() async {
    try {
      final data = datasource.getLocalAccessToken();
      if (data.accessToken != null) {
        return Right(data);
      }
      return Left(LoadLocalFailure());
    } on HiveError {
      return Left(LoadLocalFailure());
    }
  }
}
