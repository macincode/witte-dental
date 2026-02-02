import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:witte_dental_pms/core/services/dio_service.dart';
import 'package:witte_dental_pms/core/storage/hive_service.dart';
import 'package:witte_dental_pms/features/admin/data/services/admin_api_service.dart';
import 'package:witte_dental_pms/features/auth/data/api/auth_api_service.dart';
import 'package:witte_dental_pms/features/auth/domain/repositories/auth_repository.dart';
import 'package:witte_dental_pms/features/shared/widgets/global_widgets.dart';

import 'app/routes/app_pages.dart';
import 'core/config/app_config.dart';
import 'core/config/hive_config.dart';
import 'core/constants/app_constants.dart';
import 'core/controllers/language_controller.dart';
import 'core/controllers/network_controller.dart';
import 'core/controllers/theme_controller.dart';
import 'core/localization/app_translations.dart';
import 'core/services/app_config.dart' as config;
import 'core/services/firebase_service.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize global services
  await _initializeServices();

  runApp(const WitteDentalApp());
}

/// Initialize all global services
Future<void> _initializeServices() async {
  try {
    // Initialize Firebase services
    await FirebaseService.initialize();

    // Initialize App Configuration
    await config.AppConfig.initialize();

    // Set environment (can be configured via build flavors)
    AppConfig.setEnvironment(Environment.dev);

    // Initialize Hive
    await HiveConfig.init();

    // Initialize HiveService after HiveConfig
    final hiveService = HiveService();
    await hiveService.init();

    // Initialize GetX dependencies
    Get
      ..put(DioService())
      ..put(hiveService)
      ..put(AuthApiService(Get.find()))
      ..put(AdminApiService(Get.find()))
      ..put(AuthRepository(Get.find(), Get.find()))
      ..put(NetworkController())
      ..put(ThemeController())
      ..put(LanguageController())
      ..put(AuthController(Get.find()));

    Get.find<AuthController>().checkAuthStatus();

    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    dPrint('✅ All services initialized successfully');
  } catch (e, stackTrace) {
    dPrint('❌ Service initialization failed: $e');
    await FirebaseService.logError(
      e,
      stackTrace,
      reason: 'Service initialization failed',
    );
  }
}

class WitteDentalApp extends StatelessWidget {
  const WitteDentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstants.appName,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.themeMode,
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        translations: AppTranslations(),
        initialRoute: AppConstants.splashRoute,
        getPages: AppPages.routes,

        // Global error handling
        builder: (context, child) {
          // Handle global errors
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            FirebaseService.logError(
              errorDetails.exception,
              errorDetails.stack,
              reason: 'Widget error: ${errorDetails.library}',
            );
            return _buildErrorWidget(errorDetails);
          };

          return child ?? const SizedBox.shrink();
        },

        // Navigation observer for analytics
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseService.analytics),
        ],
      ),
    );
  }

  /// Build custom error widget
  Widget _buildErrorWidget(FlutterErrorDetails errorDetails) {
    return Material(
      child: ColoredBox(
        color: Colors.red.shade50,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red.shade700,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  'Something went wrong',
                  style: TextStyle(
                    color: Colors.red.shade700,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  config.AppConfig.isDebug
                      ? errorDetails.exception.toString()
                      : 'Please restart the app',
                  style: TextStyle(
                    color: Colors.red.shade600,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
