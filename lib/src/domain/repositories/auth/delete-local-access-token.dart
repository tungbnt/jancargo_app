import 'package:either_dart/either.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../data/datasource/auth/auth_source.dart';
import '../../../data/remote/middle-handler/failure.dart';
import '../../../general/inject_dependencies/inject_dependencies.dart';

@Singleton()
class DeleteLocalAccessToken {
  AuthSource get datasource => getIt<AuthSource>();
  Future<Either<DeleteLocalFailure, bool>> delete() async {
    try {
      datasource.deleteLocalAccessToken();
      return const Right(true);
    } on HiveError {
      return Left(DeleteLocalFailure());
    }
  }
}
