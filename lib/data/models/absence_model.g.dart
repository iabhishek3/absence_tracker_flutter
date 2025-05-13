// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absence_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AbsenceModelImpl _$$AbsenceModelImplFromJson(Map<String, dynamic> json) =>
    _$AbsenceModelImpl(
      id: (json['id'] as num).toInt(),
      crewId: (json['crewId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      type: json['type'] as String,
      memberNote: json['memberNote'] as String?,
      admitterNote: json['admitterNote'] as String?,
      admitterId: (json['admitterId'] as num?)?.toInt(),
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      confirmedAt: json['confirmedAt'] as String?,
      rejectedAt: json['rejectedAt'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$$AbsenceModelImplToJson(_$AbsenceModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'crewId': instance.crewId,
      'userId': instance.userId,
      'type': instance.type,
      'memberNote': instance.memberNote,
      'admitterNote': instance.admitterNote,
      'admitterId': instance.admitterId,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'confirmedAt': instance.confirmedAt,
      'rejectedAt': instance.rejectedAt,
      'createdAt': instance.createdAt,
    };
