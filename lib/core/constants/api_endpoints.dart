class ApiEndpoints {
  // Base URL
  static const String baseUrl = 'http://10.155.161.56:8000/api';

  // Auth
  static const String superAdminLogin = '/superadmin/login';
  static const String adminLogin = '/admin/login';
  static const String staffLogin = '/login';
  static const String logout = '/logout';

  // Dashboard & Analytics
  static const String superAdminDashboard = '/superadmin/dashboard';
  static const String adminDashboard = '/admin/dashboard';
  static const String dashboardHome = '/dashboard/home';
  static const String getCounts = '/counts';

  // Doctor Management
  static const String getDoctorList = '/doctor_list';
  static const String storeDoctor = '/store_doctor';
  static const String updateDoctor = '/update_doctor';
  static const String deleteDoctor = '/delete_doctor';
  static const String getDoctorDepartments = '/doctor_departments';
  static const String addDoctorDepartment = '/doctor_department_add';

  // Patient Management
  static const String getPatientList = '/patient_list';
  static const String storePatient = '/store_patient';
  static const String updatePatient = '/update_patient';
  static const String deletePatient = '/delete_patient';

  // Staff Management
  static const String getStaffList = '/staff_list';
  static const String storeStaff = '/store_staff';
  static const String getStaffCategories = '/staff_category_list';
  static const String storeStaffCategory = '/store_staff_category';

  // Appointment Management
  static const String getAppointmentList = '/appointment_list';
  static const String storeAppointment = '/store_appointment';
  static const String updateAppointments = '/update_appointments';
  static const String appointmentStatusUpdate = '/appointment_status_update';
  static const String rescheduleAppointment = '/reschedule_appointment';
  static const String getUpcomingAppointments = '/upcoming_appointments';
  static const String getAppointmentsByDate = '/appointment_custom_date';
  static const String addAppointmentSummary = '/appointment_summary';

  // Pharmacy Management
  static const String getPharmacyList = '/pharmacy_list';
  static const String storePharmacyItem = '/store_pharmacy';
  static const String updatePharmacyItem = '/update_pharmacy';
  static const String deletePharmacyItem = '/delete_pharmacy';
  static const String getPharmacyCategories = '/pharmacy_category_list';
  static const String storePharmacyCategory = '/store_pharmacy_category';

  // Inventory Management
  static const String getInventoryList = '/inventory_list';
  static const String storeInventoryItem = '/store_inventory';
  static const String getInventoryCategories = '/inventory_category_list';

  // Accounts & Financial Management
  static const String getAccountsList = '/accountslist';
  static const String storePharmacyAccountEntry = '/store_pharmacy_account';
  static const String storeInventoryAccountEntry = '/store_inventory_account';
  static const String storeLabAccountEntry = '/store_lab_account';
  static const String getStaffSalary = '/get_staff_salary';
  static const String storeStaffSalary = '/store_staff_salary';

  // SaaS & Business Management
  static const String getSaasPlans = '/saas-plans';
  static const String createSaasPlan = '/saas-plans';
  static const String getBusinessProfile = '/business/profile';
  static const String updateBusinessProfile = '/business/profile';
  static const String getAvailableHospitals = '/hospitals/available';
  static const String switchHospitalContext = '/hospital/switch';

  // Hospital Settings
  static const String getHospitalSettings = '/hospital/settings';
  static const String updatePaymentSettings = '/hospital/settings/payment';
  static const String updateWhatsappSettings = '/hospital/settings/whatsapp';

  // Notifications & Enquiries
  static const String getNotifications = '/get_notificationsList';
  static const String changeNotificationStatus = '/change_notification_status';
  static const String storeEnquiry = '/store_enquiry';
  static const String getEnquiryList = '/get_enquiry_list';

  // DICOM & Medical Imaging
  static const String uploadDicomFile = '/dicom/upload';
  static const String getPatientDicomFiles = '/dicom/patient/{id}/files';
  static const String getDicomFileDetails = '/dicom/file/{id}';
  static const String saveDicomAnnotations = '/dicom/annotations';

  // Treatment & Medical Records
  static const String getTreatmentList = '/treatment_list';
  static const String getCategories = '/category_list';
  static const String storeCategory = '/store_category';
  static const String getTreatmentMethods = '/treatmentmethodList';
  static const String storeTreatmentMethod = '/storetreatmentmethod';
  static const String getMedicalRecords = '/medical_record_list';
  static const String storeMedicalRecord = '/store_medical_record';
}
