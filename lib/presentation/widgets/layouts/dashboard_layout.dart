import 'package:flutter/material.dart';
import '../dashboard/sidebar.dart';
import '../dashboard/header.dart';

class DashboardLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isDarkMode;
  final int selectedIndex;
  final bool isSidebarExpanded;
  final Function(bool) onSidebarToggle;
  final Function(int) onItemSelected;
  final Widget child;

  const DashboardLayout({
    super.key,
    required this.scaffoldKey,
    required this.isDarkMode,
    required this.selectedIndex,
    required this.isSidebarExpanded,
    required this.onSidebarToggle,
    required this.onItemSelected,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: _buildDrawer(context),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool showSidebar = constraints.maxWidth >= 768;
          
          return Row(
            children: [
              // Sidebar - only show if screen is wide enough
              if (showSidebar)
                DashboardSidebar(
                  isExpanded: isSidebarExpanded,
                  selectedIndex: selectedIndex,
                  onToggleExpand: onSidebarToggle,
                  onItemSelected: onItemSelected,
                ),
              // Main content
              Expanded(
                child: Column(
                  children: [
                    // Header
                    DashboardHeader(
                      isDarkMode: isDarkMode,
                      title: 'Absence Tracker Management',
                      showMenuButton: !showSidebar,
                      onMenuPressed: () {
                        scaffoldKey.currentState?.openDrawer();
                      },
                    ),
                    // Main area with consistent light background
                    Expanded(
                      child: Container(
                        color: const Color(0xFFF6F8FB), // Always light background
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(
                              constraints.maxWidth < 600 ? 16.0 : 32.0,
                            ),
                            child: child,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: DashboardSidebar(
        isExpanded: true,
        selectedIndex: selectedIndex,
        onToggleExpand: (expanded) {
          onSidebarToggle(expanded);
          Navigator.pop(context); // Close drawer after selection
        },
        onItemSelected: (index) {
          onItemSelected(index);
          Navigator.pop(context); // Close drawer after selection
        },
      ),
    );
  }
} 