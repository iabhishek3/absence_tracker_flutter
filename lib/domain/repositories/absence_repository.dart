import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/absence.dart';

abstract class AbsenceRepository {
  Future<Either<Failure, List<Absence>>> getAbsences();
  Future<Either<Failure, Absence>> getAbsenceById(String id);
} 