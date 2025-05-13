import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:absence_tracker_flutter/domain/usecases/get_absences.dart';
import 'package:absence_tracker_flutter/domain/entities/absence.dart';
import 'package:absence_tracker_flutter/core/error/failures.dart';

import '../repositories/absence_repository_test.mocks.dart';

void main() {
  late GetAbsences usecase;
  late MockAbsenceRepository mockRepository;

  setUp(() {
    mockRepository = MockAbsenceRepository();
    usecase = GetAbsences(mockRepository);
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

  final List<Absence> tAbsences = [tAbsence];

  test('should get list of absences from the repository', () async {
    // arrange
    when(mockRepository.getAbsences())
        .thenAnswer((_) async => Right<Failure, List<Absence>>(tAbsences));

    // act
    final result = await usecase();

    // assert
    expect(result, Right<Failure, List<Absence>>(tAbsences));
    verify(mockRepository.getAbsences());
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return ServerFailure when repository call fails', () async {
    // arrange
    final failure = ServerFailure(message: 'Server error');
    when(mockRepository.getAbsences())
        .thenAnswer((_) async => Left<Failure, List<Absence>>(failure));

    // act
    final result = await usecase();

    // assert
    expect(result, Left<Failure, List<Absence>>(failure));
    verify(mockRepository.getAbsences());
    verifyNoMoreInteractions(mockRepository);
  });
} 