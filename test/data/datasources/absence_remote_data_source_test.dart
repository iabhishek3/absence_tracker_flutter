import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:absence_tracker_flutter/data/datasources/absence_remote_data_source.dart';
import 'package:absence_tracker_flutter/data/models/absence_model.dart';
import 'package:absence_tracker_flutter/data/models/member_model.dart';

@GenerateMocks([AbsenceRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  late AbsenceRemoteDataSourceImpl dataSource;

  setUp(() {
    dataSource = AbsenceRemoteDataSourceImpl();
  });

  group('getAbsences', () {
    test('should return list of absences from json file', () async {
      // arrange
      const jsonString = '''
      {
        "payload": [
          {
            "id": 1,
            "crewId": 1,
            "userId": 1,
            "type": "vacation",
            "startDate": "2024-03-01",
            "endDate": "2024-03-02",
            "memberNote": "Taking a short break",
            "admitterNote": "Approved",
            "admitterId": 2,
            "confirmedAt": "2024-02-28T10:00:00Z",
            "rejectedAt": null,
            "createdAt": "2024-02-27T15:00:00Z"
          }
        ]
      }
      ''';
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('flutter/assets', (message) async {
        return ByteData.view(Uint8List.fromList(utf8.encode(jsonString)).buffer);
      });

      // act
      final result = await dataSource.getAbsences();

      // assert
      expect(result, isA<List<AbsenceModel>>());
      expect(result.length, 1);
      expect(result.first.id, 1);
      expect(result.first.userId, 1);
      expect(result.first.type, "vacation");
      expect(result.first.memberNote, "Taking a short break");
      expect(result.first.admitterNote, "Approved");
      expect(result.first.admitterId, 2);
      expect(result.first.startDate, "2024-03-01");
      expect(result.first.endDate, "2024-03-02");
      expect(result.first.confirmedAt, "2024-02-28T10:00:00Z");
      expect(result.first.rejectedAt, null);
      expect(result.first.createdAt, "2024-02-27T15:00:00Z");
    });
  });

  group('getAbsenceById', () {
    test('should return specific absence by id', () async {
      // arrange
      const jsonString = '''
      {
        "payload": [
          {
            "id": 1,
            "crewId": 1,
            "userId": 1,
            "type": "vacation",
            "startDate": "2024-03-01",
            "endDate": "2024-03-02",
            "memberNote": "Taking a short break",
            "admitterNote": "Approved",
            "admitterId": 2,
            "confirmedAt": "2024-02-28T10:00:00Z",
            "rejectedAt": null,
            "createdAt": "2024-02-27T15:00:00Z"
          }
        ]
      }
      ''';
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('flutter/assets', (message) async {
        return ByteData.view(Uint8List.fromList(utf8.encode(jsonString)).buffer);
      });

      // act
      final result = await dataSource.getAbsenceById("1");

      // assert
      expect(result, isA<AbsenceModel>());
      expect(result.id, 1);
      expect(result.userId, 1);
      expect(result.type, "vacation");
      expect(result.memberNote, "Taking a short break");
      expect(result.admitterNote, "Approved");
      expect(result.admitterId, 2);
      expect(result.startDate, "2024-03-01");
      expect(result.endDate, "2024-03-02");
      expect(result.confirmedAt, "2024-02-28T10:00:00Z");
      expect(result.rejectedAt, null);
      expect(result.createdAt, "2024-02-27T15:00:00Z");
    });

    test('should throw exception when absence not found', () async {
      // arrange
      const jsonString = '''
      {
        "payload": []
      }
      ''';
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('flutter/assets', (message) async {
        return ByteData.view(Uint8List.fromList(utf8.encode(jsonString)).buffer);
      });

      // act & assert
      expect(() => dataSource.getAbsenceById("999"),
          throwsA(isA<StateError>()));
    });
  });

  group('getMembers', () {
    test('should return list of members from json file', () async {
      // arrange
      const jsonString = '''
      {
        "payload": [
          {
            "id": 1,
            "crewId": 1,
            "name": "John Doe",
            "image": "https://example.com/avatar.jpg",
            "userId": 1
          }
        ]
      }
      ''';
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMessageHandler('flutter/assets', (message) async {
        return ByteData.view(Uint8List.fromList(utf8.encode(jsonString)).buffer);
      });

      // act
      final result = await dataSource.getMembers();

      // assert
      expect(result, isA<List<MemberModel>>());
      expect(result.length, 1);
      expect(result.first.id, 1);
      expect(result.first.crewId, 1);
      expect(result.first.name, "John Doe");
      expect(result.first.image, "https://example.com/avatar.jpg");
      expect(result.first.userId, 1);
    });
  });
} 