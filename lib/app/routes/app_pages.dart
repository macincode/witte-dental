import 'package:get/get.dart';
import 'package:witte_dental_pms/features/admin/presentation/pages/appointmentList_management.dart';
import 'package:witte_dental_pms/features/admin/presentation/pages/appointment_screen.dart';
import 'package:witte_dental_pms/features/admin/presentation/pages/billings.dart';
import 'package:witte_dental_pms/features/admin/presentation/pages/doctorList_management.dart';
import 'package:witte_dental_pms/features/admin/presentation/pages/doctor_screen.dart';
import 'package:witte_dental_pms/features/admin/presentation/pages/inquiries_screen.dart';
import 'package:witte_dental_pms/features/admin/presentation/pages/inquiryList_management.dart';
import 'package:witte_dental_pms/features/admin/presentation/pages/inventoryList_management.dart';
import 'package:witte_dental_pms/features/admin/presentation/pages/inventory_screen.dart';
import 'package:witte_dental_pms/features/admin/presentation/pages/patientList_management.dart';
import 'package:witte_dental_pms/features/admin/presentation/pages/patient_screen.dart';
import 'package:witte_dental_pms/features/admin/presentation/pages/pharmacyList_management.dart';
import 'package:witte_dental_pms/features/admin/presentation/pages/pharmacy_screen.dart';
import 'package:witte_dental_pms/features/admin/presentation/pages/admin_home_screen.dart';
import 'package:witte_dental_pms/features/admin/presentation/pages/staffList_management.dart';
import 'package:witte_dental_pms/features/admin/presentation/pages/staff_screen.dart';
import 'package:witte_dental_pms/features/patients/presentation/screens/patient_details_screen.dart';
import 'package:witte_dental_pms/features/patients/presentation/screens/patient_list_screen.dart';
import 'package:witte_dental_pms/features/staff/presentation/screens/staff_details_screen.dart';
import 'package:witte_dental_pms/features/staff/presentation/screens/staff_list_screen.dart';

import '../../core/constants/app_constants.dart';
import '../../core/middleware/auth_middleware.dart';
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
      page: AdminHomeScreen.new,
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.inquiryScreen,
      page: () => const InquiryScreen(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.inquiryListManagement,
      page: () => const InquirylistManagement(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.appointmentScreen,
      page: () => const AppointmentScreen(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.appointmentListManagement,
      page: () => const AppointmentlistManagement(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.patientScreen,
      page: () => const PatientScreen(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.patientListManagement,
      page: () => const PatientlistManagement(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.doctorScreen,
      page: () => const DoctorScreen(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.doctorListManagement,
      page: () => const DoctorlistManagement(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.staffScreen,
      page: () => const StaffScreen(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.staffListManagement,
      page: () => const StafflistManagement(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.inventoryScreen,
      page: () => const InventoryScreen(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.inventoryListManagement,
      page: () => const InventorylistManagement(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.pharmacyScreen,
      page: () => const PharmacyScreen(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.pharmacyListManagement,
      page: () => const PharmacylistManagement(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: '/patient-list',
      page: () => const PatientListScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/patient-details',
      page: () => const PatientDetailsScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/staff-list',
      page: () => const StaffListScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/staff-details',
      page: () => const StaffDetailsScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppConstants.billings,
      page: () => const BillingScreen(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
  ];
}
