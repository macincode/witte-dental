class AppConstants {
  // App Info
  static const String appName = 'WITTE';
  static const String appVersion = '1.0.0';

  // User Roles (matching API role_id values)
  static const String rolePatient = 'patient'; // role_id: 1
  static const String roleAdmin = 'admin'; // role_id: 2
  static const String roleDoctor = 'doctor'; // role_id: 3
  static const String roleStaff = 'staff'; // role_id: 4

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
  static const String adminHomeScreen = '/admin';
  static const String adminDashboard = '/admin_dashboard';
  static const String inquiryScreen = '/admin_inquiries';
  static const String inquiryListManagement = '/admin_inquiry-management';
  static const String appointmentScreen = '/admin_appointments';
  static const String appointmentListManagement =
      '/admin_appointments-management';
  static const String patientScreen = '/admin_patients';
  static const String patientListManagement = '/admin_patients-management';
  static const String doctorScreen = '/admin_doctors';
  static const String doctorListManagement = '/admin_doctors-management';
  static const String staffScreen = '/admin_staffs';
  static const String staffListManagement = '/admin_staffs-management';
  static const String inventoryScreen = '/admin_inventory';
  static const String inventoryListManagement = '/admin_inventory-management';
  static const String pharmacyScreen = '/admin_pharmacy';
  static const String pharmacyListManagement = '/admin_pharmacy-management';
  static const String billings = '/billings';

  // Validation
  static const int minPasswordLength = 8;
  static const int maxNameLength = 50;
  static const String phoneRegex = r'^\+?[1-9]\d{1,14}$';

  // Healthcare Standards
  static const int maxFileUploadMB = 10;
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'pdf'];
}
