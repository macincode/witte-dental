import 'package:get/get.dart';
import '../../core/constants/app_constants.dart';
import '../../core/middleware/auth_middleware.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/doctor/presentation/pages/doctor_dashboard.dart';
import '../../features/patient/presentation/pages/patient_dashboard.dart';
import '../../features/admin/presentation/pages/admin_dashboard.dart';
import '../../features/settings/presentation/pages/app_icon_settings_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppConstants.loginRoute,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: AppConstants.doctorDashboard,
      page: () => const DoctorDashboard(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleDoctor)],
    ),
    GetPage(
      name: AppConstants.patientDashboard,
      page: () => const PatientDashboard(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.rolePatient)],
    ),
    GetPage(
      name: AppConstants.adminDashboard,
      page: () => const AdminDashboard(),
      middlewares: [RoleMiddleware(requiredRole: AppConstants.roleAdmin)],
    ),
    GetPage(
      name: AppConstants.appIconSettings,
      page: () => const AppIconSettingsPage(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}