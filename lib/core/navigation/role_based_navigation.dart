import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:witte_dental_pms/features/admin/presentation/controllers/admin_patient_controller.dart';
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
        title: 'Inquiries',
        icon: Icons.all_inbox_sharp,
        route: AppConstants.inquiryScreen,
      ),
      NavigationItem(
        title: 'Appointments',
        icon: Icons.calendar_today,
        route: AppConstants.appointmentScreen,
      ),
       NavigationItem(
        title: 'Patients',
        icon: Icons.group,
        route: AppConstants.patientScreen,
       
      ),
       NavigationItem(
        title: 'Doctors',
        icon: Icons.person,
        route: AppConstants.doctorScreen,
      ),
       NavigationItem(
        title: 'Staff',
        icon: Icons.group,
        route: AppConstants.staffScreen,
      ),
      NavigationItem(
        title: 'Inventory',
        icon: Icons.inventory,
        route: AppConstants.inventoryScreen,
      ),
      NavigationItem(
        title: 'Pharmacy',
        icon: Icons.medical_information,
        route: AppConstants.pharmacyScreen,
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
