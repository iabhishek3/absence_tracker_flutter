import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/absence.dart';
import '../cubit/absence/absence_cubit.dart';
import '../cubit/absence/absence_state.dart';

class AbsenceStats extends StatefulWidget {
  const AbsenceStats({super.key});

  @override
  State<AbsenceStats> createState() => _AbsenceStatsState();
}

class _AbsenceStatsState extends State<AbsenceStats> {
  @override
  void initState() {
    super.initState();
    context.read<AbsenceCubit>().getAbsencesList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbsenceCubit, AbsenceState>(
      builder: (context, state) {
        if (state is! AbsenceLoaded) {
          return const SizedBox.shrink();
        }

        // Get all absences from the cubit (not just filtered)
        final cubit = context.read<AbsenceCubit>();
        final absences = cubit.allAbsences;
        
        final totalAbsences = absences.length;
        final absencesByType = _getAbsencesByType(absences);
        final absencesByStatus = _getAbsencesByStatus(absences);

        // Calculate total days
        final totalDays = absences.fold<int>(
          0,
          (sum, absence) => sum + absence.durationInDays,
        );

        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   children: [
                //     const Icon(Icons.bar_chart, color: Colors.blue, size: 28),
                //     const SizedBox(width: 12),
                //     const Text(
                //       'Statistics',
                //       style: TextStyle(
                //         fontSize: 22,
                //         fontWeight: FontWeight.bold,
                //         letterSpacing: 0.5,
                //         color: Color(0xFF1A2332),
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _VisualStatCard(
                        title: 'Total Absences',
                        value: totalAbsences.toString(),
                        subtitle: 'Total Days: $totalDays',
                        icon: Icons.calendar_month,
                        color: Colors.blueAccent,
                      ),
                      const SizedBox(width: 16),
                      // By Type: separate cards for each type
                      ...absencesByType.entries.map((e) {
                        final type = e.key;
                        final count = e.value;
                        final days = absences
                            .where((a) => a.type.name == type)
                            .fold<int>(0, (sum, a) => sum + a.durationInDays);
                        
                        IconData icon;
                        Color color;
                        switch (type.toLowerCase()) {
                          case 'sick':
                            icon = Icons.sick;
                            color = Colors.redAccent;
                            break;
                          case 'annual':
                            icon = Icons.beach_access;
                            color = Colors.blueAccent;
                            break;
                          case 'casual':
                            icon = Icons.weekend;
                            color = Colors.orangeAccent;
                            break;
                          case 'personal':
                            icon = Icons.person;
                            color = Colors.purpleAccent;
                            break;
                          default:
                            icon = Icons.category;
                            color = Colors.grey;
                        }
                        return Row(
                          children: [
                            _VisualStatCard(
                              title: type[0].toUpperCase() + type.substring(1),
                              value: count.toString(),
                              subtitle: 'Total Days: $days',
                              icon: icon,
                              color: color,
                            ),
                            const SizedBox(width: 12),
                          ],
                        );
                      }),
                      // By Status: three separate cards
                      _VisualStatCard(
                        title: 'Requested',
                        value: absencesByStatus['requested']?.toString() ?? '0',
                        subtitle: 'Pending Approvals',
                        icon: Icons.hourglass_top,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 12),
                      _VisualStatCard(
                        title: 'Confirmed',
                        value: absencesByStatus['confirmed']?.toString() ?? '0',
                        subtitle: 'Approved Requests',
                        icon: Icons.check_circle_outline,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 12),
                      _VisualStatCard(
                        title: 'Rejected',
                        value: absencesByStatus['rejected']?.toString() ?? '0',
                        subtitle: 'Declined Requests',
                        icon: Icons.cancel_outlined,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Map<String, int> _getAbsencesByType(List<Absence> absences) {
    final map = <String, int>{};
    for (final absence in absences) {
      final typeName = absence.type.name;
      map[typeName] = (map[typeName] ?? 0) + 1;
    }
    return map;
  }

  Map<String, int> _getAbsencesByStatus(List<Absence> absences) {
    final map = <String, int>{};
    for (final absence in absences) {
      final statusName = absence.status.name;
      map[statusName] = (map[statusName] ?? 0) + 1;
    }
    return map;
  }
}

class _VisualStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _VisualStatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(0xFF1A2332),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: color,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
} 