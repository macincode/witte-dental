import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_constants.dart';
import '../storage/hive_service.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (!HiveService.isLoggedIn) {
      return const RouteSettings(name: AppConstants.loginRoute);
    }
    return null;
  }
}

class RoleMiddleware extends GetMiddleware {
  final String requiredRole;
  
  RoleMiddleware({required this.requiredRole});

  @override
  RouteSettings? redirect(String? route) {
    if (!HiveService.isLoggedIn) {
      return const RouteSettings(name: AppConstants.loginRoute);
    }
    
    final userRole = HiveService.userRole;
    if (userRole != requiredRole) {
      // Redirect to appropriate dashboard based on user's actual role
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
    return null;
  }
}