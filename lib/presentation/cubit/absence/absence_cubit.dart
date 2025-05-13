import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/entities/absence.dart';
import '../../../domain/usecases/get_absences.dart';
import 'absence_state.dart';

@injectable
class AbsenceCubit extends Cubit<AbsenceState> {
  final GetAbsences getAbsences;
  // Store the full list and filter state
  List<Absence> _allAbsences = [];
  AbsenceType? _selectedType;
  DateTimeRange? _selectedDateRange;
  // Pagination state
  static const int _initialPageSize = 10;
  int _pageSize = _initialPageSize;
  int _currentPage = 1;
  bool _isLoadingMore = false;

  AbsenceCubit(this.getAbsences) : super(const AbsenceInitial());

  List<Absence> get allAbsences => _allAbsences;

  Future<void> getAbsencesList() async {
    if (_isLoadingMore) return;
    
    if (_currentPage == 1) {
      emit(const AbsenceLoading());
    } else {
      _isLoadingMore = true;
      if (state is AbsenceLoaded) {
        emit((state as AbsenceLoaded).copyWith(isLoading: true));
      }
    }

    try {
      final result = await getAbsences.call();
      result.fold(
        (failure) => emit(AbsenceError(failure.message)),
        (absences) {
          // Always update the full list when loading from the beginning
          if (_currentPage == 1) {
            _allAbsences = absences;
          }
          
          if (_allAbsences.isEmpty && _currentPage == 1) {
            emit(const AbsenceEmpty());
          } else {
            _applyFiltersAndEmit();
          }
        },
      );
    } catch (e) {
      emit(AbsenceError(e.toString()));
    } finally {
      _isLoadingMore = false;
    }
  }

  void _applyFiltersAndEmit() {
    var filtered = _allAbsences;
    if (_selectedType != null) {
      filtered = filtered.where((a) => a.type == _selectedType).toList();
    }
    if (_selectedDateRange != null) {
      filtered = filtered.where((a) {
        return a.startDate.isAfter(_selectedDateRange!.start.subtract(const Duration(days: 1))) &&
               a.endDate.isBefore(_selectedDateRange!.end.add(const Duration(days: 1)));
      }).toList();
    }

    if (filtered.isEmpty && _currentPage == 1) {
      emit(const AbsenceEmpty());
    } else {
      // Calculate the start and end indices for the current page
      final start = (_currentPage - 1) * _pageSize;
      
      // Get the items for the current page
      final paginatedAbsences = filtered.skip(start).take(_pageSize).toList();
      
      // Calculate if there are more pages
      final hasMore = filtered.length > start + _pageSize;
      
      emit(AbsenceLoaded(
        absences: paginatedAbsences,
        totalCount: filtered.length,
        currentPage: _currentPage,
        hasMore: hasMore,
        selectedType: _selectedType,
        selectedDateRange: _selectedDateRange,
        isLoading: _isLoadingMore,
      ));
    }
  }

  void filterByType(AbsenceType? type) {
    if (state is AbsenceLoaded) {
      final currentState = state as AbsenceLoaded;
      final filteredAbsences = type == null
          ? _allAbsences
          : _allAbsences.where((a) => a.type == type).toList();
      
      emit(AbsenceLoaded(
        absences: _getPaginatedAbsences(filteredAbsences),
        totalCount: filteredAbsences.length,
        currentPage: _currentPage,
        hasMore: _currentPage * _pageSize < filteredAbsences.length,
        selectedType: type,
        selectedDateRange: currentState.selectedDateRange,
      ));
    }
  }

  void filterByDateRange(DateTimeRange? range) {
    if (state is AbsenceLoaded) {
      final currentState = state as AbsenceLoaded;
      final filteredAbsences = range == null
          ? _allAbsences
          : _allAbsences.where((a) =>
              a.startDate.isAfter(range.start) &&
              a.endDate.isBefore(range.end)).toList();
      
      emit(AbsenceLoaded(
        absences: _getPaginatedAbsences(filteredAbsences),
        totalCount: filteredAbsences.length,
        currentPage: _currentPage,
        hasMore: _currentPage * _pageSize < filteredAbsences.length,
        selectedType: currentState.selectedType,
        selectedDateRange: range,
      ));
    }
  }

  void filterByStatus(AbsenceStatus? status) {
    if (state is AbsenceLoaded) {
      final currentState = state as AbsenceLoaded;
      final filteredAbsences = status == null
          ? _allAbsences
          : _allAbsences.where((a) => a.status == status).toList();
      
      emit(AbsenceLoaded(
        absences: _getPaginatedAbsences(filteredAbsences),
        totalCount: filteredAbsences.length,
        currentPage: _currentPage,
        hasMore: _currentPage * _pageSize < filteredAbsences.length,
        selectedType: currentState.selectedType,
        selectedDateRange: currentState.selectedDateRange,
        selectedStatus: status,
      ));
    }
  }

  Future<void> refreshList() async {
    await getAbsencesList();
  }

  List<Absence> _getPaginatedAbsences([List<Absence>? absences]) {
    final list = absences ?? _allAbsences;
    final start = (_currentPage - 1) * _pageSize;
    return list.skip(start).take(_pageSize).toList();
  }

  String generateICalData() {
    if (state is! AbsenceLoaded) return '';

    final absences = (state as AbsenceLoaded).absences;
    final buffer = StringBuffer();
    
    buffer.writeln('BEGIN:VCALENDAR');
    buffer.writeln('VERSION:2.0');
    buffer.writeln('PRODID:-//Absence Tracker//EN');
    
    for (final absence in absences) {
      buffer.writeln('BEGIN:VEVENT');
      buffer.writeln('SUMMARY:${absence.type.name} - ${absence.memberName}');
      buffer.writeln('DTSTART:${absence.startDate.toUtc().toString().replaceAll('-', '').replaceAll(':', '').split('.')[0]}Z');
      buffer.writeln('DTEND:${absence.endDate.toUtc().toString().replaceAll('-', '').replaceAll(':', '').split('.')[0]}Z');
      if (absence.memberNote != null) {
        buffer.writeln('DESCRIPTION:${absence.memberNote}');
      }
      buffer.writeln('STATUS:${absence.status.name}');
      buffer.writeln('END:VEVENT');
    }
    
    buffer.writeln('END:VCALENDAR');
    return buffer.toString();
  }



  // New method to update page size (and reset current page)
  void setPageSize(int size) {
    if (state is AbsenceLoaded) {
      _pageSize = size;
      _currentPage = 1;
      emit(AbsenceLoaded(
        absences: _getPaginatedAbsences(),
        totalCount: _allAbsences.length,
        currentPage: _currentPage,
        hasMore: _currentPage * _pageSize < _allAbsences.length,
        selectedType: (state as AbsenceLoaded).selectedType,
        selectedDateRange: (state as AbsenceLoaded).selectedDateRange,
      ));
    }
  }

  // New method to go to next page (if available)
  void nextPage() {
    if (state is AbsenceLoaded) {
      final currentState = state as AbsenceLoaded;
      if (currentState.hasMore) {
        _currentPage++;
        _applyFiltersAndEmit();
      }
    }
  }

  // New method to go to previous page (if not on first page)
  void prevPage() {
    if (state is AbsenceLoaded && _currentPage > 1) {
      _currentPage--;
      _applyFiltersAndEmit();
    }
  }
} 