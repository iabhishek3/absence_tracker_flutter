import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/theme/theme_cubit.dart';

class DashboardHeader extends StatelessWidget {
  final bool isDarkMode;
  final String title;

  const DashboardHeader({
    super.key,
    required this.isDarkMode,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1A2332) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.04 * 255).toInt()),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : const Color(0xFF1A2332),
            ),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: isDarkMode ? Colors.white : const Color(0xFF1A2332),
            ),
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          ),
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: isDarkMode ? Colors.white : const Color(0xFF1A2332),
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: isDarkMode ? const Color(0xFF2D3748) : const Color(0xFFEDF2FA),
            child: Icon(
              Icons.person,
              color: isDarkMode ? Colors.white : const Color(0xFF1A2332),
            ),
          ),
        ],
      ),
    );
  }
} 