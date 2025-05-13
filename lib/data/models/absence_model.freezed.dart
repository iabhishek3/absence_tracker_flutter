// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'absence_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AbsenceModel _$AbsenceModelFromJson(Map<String, dynamic> json) {
  return _AbsenceModel.fromJson(json);
}

/// @nodoc
mixin _$AbsenceModel {
  int get id => throw _privateConstructorUsedError;
  int get crewId => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get memberNote => throw _privateConstructorUsedError;
  String? get admitterNote => throw _privateConstructorUsedError;
  int? get admitterId => throw _privateConstructorUsedError;
  String get startDate => throw _privateConstructorUsedError;
  String get endDate => throw _privateConstructorUsedError;
  String? get confirmedAt => throw _privateConstructorUsedError;
  String? get rejectedAt => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this AbsenceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AbsenceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AbsenceModelCopyWith<AbsenceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AbsenceModelCopyWith<$Res> {
  factory $AbsenceModelCopyWith(
          AbsenceModel value, $Res Function(AbsenceModel) then) =
      _$AbsenceModelCopyWithImpl<$Res, AbsenceModel>;
  @useResult
  $Res call(
      {int id,
      int crewId,
      int userId,
      String type,
      String? memberNote,
      String? admitterNote,
      int? admitterId,
      String startDate,
      String endDate,
      String? confirmedAt,
      String? rejectedAt,
      String? createdAt});
}

/// @nodoc
class _$AbsenceModelCopyWithImpl<$Res, $Val extends AbsenceModel>
    implements $AbsenceModelCopyWith<$Res> {
  _$AbsenceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AbsenceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? crewId = null,
    Object? userId = null,
    Object? type = null,
    Object? memberNote = freezed,
    Object? admitterNote = freezed,
    Object? admitterId = freezed,
    Object? startDate = null,
    Object? endDate = null,
    Object? confirmedAt = freezed,
    Object? rejectedAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      crewId: null == crewId
          ? _value.crewId
          : crewId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      memberNote: freezed == memberNote
          ? _value.memberNote
          : memberNote // ignore: cast_nullable_to_non_nullable
              as String?,
      admitterNote: freezed == admitterNote
          ? _value.admitterNote
          : admitterNote // ignore: cast_nullable_to_non_nullable
              as String?,
      admitterId: freezed == admitterId
          ? _value.admitterId
          : admitterId // ignore: cast_nullable_to_non_nullable
              as int?,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      confirmedAt: freezed == confirmedAt
          ? _value.confirmedAt
          : confirmedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectedAt: freezed == rejectedAt
          ? _value.rejectedAt
          : rejectedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AbsenceModelImplCopyWith<$Res>
    implements $AbsenceModelCopyWith<$Res> {
  factory _$$AbsenceModelImplCopyWith(
          _$AbsenceModelImpl value, $Res Function(_$AbsenceModelImpl) then) =
      __$$AbsenceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int crewId,
      int userId,
      String type,
      String? memberNote,
      String? admitterNote,
      int? admitterId,
      String startDate,
      String endDate,
      String? confirmedAt,
      String? rejectedAt,
      String? createdAt});
}

/// @nodoc
class __$$AbsenceModelImplCopyWithImpl<$Res>
    extends _$AbsenceModelCopyWithImpl<$Res, _$AbsenceModelImpl>
    implements _$$AbsenceModelImplCopyWith<$Res> {
  __$$AbsenceModelImplCopyWithImpl(
      _$AbsenceModelImpl _value, $Res Function(_$AbsenceModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AbsenceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? crewId = null,
    Object? userId = null,
    Object? type = null,
    Object? memberNote = freezed,
    Object? admitterNote = freezed,
    Object? admitterId = freezed,
    Object? startDate = null,
    Object? endDate = null,
    Object? confirmedAt = freezed,
    Object? rejectedAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$AbsenceModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      crewId: null == crewId
          ? _value.crewId
          : crewId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      memberNote: freezed == memberNote
          ? _value.memberNote
          : memberNote // ignore: cast_nullable_to_non_nullable
              as String?,
      admitterNote: freezed == admitterNote
          ? _value.admitterNote
          : admitterNote // ignore: cast_nullable_to_non_nullable
              as String?,
      admitterId: freezed == admitterId
          ? _value.admitterId
          : admitterId // ignore: cast_nullable_to_non_nullable
              as int?,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String,
      confirmedAt: freezed == confirmedAt
          ? _value.confirmedAt
          : confirmedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectedAt: freezed == rejectedAt
          ? _value.rejectedAt
          : rejectedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AbsenceModelImpl extends _AbsenceModel {
  const _$AbsenceModelImpl(
      {required this.id,
      required this.crewId,
      required this.userId,
      required this.type,
      this.memberNote,
      this.admitterNote,
      this.admitterId,
      required this.startDate,
      required this.endDate,
      this.confirmedAt,
      this.rejectedAt,
      this.createdAt})
      : super._();

  factory _$AbsenceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AbsenceModelImplFromJson(json);

  @override
  final int id;
  @override
  final int crewId;
  @override
  final int userId;
  @override
  final String type;
  @override
  final String? memberNote;
  @override
  final String? admitterNote;
  @override
  final int? admitterId;
  @override
  final String startDate;
  @override
  final String endDate;
  @override
  final String? confirmedAt;
  @override
  final String? rejectedAt;
  @override
  final String? createdAt;

  @override
  String toString() {
    return 'AbsenceModel(id: $id, crewId: $crewId, userId: $userId, type: $type, memberNote: $memberNote, admitterNote: $admitterNote, admitterId: $admitterId, startDate: $startDate, endDate: $endDate, confirmedAt: $confirmedAt, rejectedAt: $rejectedAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AbsenceModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.crewId, crewId) || other.crewId == crewId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.memberNote, memberNote) ||
                other.memberNote == memberNote) &&
            (identical(other.admitterNote, admitterNote) ||
                other.admitterNote == admitterNote) &&
            (identical(other.admitterId, admitterId) ||
                other.admitterId == admitterId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.confirmedAt, confirmedAt) ||
                other.confirmedAt == confirmedAt) &&
            (identical(other.rejectedAt, rejectedAt) ||
                other.rejectedAt == rejectedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      crewId,
      userId,
      type,
      memberNote,
      admitterNote,
      admitterId,
      startDate,
      endDate,
      confirmedAt,
      rejectedAt,
      createdAt);

  /// Create a copy of AbsenceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AbsenceModelImplCopyWith<_$AbsenceModelImpl> get copyWith =>
      __$$AbsenceModelImplCopyWithImpl<_$AbsenceModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AbsenceModelImplToJson(
      this,
    );
  }
}

abstract class _AbsenceModel extends AbsenceModel {
  const factory _AbsenceModel(
      {required final int id,
      required final int crewId,
      required final int userId,
      required final String type,
      final String? memberNote,
      final String? admitterNote,
      final int? admitterId,
      required final String startDate,
      required final String endDate,
      final String? confirmedAt,
      final String? rejectedAt,
      final String? createdAt}) = _$AbsenceModelImpl;
  const _AbsenceModel._() : super._();

  factory _AbsenceModel.fromJson(Map<String, dynamic> json) =
      _$AbsenceModelImpl.fromJson;

  @override
  int get id;
  @override
  int get crewId;
  @override
  int get userId;
  @override
  String get type;
  @override
  String? get memberNote;
  @override
  String? get admitterNote;
  @override
  int? get admitterId;
  @override
  String get startDate;
  @override
  String get endDate;
  @override
  String? get confirmedAt;
  @override
  String? get rejectedAt;
  @override
  String? get createdAt;

  /// Create a copy of AbsenceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AbsenceModelImplCopyWith<_$AbsenceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
