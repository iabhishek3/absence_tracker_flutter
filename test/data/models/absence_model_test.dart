import 'package:flutter_test/flutter_test.dart';
import 'package:absence_tracker_flutter/data/models/absence_model.dart';
import 'package:absence_tracker_flutter/domain/entities/absence.dart';

void main() {
  final tAbsenceModel = AbsenceModel(
    id: 1,
    crewId: 1,
    userId: 1,
    type: 'vacation',
    memberNote: 'Taking a break',
    admitterNote: 'Approved',
    admitterId: 2,
    startDate: '2024-03-01',
    endDate: '2024-03-02',
    confirmedAt: '2024-02-28T10:00:00.000Z',
    rejectedAt: null,
    createdAt: '2024-02-27T15:00:00.000Z',
  );

  final tAbsenceJson = {
    'id': 1,
    'crewId': 1,
    'userId': 1,
    'type': 'vacation',
    'memberNote': 'Taking a break',
    'admitterNote': 'Approved',
    'admitterId': 2,
    'startDate': '2024-03-01',
    'endDate': '2024-03-02',
    'confirmedAt': '2024-02-28T10:00:00.000Z',
    'rejectedAt': null,
    'createdAt': '2024-02-27T15:00:00.000Z',
  };

  group('fromJson', () {
    test('should return a valid model from JSON', () {
      // act
      final result = AbsenceModel.fromJson(tAbsenceJson);

      // assert
      expect(result, equals(tAbsenceModel));
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () {
      // act
      final result = tAbsenceModel.toJson();

      // assert
      expect(result, equals(tAbsenceJson));
    });
  });

  group('toEntity', () {
    test('should convert AbsenceModel to Absence entity with vacation type', () {
      // act
      final result = tAbsenceModel.toEntity();

      // assert
      expect(result, isA<Absence>());
      expect(result.id, '1');
      expect(result.userId, '1');
      expect(result.type, AbsenceType.vacation);
      expect(result.status, AbsenceStatus.confirmed);
      expect(result.startDate, DateTime.parse('2024-03-01'));
      expect(result.endDate, DateTime.parse('2024-03-02'));
      expect(result.memberNote, 'Taking a break');
      expect(result.admitterNote, 'Approved');
      expect(result.admitterId, '2');
      expect(result.confirmedAt, DateTime.parse('2024-02-28T10:00:00.000Z'));
      expect(result.rejectedAt, null);
      expect(result.createdAt, DateTime.parse('2024-02-27T15:00:00.000Z'));
    });

    test('should convert AbsenceModel to Absence entity with sickness type', () {
      // arrange
      final sickAbsenceModel = tAbsenceModel.copyWith(type: 'sickness');

      // act
      final result = sickAbsenceModel.toEntity();

      // assert
      expect(result.type, AbsenceType.sickness);
    });

    test('should convert AbsenceModel to Absence entity with other type', () {
      // arrange
      final otherAbsenceModel = tAbsenceModel.copyWith(type: 'unknown');

      // act
      final result = otherAbsenceModel.toEntity();

      // assert
      expect(result.type, AbsenceType.other);
    });

    test('should set correct status when absence is confirmed', () {
      // act
      final result = tAbsenceModel.toEntity();

      // assert
      expect(result.status, AbsenceStatus.confirmed);
    });

    test('should set correct status when absence is rejected', () {
      // arrange
      final rejectedAbsence = tAbsenceModel.copyWith(
        confirmedAt: null,
        rejectedAt: '2024-02-28T10:00:00.000Z',
      );

      // act
      final result = rejectedAbsence.toEntity();

      // assert
      expect(result.status, AbsenceStatus.rejected);
    });

    test('should set correct status when absence is requested', () {
      // arrange
      final requestedAbsence = tAbsenceModel.copyWith(
        confirmedAt: null,
        rejectedAt: null,
      );

      // act
      final result = requestedAbsence.toEntity();

      // assert
      expect(result.status, AbsenceStatus.requested);
    });
  });

  group('fromEntity', () {
    test('should convert Absence entity to AbsenceModel', () {
      // arrange
      final entity = Absence(
        id: '1',
        memberName: 'John Doe',
        memberImage: 'image.jpg',
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

      // act
      final result = AbsenceModel.fromEntity(entity);

      // assert
      expect(result.id, 1);
      expect(result.userId, 1);
      expect(result.type, 'vacation');
      expect(result.startDate, '2024-03-01');
      expect(result.endDate, '2024-03-02');
      expect(result.memberNote, 'Taking a break');
      expect(result.admitterNote, 'Approved');
      expect(result.admitterId, 2);
      expect(result.confirmedAt, '2024-02-28T10:00:00.000Z');
      expect(result.rejectedAt, null);
      expect(result.createdAt, '2024-02-27T15:00:00.000Z');
    });
  });
} 