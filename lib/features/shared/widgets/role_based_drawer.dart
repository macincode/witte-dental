import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../auth/presentation/controllers/auth_controller.dart';
import '../../../core/navigation/role_based_navigation.dart';
import '../../../core/constants/app_constants.dart';

class RoleBasedDrawer extends StatelessWidget {
  const RoleBasedDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    
    return Obx(() {
      final user = authController.currentUser;
      if (user == null) return const SizedBox.shrink();
      
      final navigationItems = RoleBasedNavigation.getNavigationItems(user.role);
      
      return Drawer(
        child: Column(
          children: [
            // User Header
            UserAccountsDrawerHeader(
              accountName: Text(user.name),
              accountEmail: Text(user.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              otherAccountsPictures: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: _getRoleColor(user.role),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getRoleIcon(user.role),
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
            
            // Navigation Items
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: navigationItems.length,
                itemBuilder: (context, index) {
                  final item = navigationItems[index];
                  final isCurrentRoute = Get.currentRoute == item.route;
                  
                  return ListTile(
                    leading: Icon(
                      item.icon,
                      color: isCurrentRoute 
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                        color: isCurrentRoute 
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurface,
                        fontWeight: isCurrentRoute ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                    selected: isCurrentRoute,
                    selectedTileColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                    onTap: () {
                      Navigator.pop(context);
                      if (!isCurrentRoute) {
                        Get.toNamed(item.route);
                      }
                    },
                  );
                },
              ),
            ),
            
            // Bottom Actions
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text('settings'.tr),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(AppConstants.appIconSettings);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text('logout'.tr),
              onTap: () {
                Navigator.pop(context);
                authController.logout();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    });
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case AppConstants.roleDoctor:
        return Colors.blue;
      case AppConstants.rolePatient:
        return Colors.green;
      case AppConstants.roleAdmin:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getRoleIcon(String role) {
    switch (role) {
      case AppConstants.roleDoctor:
        return Icons.medical_services;
      case AppConstants.rolePatient:
        return Icons.person;
      case AppConstants.roleAdmin:
        return Icons.admin_panel_settings;
      default:
        return Icons.person;
    }
  }
}