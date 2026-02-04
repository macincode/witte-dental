import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void dPrint(dynamic message) {
  if (kDebugMode) {
    print(message);
  }
}

void dLog(String message) {
  if (kDebugMode) {
    // You can replace this with any logging mechanism you prefer
    debugPrint(message);
  }
}

// --- Shared Widgets ---

class SearchFilterHeader extends StatelessWidget {
  const SearchFilterHeader({
    required this.onSearch,
    required this.onFilterTap,
    required this.isGridView,
    required this.onToggleView,
    super.key,
  });
  final Function(String) onSearch;
  final VoidCallback onFilterTap;
  final bool isGridView;
  final VoidCallback onToggleView;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  if (!isDark)
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                ],
              ),
              child: TextField(
                onChanged: onSearch,
                decoration: InputDecoration(
                  hintText: 'Search by name or phone...',
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          _buildIconButton(
            context,
            icon: Icons.tune_rounded,
            onTap: onFilterTap,
            isDark: isDark,
            bgColor: cardColor,
          ),
          const SizedBox(width: 8),
          _buildIconButton(
            context,
            icon:
                isGridView ? Icons.view_list_rounded : Icons.grid_view_rounded,
            onTap: onToggleView,
            isDark: isDark,
            bgColor: cardColor,
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
    required bool isDark,
    required Color bgColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child:
            Icon(icon, color: isDark ? Colors.white : const Color(0xFF145BD9)),
      ),
    );
  }
}
