import 'package:dartz/dartz.dart';
import '../error/failures.dart';
import 'package:injectable/injectable.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

// For use cases that don't need parameters
@injectable
class NoParams {
  const NoParams();
} 