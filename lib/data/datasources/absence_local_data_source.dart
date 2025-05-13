import 'package:injectable/injectable.dart';
import '../models/absence_model.dart';

abstract class AbsenceLocalDataSource {
  Future<List<AbsenceModel>> getLastCachedAbsences();
  Future<void> cacheAbsences(List<AbsenceModel> absences);
}

@Injectable(as: AbsenceLocalDataSource)
class AbsenceLocalDataSourceImpl implements AbsenceLocalDataSource {
  @override
  Future<List<AbsenceModel>> getLastCachedAbsences() async => [];

  @override
  Future<void> cacheAbsences(List<AbsenceModel> absences) async {}
} 