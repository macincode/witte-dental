import 'package:get/get.dart';
import 'package:wittehms/features/admin/inquiries_screen.dart';
import 'package:wittehms/features/admin/appointments.dart';
import 'package:wittehms/features/admin/billings.dart';
import 'package:wittehms/features/admin/category_Management.dart';

import '../../core/constants/app_constants.dart';
import '../../core/middleware/auth_middleware.dart';
import '../../features/admin/admin_dashboard.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/doctors/doctor_dashboard.dart';
import '../../features/onboarding/presentation/pages/onboarding_screen.dart';
import '../../features/patients/patient_dashboard.dart';
import '../../features/settings/app_icon_settings_page.dart';
import '../../features/splash/bindings/splash_binding.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppConstants.splashRoute,
      page: () => const SplashPage(),
      binding: SplashBinding(),
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
      name: AppConstants.adminDashboard,
      page: () =>  AdminDashboard(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.InquirieScreen,
      page: () => const InquirieScreen(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.categoryManagement,
      page: () => const CategoryManagement(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.appointments,
      page: () => const AppointmentScreens(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.billings,
      page: () => const BillingScreen(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
  ];
}
