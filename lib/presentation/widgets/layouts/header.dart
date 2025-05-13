import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/theme/theme_cubit.dart';

class DashboardHeader extends StatelessWidget {
  final bool isDarkMode;
  final String title;
  final bool showMenuButton;
  final VoidCallback? onMenuPressed;

  const DashboardHeader({
    super.key,
    required this.isDarkMode,
    required this.title,
    this.showMenuButton = false,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: EdgeInsets.symmetric(
        horizontal: showMenuButton ? 16.0 : 32.0,
      ),
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
          if (showMenuButton)
            IconButton(
              icon: Icon(
                Icons.menu,
                color: isDarkMode ? Colors.white : const Color(0xFF1A2332),
              ),
              onPressed: onMenuPressed,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          if (showMenuButton)
            const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: showMenuButton ? 20 : 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : const Color(0xFF1A2332),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: isDarkMode ? Colors.white : const Color(0xFF1A2332),
                ),
                onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(
                  Icons.notifications_none,
                  color: isDarkMode ? Colors.white : const Color(0xFF1A2332),
                ),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                radius: 16,
                backgroundColor: isDarkMode ? const Color(0xFF2D3748) : const Color(0xFFEDF2FA),
                child: Icon(
                  Icons.person,
                  size: 16,
                  color: isDarkMode ? Colors.white : const Color(0xFF1A2332),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 