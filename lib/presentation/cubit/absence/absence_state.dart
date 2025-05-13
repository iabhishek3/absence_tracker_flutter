import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show DateTimeRange;
import '../../../domain/entities/absence.dart';

abstract class AbsenceState extends Equatable {
  const AbsenceState();

  @override
  List<Object?> get props => [];
}

class AbsenceInitial extends AbsenceState {
  const AbsenceInitial();
}

class AbsenceLoading extends AbsenceState {
  const AbsenceLoading();
}

class AbsenceLoaded extends AbsenceState {
  final List<Absence> absences;
  final int totalCount;
  final int currentPage;
  final bool hasMore;
  final AbsenceType? selectedType;
  final DateTimeRange? selectedDateRange;
  final bool isLoading;
  final AbsenceStatus? selectedStatus;

  const AbsenceLoaded({
    required this.absences,
    required this.totalCount,
    required this.currentPage,
    required this.hasMore,
    this.selectedType,
    this.selectedDateRange,
    this.isLoading = false,
    this.selectedStatus,
  });

  @override
  List<Object?> get props => [
        absences,
        totalCount,
        currentPage,
        hasMore,
        selectedType,
        selectedDateRange,
        isLoading,
        selectedStatus,
      ];

  AbsenceLoaded copyWith({
    List<Absence>? absences,
    int? totalCount,
    int? currentPage,
    bool? hasMore,
    AbsenceType? selectedType,
    DateTimeRange? selectedDateRange,
    bool? isLoading,
    AbsenceStatus? selectedStatus,
  }) {
    return AbsenceLoaded(
      absences: absences ?? this.absences,
      totalCount: totalCount ?? this.totalCount,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      selectedType: selectedType ?? this.selectedType,
      selectedDateRange: selectedDateRange ?? this.selectedDateRange,
      isLoading: isLoading ?? this.isLoading,
      selectedStatus: selectedStatus ?? this.selectedStatus,
    );
  }
}

class AbsenceError extends AbsenceState {
  final String message;

  const AbsenceError(this.message);

  @override
  List<Object?> get props => [message];
}

class AbsenceEmpty extends AbsenceState {
  final String message;

  const AbsenceEmpty({this.message = 'No absences found'});

  @override
  List<Object?> get props => [message];
} 