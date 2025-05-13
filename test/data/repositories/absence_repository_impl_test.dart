import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:absence_tracker_flutter/data/repositories/absence_repository_impl.dart';
import 'package:absence_tracker_flutter/data/datasources/absence_remote_data_source.dart';
import 'package:absence_tracker_flutter/data/models/absence_model.dart';
import 'package:absence_tracker_flutter/data/models/member_model.dart';
import 'package:absence_tracker_flutter/domain/entities/absence.dart';
import 'package:absence_tracker_flutter/core/error/failures.dart';

import 'absence_repository_impl_test.mocks.dart';

@GenerateMocks([AbsenceRemoteDataSource])
void main() {
  late AbsenceRepositoryImpl repository;
  late MockAbsenceRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockAbsenceRemoteDataSource();
    repository = AbsenceRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  final absenceModel = AbsenceModel(
    id: 1,
    crewId: 1,
    userId: 1,
    type: 'vacation',
    memberNote: 'note',
    admitterNote: 'approved',
    admitterId: 2,
    startDate: '2024-03-01',
    endDate: '2024-03-02',
    confirmedAt: '2024-02-28T10:00:00Z',
    rejectedAt: null,
    createdAt: '2024-02-27T15:00:00Z',
  );
  final memberModel = MemberModel(
    id: 1,
    crewId: 1,
    name: 'John Doe',
    image: 'https://example.com/avatar.jpg',
    userId: 1,
  );

  group('getAbsences', () {
    test('should return Right(List<Absence>) when successful', () async {
      // arrange
      when(mockRemoteDataSource.getAbsences())
          .thenAnswer((_) async => [absenceModel]);
      when(mockRemoteDataSource.getMembers())
          .thenAnswer((_) async => [memberModel]);

      // act
      final result = await repository.getAbsences();

      // assert
      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Should not be Left'),
        (absences) {
          expect(absences, isA<List<Absence>>());
          expect(absences.length, 1);
          expect(absences.first.memberName, 'John Doe');
          expect(absences.first.memberImage, 'https://example.com/avatar.jpg');
        },
      );
    });

    test('should return Left(ServerFailure) on exception', () async {
      // arrange
      when(mockRemoteDataSource.getAbsences()).thenThrow(Exception('error'));

      // act
      final result = await repository.getAbsences();

      // assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Should not be Right'),
      );
    });
  });

  group('getAbsenceById', () {
    test('should return Right(Absence) when successful', () async {
      // arrange
      when(mockRemoteDataSource.getAbsenceById('1'))
          .thenAnswer((_) async => absenceModel);
      when(mockRemoteDataSource.getMembers())
          .thenAnswer((_) async => [memberModel]);

      // act
      final result = await repository.getAbsenceById('1');

      // assert
      expect(result.isRight(), true);
      result.fold(
        (_) => fail('Should not be Left'),
        (absence) {
          expect(absence, isA<Absence>());
          expect(absence.memberName, 'John Doe');
          expect(absence.memberImage, 'https://example.com/avatar.jpg');
        },
      );
    });

    test('should return Left(ServerFailure) on exception', () async {
      // arrange
      when(mockRemoteDataSource.getAbsenceById('1')).thenThrow(Exception('error'));

      // act
      final result = await repository.getAbsenceById('1');

      // assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Should not be Right'),
      );
    });
  });
} 