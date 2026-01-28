class AppConstants {
  // App Info
  static const String appName = 'WITTE';
  static const String appVersion = '1.0.0';

  // User Roles
  static const String roleDoctor = 'doctor';
  static const String rolePatient = 'patient';
  static const String roleAdmin = 'admin';
  static const String roleStaff = 'staff';

  // Routes
  static const String splashRoute = '/splash';
  static const String onboardingRoute = '/onboarding';
  static const String loginRoute = '/login';
  static const String appIconSettings = '/app-icon-settings';

  // Doctor Routes
  static const String doctorDashboard = '/doctor';

  // patient Routes
  static const String patientDashboard = '/patient';

  // Admin Routes
  static const String adminDashboard = '/admin';
  static const String InquirieScreen = '/inquiries';
  static const String categoryManagement = '/category-management';
  static const String appointments = '/appointments';
  static const String billings = '/billings';

  // Validation
  static const int minPasswordLength = 8;
  static const int maxNameLength = 50;
  static const String phoneRegex = r'^\+?[1-9]\d{1,14}$';

  // Healthcare Standards
  static const int maxFileUploadMB = 10;
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'pdf'];
}
