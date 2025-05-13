import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/absence.dart';
import '../../domain/repositories/absence_repository.dart';
import '../datasources/absence_remote_data_source.dart';
import '../models/member_model.dart';

@Injectable(as: AbsenceRepository)
class AbsenceRepositoryImpl implements AbsenceRepository {
  final AbsenceRemoteDataSource remoteDataSource;

  AbsenceRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Absence>>> getAbsences() async {
    try {
      final absences = await remoteDataSource.getAbsences();
      final members = await remoteDataSource.getMembers();
      
      // Create maps for quick lookup
      final memberNameMap = {
        for (var member in members) member.userId: member.name
      };
      final memberImageMap = {
        for (var member in members) member.userId: member.image
      };

      // Combine absence and member data
      final absencesWithMembers = absences.map((absence) {
        final memberName = memberNameMap[absence.userId] ?? 'Unknown Member';
        final memberImage = memberImageMap[absence.userId] ?? 'https://loremflickr.com/300/400';
        final entity = absence.toEntity();
        return Absence.withMemberName(memberName, memberImage, entity);
      }).toList();

      return Right(absencesWithMembers);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to get absences: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Absence>> getAbsenceById(String id) async {
    try {
      final absence = await remoteDataSource.getAbsenceById(id);
      final members = await remoteDataSource.getMembers();
      final member = members.firstWhere(
        (m) => m.userId.toString() == absence.userId.toString(),
        orElse: () => MemberModel(
          id: 0,
          crewId: 0,
          name: 'Unknown Member',
          image: '',
          userId: 0,
        ),
      );
      
      final entity = absence.toEntity();
      return Right(Absence.withMemberName(member.name, member.image, entity));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to get absence: ${e.toString()}'));
    }
  }

} 