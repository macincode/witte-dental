import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/user.dart';
import '../../../../core/storage/hive_service.dart';
import '../../../../core/constants/app_constants.dart';

class AuthController extends GetxController {
  final Rx<User?> _currentUser = Rx<User?>(null);
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;

  User? get currentUser => _currentUser.value;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  bool get isLoggedIn => HiveService.isLoggedIn && _currentUser.value != null;

  @override
  void onInit() {
    super.onInit();
  }

  void checkAuthStatus() {
    if (HiveService.isLoggedIn) {
      final userRole = HiveService.userRole;
      final userId = HiveService.getUserData<String>('user_id');
      
      if (userRole != null && userId != null) {
        // Create user from stored data
        _currentUser.value = User(
          id: userId,
          email: HiveService.getUserData<String>('user_email') ?? '',
          name: HiveService.getUserData<String>('user_name') ?? '',
          role: userRole,
          isActive: true,
          createdAt: DateTime.now(),
        );
        _navigateBasedOnRole(userRole);
      }
    }
  }

  Future<void> login(String email, String password) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      // Simulate API call - replace with actual implementation
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock user data - replace with API response
      final user = User(
        id: '123',
        email: email,
        name: 'Dr. John Doe',
        role: AppConstants.roleDoctor,
        isActive: true,
        createdAt: DateTime.now(),
      );

      await HiveService.saveAuthData(
        userId: user.id,
        userRole: user.role,
        token: 'mock_token_123',
      );

      await HiveService.saveUserData('user_email', user.email);
      await HiveService.saveUserData('user_name', user.name);

      _currentUser.value = user;
      _navigateBasedOnRole(user.role);
      
    } catch (e) {
      _errorMessage.value = 'Login failed: ${e.toString()}';
    } finally {
      _isLoading.value = false;
    }
  }

  void _navigateBasedOnRole(String role) {
    switch (role) {
      case AppConstants.roleDoctor:
        Get.offAllNamed(AppConstants.doctorDashboard);
        break;
      case AppConstants.rolePatient:
        Get.offAllNamed(AppConstants.patientDashboard);
        break;
      case AppConstants.roleAdmin:
        Get.offAllNamed(AppConstants.adminDashboard);
        break;
      default:
        Get.offAllNamed(AppConstants.loginRoute);
    }
  }

  Future<void> logout() async {
    try {
      _isLoading.value = true;
      await HiveService.logout();
      _currentUser.value = null;
      Get.offAllNamed(AppConstants.loginRoute);
    } finally {
      _isLoading.value = false;
    }
  }

  void clearError() {
    _errorMessage.value = '';
  }
}