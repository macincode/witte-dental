import 'package:get/get.dart';
import '../../core/constants/app_constants.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/splash/bindings/splash_binding.dart';
import '../../features/doctor/presentation/pages/doctor_dashboard.dart';
import '../../features/patient/presentation/pages/patient_dashboard.dart';
import '../../features/admin/presentation/pages/admin_dashboard.dart';
import '../../features/settings/presentation/pages/app_icon_settings_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppConstants.splashRoute,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppConstants.loginRoute,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: AppConstants.doctorDashboard,
      page: () => const DoctorDashboard(),
    ),
    GetPage(
      name: AppConstants.patientDashboard,
      page: () => const PatientDashboard(),
    ),
    GetPage(
      name: AppConstants.adminDashboard,
      page: () => const AdminDashboard(),
    ),
    GetPage(
      name: AppConstants.appIconSettings,
      page: () => const AppIconSettingsPage(),
    ),
  ];
}