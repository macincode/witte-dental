import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/config/app_config.dart';
import 'core/config/hive_config.dart';
import 'core/constants/app_constants.dart';
import 'core/controllers/theme_controller.dart';
import 'core/controllers/network_controller.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/controllers/auth_controller.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set environment (can be configured via build flavors)
  AppConfig.setEnvironment(Environment.dev);
  
  // Initialize Hive
  await HiveConfig.init();
  
  // Initialize GetX dependencies
  Get.put(NetworkController());
  Get.put(ThemeController());
  Get.put(AuthController());
  
  runApp(const HealthcareApp());
}

class HealthcareApp extends StatelessWidget {
  const HealthcareApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    
    return Obx(() => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeController.themeMode,
      initialRoute: AppConstants.splashRoute,
      getPages: AppPages.routes,
    ));
  }
}