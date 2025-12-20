// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ethio_cal/providers/theme_provider.dart';

class Tabs extends StatelessWidget {
  final bool isSelected;
  final Function(bool) onTabChanged;

  const Tabs({super.key, required this.isSelected, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildTab(
                "Calendar",
                !isSelected,
                isDark,
                () => onTabChanged(false),
              ),
              const SizedBox(width: 24),
              _buildTab("Today", isSelected, isDark, () => onTabChanged(true)),
            ],
          ),
          IconButton(
            onPressed: () => themeProvider.toggleTheme(),
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: isDark ? Colors.white : const Color(0xFF3D312A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String label, bool active, bool isDark, VoidCallback onTap) {
    const Color richBlack = Color(0xFF3D312A);

    final Color contentColor = isDark ? Colors.white : richBlack;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: active ? contentColor : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.chauPhilomeneOne(
            color: active ? contentColor : contentColor.withOpacity(0.5),
            fontSize: 16,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
