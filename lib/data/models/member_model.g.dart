// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MemberModelImpl _$$MemberModelImplFromJson(Map<String, dynamic> json) =>
    _$MemberModelImpl(
      id: (json['id'] as num).toInt(),
      crewId: (json['crewId'] as num).toInt(),
      name: json['name'] as String,
      image: json['image'] as String,
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$$MemberModelImplToJson(_$MemberModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'crewId': instance.crewId,
      'name': instance.name,
      'image': instance.image,
      'userId': instance.userId,
    };
