import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/absence/absence_cubit.dart';
import '../cubit/absence/absence_state.dart';

class PaginationControls extends StatelessWidget {
  const PaginationControls({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbsenceCubit, AbsenceState>(
      builder: (context, state) {
        if (state is! AbsenceLoaded) return const SizedBox.shrink();

        final totalPages = (state.totalCount / 10).ceil();
        final currentPage = state.currentPage;
        final hasMore = state.hasMore;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Page size selector
              const Text('Items per page:'),
              const SizedBox(width: 8),
              DropdownButton<int>(
                value: 10, // Current page size
                items: [10, 20, 50, 100].map((size) {
                  return DropdownMenuItem(
                    value: size,
                    child: Text(size.toString()),
                  );
                }).toList(),
                onChanged: (newSize) {
                  if (newSize != null) {
                    context.read<AbsenceCubit>().setPageSize(newSize);
                  }
                },
              ),
              const SizedBox(width: 24),
              // Previous page button
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: currentPage > 1
                    ? () => context.read<AbsenceCubit>().prevPage()
                    : null,
              ),
              // Page numbers
              ..._buildPageNumbers(currentPage, totalPages, context),
              // Next page button
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: hasMore
                    ? () => context.read<AbsenceCubit>().nextPage()
                    : null,
              ),
              const SizedBox(width: 16),
              // Page info and total items
              Row(
                children: [
                  Text(
                    'Page $currentPage of $totalPages',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF1A2332),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F8FB),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Total: ${state.totalCount} items',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF1A2332),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildPageNumbers(
    int currentPage,
    int totalPages,
    BuildContext context,
  ) {
    const int maxVisiblePages = 5;
    final List<Widget> pages = [];
    
    if (totalPages <= maxVisiblePages) {
      // Show all pages if total pages is less than max visible
      for (int i = 1; i <= totalPages; i++) {
        pages.add(_buildPageButton(i, currentPage, context));
      }
    } else {
      // Always show first page
      pages.add(_buildPageButton(1, currentPage, context));
      
      // Calculate start and end of visible pages
      int start = currentPage - (maxVisiblePages ~/ 2);
      start = start.clamp(2, totalPages - maxVisiblePages + 2);
      int end = start + maxVisiblePages - 3;
      
      // Add ellipsis if needed
      if (start > 2) {
        pages.add(const Text('...'));
      }
      
      // Add visible page numbers
      for (int i = start; i <= end; i++) {
        pages.add(_buildPageButton(i, currentPage, context));
      }
      
      // Add ellipsis if needed
      if (end < totalPages - 1) {
        pages.add(const Text('...'));
      }
      
      // Always show last page
      pages.add(_buildPageButton(totalPages, currentPage, context));
    }
    
    return pages;
  }

  Widget _buildPageButton(int page, int currentPage, BuildContext context) {
    final isCurrentPage = page == currentPage;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        onPressed: isCurrentPage
            ? null
            : () {
                final cubit = context.read<AbsenceCubit>();
                if (page > currentPage) {
                  cubit.nextPage();
                } else {
                  cubit.prevPage();
                }
              },
        style: TextButton.styleFrom(
          backgroundColor: isCurrentPage
              ? const Color(0xFF2196F3)
              : Colors.transparent,
          foregroundColor: isCurrentPage
              ? Colors.white
              : const Color(0xFF1A2332),
          minimumSize: const Size(40, 40),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          page.toString(),
          style: TextStyle(
            fontWeight: isCurrentPage ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
} 