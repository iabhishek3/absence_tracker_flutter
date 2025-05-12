import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/dashboard/sidebar.dart';
import '../widgets/dashboard/header.dart';
import '../cubit/theme/theme_cubit.dart';

class AbsenceListPage extends StatefulWidget {
  const AbsenceListPage({super.key});

  @override
  State<AbsenceListPage> createState() => _AbsenceListPageState();
}

class _AbsenceListPageState extends State<AbsenceListPage> {
  int _selectedIndex = 1; // 1 = Leave Management
  bool _isSidebarExpanded = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        return Scaffold(
          body: Row(
            children: [
              // Sidebar
              DashboardSidebar(
                isExpanded: _isSidebarExpanded,
                selectedIndex: _selectedIndex,
                onToggleExpand: (expanded) => setState(() => _isSidebarExpanded = expanded),
                onItemSelected: (index) => setState(() => _selectedIndex = index),
              ),
              // Main content
              Expanded(
                child: Column(
                  children: [
                    // Header
                    DashboardHeader(
                      isDarkMode: isDarkMode,
                      title: 'Absence Tracker Management',
                    ),
                    // Main area (dashboard cards, stats, tables)
                    Expanded(
                      child: Container(
                        color: const Color(0xFFF6F8FB), // Always light background
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                // Expanded(
                                //   child: Center(
                                //     child: Text(
                                //       'Hello, User!',
                                //       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} 