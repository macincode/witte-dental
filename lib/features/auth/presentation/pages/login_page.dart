import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../../../../core/controllers/theme_controller.dart';
import '../../../shared/widgets/network_aware_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final themeController = Get.find<ThemeController>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return NetworkAwareWidget(
      child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Obx(() => PopupMenuButton<AppThemeMode>(
            icon: Icon(_getThemeIcon(themeController.currentThemeMode)),
            tooltip: 'Theme Settings',
            onSelected: themeController.setThemeMode,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: AppThemeMode.light,
                child: Row(
                  children: [
                    const Icon(Icons.light_mode),
                    const SizedBox(width: 8),
                    const Text('Light'),
                    if (themeController.currentThemeMode == AppThemeMode.light)
                      const Spacer(),
                    if (themeController.currentThemeMode == AppThemeMode.light)
                      const Icon(Icons.check),
                  ],
                ),
              ),
              PopupMenuItem(
                value: AppThemeMode.dark,
                child: Row(
                  children: [
                    const Icon(Icons.dark_mode),
                    const SizedBox(width: 8),
                    const Text('Dark'),
                    if (themeController.currentThemeMode == AppThemeMode.dark)
                      const Spacer(),
                    if (themeController.currentThemeMode == AppThemeMode.dark)
                      const Icon(Icons.check),
                  ],
                ),
              ),
              PopupMenuItem(
                value: AppThemeMode.system,
                child: Row(
                  children: [
                    const Icon(Icons.settings_suggest),
                    const SizedBox(width: 8),
                    const Text('System'),
                    if (themeController.currentThemeMode == AppThemeMode.system)
                      const Spacer(),
                    if (themeController.currentThemeMode == AppThemeMode.system)
                      const Icon(Icons.check),
                  ],
                ),
              ),
            ],
          )),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo/Title
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.local_hospital,
                  size: 60,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'WitteHMS',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Healthcare Management System',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 48),

              // Email Field
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Password Field
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),

              // Error Message
              Obx(() {
                if (authController.errorMessage.isNotEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error,
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            authController.errorMessage,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onErrorContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),

              // Login Button
              Obx(() => SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: authController.isLoading
                      ? null
                      : () {
                          authController.clearError();
                          authController.login(
                            emailController.text.trim(),
                            passwordController.text,
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: authController.isLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        )
                      : const Text('Login'),
                ),
              )),

              const SizedBox(height: 24),

              // Demo Credentials
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Demo Credentials:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Doctor: doctor@demo.com / password',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Patient: patient@demo.com / password',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Admin: admin@demo.com / password',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
  }

  IconData _getThemeIcon(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return Icons.light_mode;
      case AppThemeMode.dark:
        return Icons.dark_mode;
      case AppThemeMode.system:
        return Icons.settings_suggest;
    }
  }
