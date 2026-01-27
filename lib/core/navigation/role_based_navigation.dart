import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_constants.dart';

class RoleBasedNavigation {
  static List<NavigationItem> getNavigationItems(String role) {
    switch (role) {
      case AppConstants.roleDoctor:
        return _getDoctorNavigation();
      case AppConstants.rolePatient:
        return _getPatientNavigation();
      case AppConstants.roleAdmin:
        return _getAdminNavigation();
      default:
        return [];
    }
  }

  static List<NavigationItem> _getDoctorNavigation() {
    return [
      NavigationItem(
        title: 'dashboard'.tr,
        icon: Icons.dashboard,
        route: AppConstants.doctorDashboard,
      ),
      NavigationItem(
        title: 'patients'.tr,
        icon: Icons.people,
        route: '/doctor/patients',
      ),
      NavigationItem(
        title: 'appointments'.tr,
        icon: Icons.calendar_today,
        route: '/doctor/appointments',
      ),
      NavigationItem(
        title: 'prescriptions'.tr,
        icon: Icons.receipt,
        route: '/doctor/prescriptions',
      ),
    ];
  }

  static List<NavigationItem> _getPatientNavigation() {
    return [
      NavigationItem(
        title: 'dashboard'.tr,
        icon: Icons.dashboard,
        route: AppConstants.patientDashboard,
      ),
      NavigationItem(
        title: 'appointments'.tr,
        icon: Icons.event,
        route: '/patient/appointments',
      ),
      NavigationItem(
        title: 'medical_history'.tr,
        icon: Icons.history,
        route: '/patient/history',
      ),
      NavigationItem(
        title: 'prescriptions'.tr,
        icon: Icons.medication,
        route: '/patient/prescriptions',
      ),
    ];
  }

  static List<NavigationItem> _getAdminNavigation() {
    return [
      NavigationItem(
        title: 'dashboard'.tr,
        icon: Icons.dashboard,
        route: AppConstants.adminDashboard,
      ),
      NavigationItem(
        title: 'user_management'.tr,
        icon: Icons.group,
        route: AppConstants.adminInvoice,
      ),
      NavigationItem(
        title: 'Users',
        icon: Icons.people,
        route: AppConstants.categoryManagement,
      ),
       NavigationItem(
        title: 'Appointments',
        icon: Icons.calendar_today,
        route: AppConstants.appointments,
      ),
      NavigationItem(
        title: 'Billings',
        icon: Icons.payment,
        route: AppConstants.billings,
      ),
      NavigationItem(
        title: 'reports'.tr,
        icon: Icons.analytics,
        route: '/admin/reports',
      ),
    ];
  }
}

class NavigationItem {

  NavigationItem({
    required this.title,
    required this.icon,
    required this.route,
  });
  final String title;
  final IconData icon;
  final String route;
}