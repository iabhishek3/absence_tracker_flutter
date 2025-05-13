import 'package:injectable/injectable.dart';
import '../entities/absence.dart';
import '../repositories/absence_repository.dart';
import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';

@injectable
class GetAbsences {
  final AbsenceRepository repository;

  GetAbsences(this.repository);

  Future<Either<Failure, List<Absence>>> call() async {
    return await repository.getAbsences();
  }
} 