import 'package:absence_tracker_flutter/presentation/widgets/absence_stats.dart';
import 'package:absence_tracker_flutter/presentation/widgets/absence_list.dart';
import 'package:flutter/material.dart';

class AbsenceListPage extends StatelessWidget {
  const AbsenceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                AbsenceStats(),
                                SizedBox(height: 10),
                                AbsenceList(),
                              ],
                            ),
                          ),
                        );
  }
} 