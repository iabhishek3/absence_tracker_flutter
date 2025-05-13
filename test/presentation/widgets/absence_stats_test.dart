import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:absence_tracker_flutter/presentation/widgets/absence_stats.dart';
import 'package:absence_tracker_flutter/presentation/cubit/absence/absence_cubit.dart';
import 'package:absence_tracker_flutter/presentation/cubit/absence/absence_state.dart';
import 'package:absence_tracker_flutter/domain/entities/absence.dart';

import 'absence_stats_test.mocks.dart';

@GenerateMocks([AbsenceCubit])
void main() {
  late MockAbsenceCubit mockCubit;

  setUp(() {
    mockCubit = MockAbsenceCubit();
    // Mock the stream
    when(mockCubit.stream).thenAnswer((_) => Stream.fromIterable([AbsenceInitial()]));
  });

  final tAbsences = [
    Absence(
      id: '1',
      memberName: 'John Doe',
      memberImage: 'https://example.com/avatar.jpg',
      type: AbsenceType.vacation,
      startDate: DateTime.parse('2024-03-01'),
      endDate: DateTime.parse('2024-03-02'),
      memberNote: 'Vacation',
      status: AbsenceStatus.confirmed,
      admitterNote: 'Approved',
      userId: '1',
      admitterId: '2',
      confirmedAt: DateTime.parse('2024-02-28T10:00:00.000Z'),
      rejectedAt: null,
      createdAt: DateTime.parse('2024-02-27T15:00:00.000Z'),
    ),
    Absence(
      id: '2',
      memberName: 'Jane Doe',
      memberImage: 'https://example.com/avatar2.jpg',
      type: AbsenceType.sickness,
      startDate: DateTime.parse('2024-03-03'),
      endDate: DateTime.parse('2024-03-04'),
      memberNote: 'Sick leave',
      status: AbsenceStatus.requested,
      admitterNote: null,
      userId: '2',
      admitterId: null,
      confirmedAt: null,
      rejectedAt: null,
      createdAt: DateTime.parse('2024-03-02T10:00:00.000Z'),
    ),
  ];

  Widget buildTestWidget() {
    return MaterialApp(
      home: BlocProvider<AbsenceCubit>(
        create: (context) => mockCubit,
        child: const Scaffold(
          body: AbsenceStats(),
        ),
      ),
    );
  }

  group('AbsenceStats', () {
    testWidgets('should call getAbsencesList on init', (tester) async {
      // arrange
      when(mockCubit.state).thenReturn(AbsenceInitial());
      when(mockCubit.allAbsences).thenReturn([]);

      // act
      await tester.pumpWidget(buildTestWidget());

      // assert
      verify(mockCubit.getAbsencesList()).called(1);
    });

    testWidgets('should show nothing when state is not AbsenceLoaded', (tester) async {
      // arrange
      when(mockCubit.state).thenReturn(AbsenceInitial());
      when(mockCubit.allAbsences).thenReturn([]);

      // act
      await tester.pumpWidget(buildTestWidget());

      // assert
      expect(find.byType(Card), findsNothing);
    });

    testWidgets('should show stats when state is AbsenceLoaded', (tester) async {
      // arrange
      when(mockCubit.state).thenReturn(AbsenceLoaded(
        absences: tAbsences,
        totalCount: tAbsences.length,
        currentPage: 1,
        hasMore: false,
      ));
      when(mockCubit.allAbsences).thenReturn(tAbsences);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(AbsenceLoaded(
        absences: tAbsences,
        totalCount: tAbsences.length,
        currentPage: 1,
        hasMore: false,
      )));

      // act
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      // assert
      expect(find.byType(Card), findsOneWidget);
      expect(find.text('Total Absences'), findsOneWidget);
      expect(find.text('2'), findsOneWidget); // Total absences count
      expect(find.text('Total Days: 4'), findsOneWidget); // 2 absences * 2 days each

      // Type stats
      expect(find.text('Vacation'), findsOneWidget);
      expect(find.text('Sickness'), findsOneWidget);

      // Status stats
      expect(find.text('Requested'), findsOneWidget);
      expect(find.text('Confirmed'), findsOneWidget);
      expect(find.text('Rejected'), findsOneWidget);
    });

    testWidgets('should show correct type counts', (tester) async {
      // arrange
      when(mockCubit.state).thenReturn(AbsenceLoaded(
        absences: tAbsences,
        totalCount: tAbsences.length,
        currentPage: 1,
        hasMore: false,
      ));
      when(mockCubit.allAbsences).thenReturn(tAbsences);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(AbsenceLoaded(
        absences: tAbsences,
        totalCount: tAbsences.length,
        currentPage: 1,
        hasMore: false,
      )));

      // act
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      // assert
      expect(find.textContaining('1'), findsNWidgets(4)); // 1 vacation, 1 sickness, 1 confirmed, 1 requested
    });

    testWidgets('should show correct status counts', (tester) async {
      // arrange
      when(mockCubit.state).thenReturn(AbsenceLoaded(
        absences: tAbsences,
        totalCount: tAbsences.length,
        currentPage: 1,
        hasMore: false,
      ));
      when(mockCubit.allAbsences).thenReturn(tAbsences);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(AbsenceLoaded(
        absences: tAbsences,
        totalCount: tAbsences.length,
        currentPage: 1,
        hasMore: false,
      )));

      // act
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      // assert
      expect(find.text('1'), findsNWidgets(4)); // 1 confirmed, 1 requested
      expect(find.text('0'), findsOneWidget); // 0 rejected
    });

    testWidgets('should handle empty absences list', (tester) async {
      // arrange
      when(mockCubit.state).thenReturn(AbsenceLoaded(
        absences: [],
        totalCount: 0,
        currentPage: 1,
        hasMore: false,
      ));
      when(mockCubit.allAbsences).thenReturn([]);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(AbsenceLoaded(
        absences: [],
        totalCount: 0,
        currentPage: 1,
        hasMore: false,
      )));

      // act
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      // assert
      expect(find.text('0'), findsNWidgets(4)); // Total absences, Requested, Confirmed, Rejected
      expect(find.text('Total Days: 0'), findsOneWidget);
    });

    testWidgets('should scroll horizontally', (tester) async {
      // arrange
      when(mockCubit.state).thenReturn(AbsenceLoaded(
        absences: tAbsences,
        totalCount: tAbsences.length,
        currentPage: 1,
        hasMore: false,
      ));
      when(mockCubit.allAbsences).thenReturn(tAbsences);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(AbsenceLoaded(
        absences: tAbsences,
        totalCount: tAbsences.length,
        currentPage: 1,
        hasMore: false,
      )));

      // act
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      // Find the SingleChildScrollView
      final scrollView = find.byType(SingleChildScrollView);
      expect(scrollView, findsOneWidget);

      // Get the initial position of a widget that should be scrolled
      final initialRect = tester.getRect(find.text('Rejected'));

      // Scroll right
      await tester.drag(scrollView, const Offset(-500, 0));
      await tester.pumpAndSettle();

      // Get the final position
      final finalRect = tester.getRect(find.text('Rejected'));

      // The position should have changed
      expect(initialRect.left, isNot(equals(finalRect.left)));
    });

    testWidgets('should show loading state when state is AbsenceLoading', (tester) async {
      // arrange
      when(mockCubit.state).thenReturn(AbsenceLoading());
      when(mockCubit.allAbsences).thenReturn([]);
      when(mockCubit.stream).thenAnswer((_) => Stream.value(AbsenceLoading()));

      // act
      await tester.pumpWidget(buildTestWidget());
      
      // assert
      expect(find.byType(Card), findsOneWidget);
      expect(find.text('...'), findsNWidgets(8)); // All cards should show loading value
      expect(find.text('Loading...'), findsNWidgets(8)); // All cards should show loading subtitle
      expect(find.byType(CircularProgressIndicator), findsNWidgets(8)); // Each card should have a loading indicator
    });
  });
} 