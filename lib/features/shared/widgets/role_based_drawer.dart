import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/navigation/role_based_navigation.dart';
import '../../auth/presentation/controllers/auth_controller.dart';

class RoleBasedDrawer extends StatelessWidget {
  const RoleBasedDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Obx(() {
      final user = authController.currentUser;
      if (user == null) return const SizedBox.shrink();

      final navigationItems = RoleBasedNavigation.getNavigationItems(
        authController.getRoleFromRoleId(user.roleId),
      );

      return SizedBox(
        width: 260,
        child: Drawer(
          backgroundColor: Colors.white,
          child: Column(
            children: [
              // Modern Header with Gradient
              Container(
                height: 180,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF145BD9), // Light Sea Green
                      Color(0xFF07BDFF), // Sea Green
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // User Info on Left
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                user.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                user.email,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 11,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  _getRoleDisplayName(
                                    authController
                                        .getRoleFromRoleId(user.roleId),
                                  ),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Profile Avatar on Right
                        Stack(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  user.name.isNotEmpty
                                      ? user.name[0].toUpperCase()
                                      : 'U',
                                  style: TextStyle(
                                    color: _getRoleColor(
                                      authController
                                          .getRoleFromRoleId(user.roleId),
                                    ),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: _getRoleColor(
                                    authController
                                        .getRoleFromRoleId(user.roleId),
                                  ),
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                ),
                                child: Icon(
                                  _getRoleIcon(
                                    authController
                                        .getRoleFromRoleId(user.roleId),
                                  ),
                                  color: Colors.white,
                                  size: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Navigation Items with Modern Design
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  itemCount: navigationItems.length,
                  itemBuilder: (context, index) {
                    final item = navigationItems[index];
                    final isCurrentRoute = Get.currentRoute == item.route;

                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: isCurrentRoute
                            ? const Color(0xFF07BDFF).withOpacity(0.1)
                            : Colors.transparent,
                      ),
                      child: ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 2,
                        ),
                        leading: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isCurrentRoute
                                ? const Color(0xFF07BDFF)
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            item.icon,
                            color: isCurrentRoute
                                ? Colors.white
                                : Colors.grey.shade600,
                            size: 16,
                          ),
                        ),
                        title: Text(
                          item.title,
                          style: TextStyle(
                            color: isCurrentRoute
                                ? const Color(0xFF07BDFF)
                                : Colors.grey.shade800,
                            fontWeight: isCurrentRoute
                                ? FontWeight.w600
                                : FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        trailing: isCurrentRoute
                            ? Container(
                                width: 4,
                                height: 4,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF07BDFF),
                                  shape: BoxShape.circle,
                                ),
                              )
                            : null,
                        onTap: () {
                          Navigator.pop(context);
                          if (!isCurrentRoute) {
                            Get.toNamed(item.route);
                          }
                        },
                      ),
                    );
                  },
                ),
              ),

              // Bottom Actions with Modern Style
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  border: Border(top: BorderSide(color: Colors.grey.shade200)),
                ),
                child: Column(
                  children: [
                    _buildBottomAction(
                      icon: Icons.settings_outlined,
                      title: 'settings'.tr,
                      onTap: () {
                        Navigator.pop(context);
                        Get.toNamed(AppConstants.appIconSettings);
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildBottomAction(
                      icon: Icons.logout_outlined,
                      title: 'logout'.tr,
                      isDestructive: true,
                      onTap: () {
                        Navigator.pop(context);
                        authController.logout();
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildBottomAction({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDestructive ? Colors.red.shade200 : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? Colors.red.shade600 : Colors.grey.shade700,
              size: 18,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                color:
                    isDestructive ? Colors.red.shade600 : Colors.grey.shade800,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case AppConstants.roleDoctor:
        return const Color(0xFF07BDFF); // Sea Green
      case AppConstants.rolePatient:
        return const Color(0xFF145BD9); // Light Sea Green
      case AppConstants.roleAdmin:
        return const Color(0xFF4682B4); // Steel Blue
      case AppConstants.roleStaff:
        return const Color(0xFF9370DB); // Medium Purple
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
      case AppConstants.roleStaff:
        return Icons.support_agent;
      default:
        return Icons.person;
    }
  }

  String _getRoleDisplayName(String role) {
    switch (role) {
      case AppConstants.roleDoctor:
        return 'Doctor';
      case AppConstants.rolePatient:
        return 'Patient';
      case AppConstants.roleAdmin:
        return 'Administrator';
      case AppConstants.roleStaff:
        return 'Staff Member';
      default:
        return 'User';
    }
  }
}
