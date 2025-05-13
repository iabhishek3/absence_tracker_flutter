import 'package:freezed_annotation/freezed_annotation.dart';

part 'absence.freezed.dart';

enum AbsenceType {
  @JsonValue('sickness')
  sickness,
  @JsonValue('vacation')
  vacation,
  @JsonValue('other')
  other
}

enum AbsenceStatus {
  @JsonValue('Requested')
  requested,
  @JsonValue('Confirmed')
  confirmed,
  @JsonValue('Rejected')
  rejected
}

@freezed
class Absence with _$Absence {
  const Absence._();

  const factory Absence({
    required String id,
    required String memberName,
    required String memberImage,
    required AbsenceType type,
    required DateTime startDate,
    required DateTime endDate,
    String? memberNote,
    required AbsenceStatus status,
    String? admitterNote,
    required String userId,
    String? admitterId,
    DateTime? confirmedAt,
    DateTime? rejectedAt,
    DateTime? createdAt,
  }) = _Absence;

  factory Absence.withMemberName(String memberName, String memberImage, Absence absence) => Absence(
    id: absence.id,
    memberName: memberName,
    memberImage: memberImage,
    type: absence.type,
    startDate: absence.startDate,
    endDate: absence.endDate,
    memberNote: absence.memberNote,
    status: absence.status,
    admitterNote: absence.admitterNote,
    userId: absence.userId,
    admitterId: absence.admitterId,
    confirmedAt: absence.confirmedAt,
    rejectedAt: absence.rejectedAt,
    createdAt: absence.createdAt,
  );

  List<Object?> get props => [
        id,
        memberName,
        type,
        startDate,
        endDate,
        memberNote,
        status,
        admitterNote,
        userId,
        admitterId,
        confirmedAt,
        rejectedAt,
        createdAt,
      ];

  String get formattedPeriod {
    final start = startDate.toString().split(' ')[0];
    final end = endDate.toString().split(' ')[0];
    return '$start to $end';
  }

  int get durationInDays {
    return endDate.difference(startDate).inDays + 1;
  }
} 