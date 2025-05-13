import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/theme/theme_cubit.dart';

class DashboardSidebar extends StatelessWidget {
  final bool isExpanded;
  final int selectedIndex;
  final Function(bool) onToggleExpand;
  final Function(int) onItemSelected;

  const DashboardSidebar({
    super.key,
    required this.isExpanded,
    required this.selectedIndex,
    required this.onToggleExpand,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: isExpanded ? 240 : 72,
          height: double.infinity,
          color: isDarkMode ? const Color(0xFF1A2332) : Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 32),
              // App logo/title
              if (isExpanded)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Absence Tracker',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                )
              else
                const Icon(
                  Icons.calendar_month,
                  color: Colors.blue,
                  size: 32,
                ),
              const SizedBox(height: 32),
              // Navigation items
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _SidebarItem(
                        icon: Icons.dashboard,
                        label: 'Dashboard',
                        selected: selectedIndex == 0,
                        onTap: () => onItemSelected(0),
                        isExpanded: isExpanded,
                        isDarkMode: isDarkMode,
                      ),
                      _SidebarItem(
                        icon: Icons.calendar_month,
                        label: 'Absence Tracker',
                        selected: selectedIndex == 1,
                        onTap: () => onItemSelected(1),
                        isExpanded: isExpanded,
                        isDarkMode: isDarkMode,
                      ),
                      _SidebarItem(
                        icon: Icons.people,
                        label: 'Team',
                        selected: selectedIndex == 2,
                        onTap: () => onItemSelected(2),
                        isExpanded: isExpanded,
                        isDarkMode: isDarkMode,
                      ),
                      _SidebarItem(
                        icon: Icons.task,
                        label: 'Task board',
                        selected: selectedIndex == 3,
                        onTap: () => onItemSelected(3),
                        isExpanded: isExpanded,
                        isDarkMode: isDarkMode,
                      ),
                      _SidebarItem(
                        icon: Icons.calendar_today,
                        label: 'Calendar',
                        selected: selectedIndex == 4,
                        onTap: () => onItemSelected(4),
                        isExpanded: isExpanded,
                        isDarkMode: isDarkMode,
                      ),
                      _SidebarItem(
                        icon: Icons.payments,
                        label: 'Payroll',
                        selected: selectedIndex == 5,
                        onTap: () => onItemSelected(5),
                        isExpanded: isExpanded,
                        isDarkMode: isDarkMode,
                      ),
                    ],
                  ),
                ),
              ),
              // Theme toggle and collapse buttons
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: IconButton(
                  icon: Icon(
                    isExpanded ? Icons.chevron_left : Icons.chevron_right,
                    color: isDarkMode ? Colors.white54 : Colors.black54,
                  ),
                  onPressed: () => onToggleExpand(!isExpanded),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final bool isExpanded;
  final bool isDarkMode;

  const _SidebarItem({
    required this.icon,
    required this.label,
    this.selected = false,
    this.onTap,
    this.isExpanded = true,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? const Color(0xFF2563EB) : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.only(
            left: isExpanded ? 24.0 : 10.0,
            right: 12.0,
            top: 16,
            bottom: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: selected
                    ? Colors.white
                    : isDarkMode
                        ? Colors.white70
                        : Colors.black54,
                size: 20,
              ),
              if (isExpanded) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: selected
                          ? Colors.white
                          : isDarkMode
                              ? Colors.white70
                              : Colors.black54,
                      fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
 