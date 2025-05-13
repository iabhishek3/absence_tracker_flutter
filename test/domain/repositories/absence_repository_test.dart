import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:absence_tracker_flutter/domain/repositories/absence_repository.dart';
import 'package:absence_tracker_flutter/domain/entities/absence.dart';
import 'package:absence_tracker_flutter/core/error/failures.dart';

import 'absence_repository_test.mocks.dart';

@GenerateMocks([AbsenceRepository])
void main() {
  late MockAbsenceRepository repository;

  setUp(() {
    repository = MockAbsenceRepository();
  });

  final tAbsence = Absence(
    id: '1',
    memberName: 'John Doe',
    memberImage: 'https://example.com/avatar.jpg',
    type: AbsenceType.vacation,
    startDate: DateTime.parse('2024-03-01'),
    endDate: DateTime.parse('2024-03-02'),
    memberNote: 'Taking a break',
    status: AbsenceStatus.confirmed,
    admitterNote: 'Approved',
    userId: '1',
    admitterId: '2',
    confirmedAt: DateTime.parse('2024-02-28T10:00:00.000Z'),
    rejectedAt: null,
    createdAt: DateTime.parse('2024-02-27T15:00:00.000Z'),
  );

  group('getAbsences', () {
    final List<Absence> tAbsences = [tAbsence];
    
    test('should return list of absences when successful', () async {
      // arrange
      when(repository.getAbsences())
          .thenAnswer((_) async => Right<Failure, List<Absence>>(tAbsences));

      // act
      final result = await repository.getAbsences();

      // assert
      expect(result, Right<Failure, List<Absence>>(tAbsences));
      verify(repository.getAbsences());
      verifyNoMoreInteractions(repository);
    });

    test('should return ServerFailure when unsuccessful', () async {
      // arrange
      final failure = ServerFailure(message: 'Server error');
      when(repository.getAbsences())
          .thenAnswer((_) async => Left<Failure, List<Absence>>(failure));

      // act
      final result = await repository.getAbsences();

      // assert
      expect(result, Left<Failure, List<Absence>>(failure));
      verify(repository.getAbsences());
      verifyNoMoreInteractions(repository);
    });
  });

  group('getAbsenceById', () {
    const tId = '1';

    test('should return single absence when successful', () async {
      // arrange
      when(repository.getAbsenceById(any))
          .thenAnswer((_) async => Right<Failure, Absence>(tAbsence));

      // act
      final result = await repository.getAbsenceById(tId);

      // assert
      expect(result, Right<Failure, Absence>(tAbsence));
      verify(repository.getAbsenceById(tId));
      verifyNoMoreInteractions(repository);
    });

    test('should return ServerFailure when unsuccessful', () async {
      // arrange
      final failure = ServerFailure(message: 'Server error');
      when(repository.getAbsenceById(any))
          .thenAnswer((_) async => Left<Failure, Absence>(failure));

      // act
      final result = await repository.getAbsenceById(tId);

      // assert
      expect(result, Left<Failure, Absence>(failure));
      verify(repository.getAbsenceById(tId));
      verifyNoMoreInteractions(repository);
    });

    test('should return ServerFailure when id is invalid', () async {
      // arrange
      final failure = ServerFailure(message: 'Invalid ID');
      when(repository.getAbsenceById(any))
          .thenAnswer((_) async => Left<Failure, Absence>(failure));

      // act
      final result = await repository.getAbsenceById('invalid_id');

      // assert
      expect(result, Left<Failure, Absence>(failure));
      verify(repository.getAbsenceById('invalid_id'));
      verifyNoMoreInteractions(repository);
    });
  });
} 