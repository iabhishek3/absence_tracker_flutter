import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/absence/absence_cubit.dart';
import '../cubit/absence/absence_state.dart';
import '../../../domain/entities/absence.dart';

class AbsenceFilters extends StatelessWidget {
  final AbsenceLoaded state;

  const AbsenceFilters({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: DropdownButton<AbsenceType?>(
            value: state.selectedType,
            hint: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.category, size: 18, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Text(
                  'Filter by Type',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            underline: const SizedBox(),
            icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
            items: [
              DropdownMenuItem(
                value: null,
                child: Row(
                  children: [
                    Icon(Icons.all_inclusive, size: 18, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Text(
                      'All Types',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              ...AbsenceType.values.map((type) {
                Color typeColor;
                IconData typeIcon;
                switch (type) {
                  case AbsenceType.sickness:
                    typeColor = Colors.red;
                    typeIcon = Icons.medical_services;
                    break;
                  case AbsenceType.vacation:
                    typeColor = Colors.blue;
                    typeIcon = Icons.beach_access;
                    break;
                  case AbsenceType.other:
                    typeColor = Colors.purple;
                    typeIcon = Icons.more_horiz;
                    break;
                }
                return DropdownMenuItem(
                  value: type,
                  child: Row(
                    children: [
                      Icon(typeIcon, size: 18, color: typeColor),
                      const SizedBox(width: 8),
                      Text(
                        type.name,
                        style: TextStyle(
                          color: typeColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
            onChanged: (type) {
              context.read<AbsenceCubit>().filterByType(type);
            },
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: DropdownButton<AbsenceStatus?>(
            value: state.selectedStatus,
            hint: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.filter_list, size: 18, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Text(
                  'Filter by Status',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            underline: const SizedBox(),
            icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
            items: [
              DropdownMenuItem(
                value: null,
                child: Row(
                  children: [
                    Icon(Icons.all_inclusive, size: 18, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Text(
                      'All Statuses',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              ...AbsenceStatus.values.map((status) {
                Color statusColor;
                IconData statusIcon;
                switch (status) {
                  case AbsenceStatus.requested:
                    statusColor = Colors.orange;
                    statusIcon = Icons.pending_actions;
                    break;
                  case AbsenceStatus.confirmed:
                    statusColor = Colors.green;
                    statusIcon = Icons.check_circle;
                    break;
                  case AbsenceStatus.rejected:
                    statusColor = Colors.red;
                    statusIcon = Icons.cancel;
                    break;
                }
                return DropdownMenuItem(
                  value: status,
                  child: Row(
                    children: [
                      Icon(statusIcon, size: 18, color: statusColor),
                      const SizedBox(width: 8),
                      Text(
                        status.name,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
            onChanged: (status) {
              context.read<AbsenceCubit>().filterByStatus(status);
            },
          ),
        ),
        const SizedBox(width: 12),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: InkWell(
            onTap: () async {
              final DateTimeRange? picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2020),
                lastDate: DateTime(2025),
                initialDateRange: state.selectedDateRange,
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                        surface: Colors.white,
                        onSurface: Colors.black,
                      ),
                      dialogBackgroundColor: Colors.white,
                    ),
                    child: Dialog(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: child!,
                      ),
                    ),
                  );
                },
              );
              if (picked != null) {
                context.read<AbsenceCubit>().filterByDateRange(picked);
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.date_range, size: 18, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Text(
                  state.selectedDateRange != null
                      ? '${state.selectedDateRange!.start.toString().split(' ')[0]} - ${state.selectedDateRange!.end.toString().split(' ')[0]}'
                      : 'Select Date Range',
                  style: TextStyle(
                    color: state.selectedDateRange != null ? Colors.blue : Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                if (state.selectedDateRange != null) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.close, size: 16),
                    onPressed: () {
                      context.read<AbsenceCubit>().filterByDateRange(null);
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    color: Colors.grey[600],
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
} 