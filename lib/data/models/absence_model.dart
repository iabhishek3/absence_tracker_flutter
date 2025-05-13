import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/absence.dart';

part 'absence_model.freezed.dart';
part 'absence_model.g.dart';

@freezed
class AbsenceModel with _$AbsenceModel {
  const AbsenceModel._();

  const factory AbsenceModel({
    required int id,
    required int crewId,
    required int userId,
    required String type,
    String? memberNote,
    String? admitterNote,
    int? admitterId,
    required String startDate,
    required String endDate,
    String? confirmedAt,
    String? rejectedAt,
    String? createdAt,
  }) = _AbsenceModel;

  factory AbsenceModel.fromJson(Map<String, dynamic> json) =>
      _$AbsenceModelFromJson(json);

  factory AbsenceModel.fromEntity(Absence absence) => AbsenceModel(
        id: int.parse(absence.id),
        crewId: 0, // Not available in entity
        userId: int.parse(absence.userId),
        type: absence.type.toString().split('.').last,
        memberNote: absence.memberNote,
        admitterNote: absence.admitterNote,
        admitterId: absence.admitterId != null ? int.parse(absence.admitterId!) : null,
        startDate: absence.startDate.toIso8601String().split('T')[0],
        endDate: absence.endDate.toIso8601String().split('T')[0],
        confirmedAt: absence.confirmedAt?.toIso8601String(),
        rejectedAt: absence.rejectedAt?.toIso8601String(),
        createdAt: absence.createdAt?.toIso8601String(),
      );

  Absence toEntity() {
    final status = _determineStatus();
    final type = _determineType();
    
    return Absence(
      id: id.toString(),
      memberName: '', // Will be populated from members data
      memberImage: '', // Will be populated from members data
      type: type,
      startDate: DateTime.parse(startDate),
      endDate: DateTime.parse(endDate),
      memberNote: memberNote,
      status: status,
      admitterNote: admitterNote,
      userId: userId.toString(),
      admitterId: admitterId?.toString(),
      confirmedAt: confirmedAt != null ? DateTime.parse(confirmedAt!) : null,
      rejectedAt: rejectedAt != null ? DateTime.parse(rejectedAt!) : null,
      createdAt: createdAt != null ? DateTime.parse(createdAt!) : null,
    );
  }

  AbsenceType _determineType() {
    switch (type) {
      case 'sickness':
        return AbsenceType.sickness;
      case 'vacation':
        return AbsenceType.vacation;
      default:
        return AbsenceType.other;
    }
  }

  AbsenceStatus _determineStatus() {
    if (confirmedAt != null) {
      return AbsenceStatus.confirmed;
    } else if (rejectedAt != null) {
      return AbsenceStatus.rejected;
    } else {
      return AbsenceStatus.requested;
    }
  }
} 