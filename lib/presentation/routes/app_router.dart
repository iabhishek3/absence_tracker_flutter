import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/theme/theme_cubit.dart';
import '../widgets/layouts/dashboard_layout.dart';
import '../pages/absence_list_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const DashboardWrapper(
            child: AbsenceListPage(),
          ),
        );
      // Add more routes here
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

class DashboardWrapper extends StatefulWidget {
  final Widget child;

  const DashboardWrapper({
    super.key,
    required this.child,
  });

  @override
  State<DashboardWrapper> createState() => _DashboardWrapperState();
}

class _DashboardWrapperState extends State<DashboardWrapper> {
  int _selectedIndex = 1;
  bool _isSidebarExpanded = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _handleSidebarToggle(bool expanded) {
    setState(() => _isSidebarExpanded = expanded);
  }

  void _handleItemSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        return DashboardLayout(
          scaffoldKey: _scaffoldKey,
          isDarkMode: isDarkMode,
          selectedIndex: _selectedIndex,
          isSidebarExpanded: _isSidebarExpanded,
          onSidebarToggle: _handleSidebarToggle,
          onItemSelected: _handleItemSelected,
          child: widget.child,
        );
      },
    );
  }
} 