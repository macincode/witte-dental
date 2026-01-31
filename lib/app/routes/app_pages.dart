import 'package:get/get.dart';
import 'package:witte_dental_pms/features/admin/appointmentList_management.dart';
import 'package:witte_dental_pms/features/admin/appointment_screen.dart';
import 'package:witte_dental_pms/features/admin/billings.dart';
import 'package:witte_dental_pms/features/admin/doctorList_management.dart';
import 'package:witte_dental_pms/features/admin/doctor_screen.dart';
import 'package:witte_dental_pms/features/admin/home_screen.dart';
import 'package:witte_dental_pms/features/admin/inquiryList_management.dart';
import 'package:witte_dental_pms/features/admin/inquiries_screen.dart';
import 'package:witte_dental_pms/features/admin/inventoryList_management.dart';
import 'package:witte_dental_pms/features/admin/inventory_screen.dart';
import 'package:witte_dental_pms/features/admin/patientList_management.dart';
import 'package:witte_dental_pms/features/admin/patient_screen.dart';
import 'package:witte_dental_pms/features/admin/pharmacyList_management.dart';
import 'package:witte_dental_pms/features/admin/pharmacy_screen.dart';
import 'package:witte_dental_pms/features/admin/staffList_management.dart';
import 'package:witte_dental_pms/features/admin/staff_screen.dart';

import '../../core/constants/app_constants.dart';
import '../../core/middleware/auth_middleware.dart';
import '../../features/admin/dashboard.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/doctors/doctor_dashboard.dart';
import '../../features/onboarding/presentation/pages/onboarding_screen.dart';
import '../../features/patients/patient_dashboard.dart';
import '../../features/settings/app_icon_settings_page.dart';
// import '../../features/splash/bindings/splash_binding.dart';
import '../../features/splash/splash_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppConstants.splashRoute,
      page: () => const SplashPage(),
      // binding: SplashBinding(),
    ),
    GetPage(
      name: AppConstants.onboardingRoute,
      page: () => const OnboardingScreen(),
    ),
    GetPage(
      name: AppConstants.loginRoute,
      page: () => const LoginPage(),
    ),

    GetPage(
      name: AppConstants.appIconSettings,
      page: () => const AppIconSettingsPage(),
      middlewares: [AuthMiddleware()],
    ),

    // Doctor routes
    GetPage(
      name: AppConstants.doctorDashboard,
      page: () => const DoctorDashboard(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleDoctor)],
    ),

    // Patient routes
    GetPage(
      name: AppConstants.patientDashboard,
      page: () => const PatientDashboard(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.rolePatient)],
    ),

    // Admin routes
     GetPage(
      name: AppConstants.adminHomeScreen,
      page: () => const AdminHomeScreen(),
    ),
    GetPage(
      name: AppConstants.adminDashboard,
      page: AdminDashboard.new,
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.inquiryScreen,
      page: () => const InquiryScreen(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.inquirylistManagement,
      page: () => const InquirylistManagement(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.appointmentScreen,
      page: () => const AppointmentScreen(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.appointmentlistManagement,
      page: () => const AppointmentlistManagement(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.patientScreen,
      page: () => const PatientScreen(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.patientlistManagement,
      page: () => const PatientlistManagement(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.doctorScreen,
      page: () => const DoctorScreen(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.doctorlistManagement,
      page: () => const DoctorlistManagement(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.staffScreen,
      page: () => const StaffScreen(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.stafflistManagement,
      page: () => const StafflistManagement(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
     GetPage(
      name: AppConstants.inventoryScreen,
      page: () => const InventoryScreen(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.inventorylistManagement,
      page: () => const InventorylistManagement(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.pharmacyScreen,
      page: () => const PharmacyScreen(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.pharmacylistManagement,
      page: () => const PharmacylistManagement(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.billings,
      page: () => const BillingScreen(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
  ];
}
