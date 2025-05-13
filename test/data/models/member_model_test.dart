import 'package:flutter_test/flutter_test.dart';
import 'package:absence_tracker_flutter/data/models/member_model.dart';

void main() {
  final tMemberModel = MemberModel(
    id: 1,
    crewId: 1,
    name: 'John Doe',
    image: 'https://example.com/avatar.jpg',
    userId: 1,
  );

  final tMemberJson = {
    'id': 1,
    'crewId': 1,
    'name': 'John Doe',
    'image': 'https://example.com/avatar.jpg',
    'userId': 1,
  };

  group('fromJson', () {
    test('should return a valid model from JSON', () {
      // act
      final result = MemberModel.fromJson(tMemberJson);

      // assert
      expect(result, equals(tMemberModel));
      expect(result.id, 1);
      expect(result.crewId, 1);
      expect(result.name, 'John Doe');
      expect(result.image, 'https://example.com/avatar.jpg');
      expect(result.userId, 1);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () {
      // act
      final result = tMemberModel.toJson();

      // assert
      expect(result, equals(tMemberJson));
    });
  });

  group('copyWith', () {
    test('should return a new instance with updated values', () {
      // act
      final result = tMemberModel.copyWith(
        name: 'Jane Doe',
        image: 'https://example.com/new-avatar.jpg',
      );

      // assert
      expect(result.id, tMemberModel.id);
      expect(result.crewId, tMemberModel.crewId);
      expect(result.name, 'Jane Doe');
      expect(result.image, 'https://example.com/new-avatar.jpg');
      expect(result.userId, tMemberModel.userId);
    });

    test('should return the same instance when no parameters are provided', () {
      // act
      final result = tMemberModel.copyWith();

      // assert
      expect(result, equals(tMemberModel));
    });
  });
} 