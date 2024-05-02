import 'package:either_dart/either.dart';
import 'package:jancargo_app/src/core/exception.dart';

import 'failure.dart';
import 'logger_interceptor.dart';


abstract class ResultMiddleHandler {
  static Future<Either<Failure, T>> checkResult<T>(Function function) async {
    try {
      final data = await function.call();
      return Right(data);
    } on UnauthorizedException catch (e) {
      print('UnauthorizedException  $e');
      return Left(UnauthorizedFailure(e.message));
    } on ErrorStatusFromServerWithStatus200 catch (e) {
      return Left(e);
    } catch (e) {
      // print('SERVER ERROR 500  ${e is ServerException ? e.message : e} \n');

      return Left(ServerFailure('Server error'));
    }
  }

  static getCodeError(dynamic errorFromCatch, Function function) {
    List<dynamic> errors = [];
    errors.add(DateTime.now());
    errors.add(function);
    errors.add(StackTrace.current);
    errors.add(LoggerInterceptor.requestOptionsError);
    // errors.add(LoggerInterceptor.responseError?.data);
    errors.add(errorFromCatch.toString());
    return errors.join("\n");
  }
}
