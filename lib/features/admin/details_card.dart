import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wittehms/core/controllers/theme_controller.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String count;
  final VoidCallback? onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.icon,
    required this.count,
    this.onTap,
  });

  static Widget buildHeaderCard(BuildContext context, String title, String subtitle) {
    final themeController = Get.find<ThemeController>();
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: themeController.currentThemeMode == AppThemeMode.dark ||
              (themeController.currentThemeMode == AppThemeMode.system &&
                  Theme.of(context).brightness == Brightness.dark)
          ? BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xff30363d),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff30363d).withOpacity(0.2),
                  spreadRadius: 0.6,
                  blurRadius: 3,
                  offset: const Offset(1, 1),
                ),
              ],
            )
          : BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.12),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0.8,
                  blurRadius: 10,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    
    return InkWell(
      onTap: onTap ?? () {},
      child: DecoratedBox(
        decoration: themeController.currentThemeMode == AppThemeMode.dark ||
                (themeController.currentThemeMode == AppThemeMode.system &&
                    Theme.of(context).brightness == Brightness.dark)
            ? BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xff30363d),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff30363d).withOpacity(0.2),
                    spreadRadius: 0.6,
                    blurRadius: 3,
                    offset: const Offset(1, 1),
                  ),
                ],
              )
            : BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.12),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 0.8,
                    blurRadius: 10,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.09),
                      Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                count,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}