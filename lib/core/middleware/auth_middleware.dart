import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../constants/app_constants.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();
    if (!authController.isLoggedIn) {
      return const RouteSettings(name: AppConstants.loginRoute);
    }
    return null;
  }
}

class RoleMiddleware extends GetMiddleware {
  RoleMiddleware({required this.requiredRole});
  final String requiredRole;

  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();
    if (!authController.isLoggedIn) {
      return const RouteSettings(name: AppConstants.loginRoute);
    }

    final user = authController.currentUser;
    if (user != null) {
      final userRole = authController.getRoleFromRoleId(user.roleId);
      if (userRole != requiredRole) {
        switch (userRole) {
          case AppConstants.roleDoctor:
            return const RouteSettings(name: AppConstants.doctorDashboard);
          case AppConstants.rolePatient:
            return const RouteSettings(name: AppConstants.patientDashboard);
          case AppConstants.roleAdmin:
            return const RouteSettings(name: AppConstants.adminDashboard);
          default:
            return const RouteSettings(name: AppConstants.loginRoute);
        }
      }
    }
    return null;
  }
}
