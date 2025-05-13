import 'package:absence_tracker_flutter/presentation/cubit/absence/absence_cubit.dart';
import 'package:absence_tracker_flutter/presentation/cubit/absence/absence_state.dart';
import 'package:absence_tracker_flutter/presentation/widgets/pagination_controls.dart';
import 'package:absence_tracker_flutter/presentation/widgets/absence_filters.dart';
import 'package:absence_tracker_flutter/presentation/widgets/absence_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:absence_tracker_flutter/core/utils/file_download_util.dart';

class AbsenceList extends StatelessWidget {
  const AbsenceList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbsenceCubit, AbsenceState>(
      builder: (context, state) {
        if (state is AbsenceInitial) {
          context.read<AbsenceCubit>().getAbsencesList();
          return const _LoadingState();
        }

        if (state is AbsenceLoading) {
          return const _LoadingState();
        }

        if (state is AbsenceError) {
          return _ErrorState(
            message: state.message,
            onRetry: () => context.read<AbsenceCubit>().refreshList(),
          );
        }

        if (state is AbsenceLoaded) {
          return _LoadedState(state: state);
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Absence List',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A2332),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.withAlpha(26),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Loading...',
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Table header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F8FB),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Member Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A2332),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Type of Absence',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A2332),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Period',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A2332),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Member Note',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A2332),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Status',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A2332),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Loading table body
          Container(
            padding: const EdgeInsets.symmetric(vertical: 48),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
                width: 1,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 48,
                    height: 48,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Loading absences...',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A2332),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please wait while we fetch the data.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF1A2332),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadedState extends StatelessWidget {
  final AbsenceLoaded state;

  const _LoadedState({
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Absence List',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A2332),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.withAlpha(26),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.blue,
                      child: Text(
                        state.totalCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Total Absences',
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
                AbsenceFilters(state: state),
                      const Spacer(),
              ElevatedButton.icon(
                onPressed: () {
                  print('Export button clicked');
                  final icalData = context.read<AbsenceCubit>().generateICalData();
                  print('Generated iCal data length: ${icalData.length}');
                  
                  if (icalData.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Failed to generate calendar data. Please try again.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  
                  FileDownloadUtil.downloadString(
                    content: icalData,
                    fileName: 'absences.ics',
                  );
                },
                icon: const Icon(Icons.download, size: 20),
                label: const Text('Export to iCal'),
                style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.white,
                  // foregroundColor: Colors.blue[700],
                  elevation: 1,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(width: 12),
            
            ],
          ),
          const SizedBox(height: 24),
          // Table header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F8FB),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Member Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A2332),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Type of Absence',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A2332),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Period',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A2332),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Member Note',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A2332),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Status',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A2332),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Table body
          if (state.absences.isEmpty)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 48),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFE2E8F0),
                  width: 1,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.inbox_outlined,
                      color: Color(0xFF64748B),
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No absences found',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A2332),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Try adjusting your filters to see more results.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else
            ...state.absences.map((absence) => Column(
                  children: [
                    _AbsenceListRow(
                      name: absence.memberName,
                      memberImage: absence.memberImage,
                      type: absence.type.name,
                      period: absence.formattedPeriod,
                      note: absence.memberNote ?? 'No note provided',
                      status: absence.status.name,
                      admitterNote: absence.admitterNote ?? '',
                    ),
                    const Divider(height: 1),
                  ],
                )),
          const SizedBox(height: 16),
          const PaginationControls(),
        ],
      ),
    );
  }
}

class _AbsenceListRow extends StatelessWidget {
  final String name;
  final String memberImage;
  final String type;
  final String period;
  final String note;
  final String status;
  final String admitterNote;

  const _AbsenceListRow({
    required this.name,
    required this.memberImage,
    required this.type,
    required this.period,
    required this.note,
    required this.status,
    required this.admitterNote,
  });

  void _showAbsenceDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AbsenceDetailsDialog(
        name: name,
        memberImage: memberImage,
        type: type,
        period: period,
        note: note,
        status: status,
        admitterNote: admitterNote,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'confirmed':
        statusColor = Colors.green;
        break;
      case 'rejected':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.orange;
    }

    return InkWell(
      onTap: () => _showAbsenceDetails(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      memberImage,
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.blue.withAlpha(26),
                          child: Text(
                            name[0],
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      name,
                      style: const TextStyle(
                        color: Color(0xFF1A2332),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                type,
                style: const TextStyle(
                  color: Color(0xFF1A2332),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                period,
                style: const TextStyle(
                  color: Color(0xFF1A2332),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                note,
                style: const TextStyle(
                  color: Color(0xFF1A2332),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _DetailRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Colors.blue,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF1A2332),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
} 