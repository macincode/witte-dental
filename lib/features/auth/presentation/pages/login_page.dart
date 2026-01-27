import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/controllers/theme_controller.dart';
import '../../../shared/widgets/network_aware_widget.dart';
import '../controllers/auth_controller.dart';
import '../widgets/role_selection_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final themeController = Get.find<ThemeController>();

    return NetworkAwareWidget(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Obx(
              () => PopupMenuButton<AppThemeMode>(
                icon: Icon(_getThemeIcon(themeController.currentThemeMode)),
                tooltip: 'theme_settings'.tr,
                onSelected: themeController.setThemeMode,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: AppThemeMode.light,
                    child: Row(
                      children: [
                        const Icon(Icons.light_mode),
                        const SizedBox(width: 8),
                        Text('light'.tr),
                        if (themeController.currentThemeMode ==
                            AppThemeMode.light)
                          const Spacer(),
                        if (themeController.currentThemeMode ==
                            AppThemeMode.light)
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
                        Text('dark'.tr),
                        if (themeController.currentThemeMode ==
                            AppThemeMode.dark)
                          const Spacer(),
                        if (themeController.currentThemeMode ==
                            AppThemeMode.dark)
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
                        Text('system'.tr),
                        if (themeController.currentThemeMode ==
                            AppThemeMode.system)
                          const Spacer(),
                        if (themeController.currentThemeMode ==
                            AppThemeMode.system)
                          const Icon(Icons.check),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Logo/Title
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 100,
                    decoration: const BoxDecoration(),
                    child: Obx(
                      () => Image.asset(
                        themeController.currentThemeMode == AppThemeMode.dark ||
                                (themeController.currentThemeMode ==
                                        AppThemeMode.system &&
                                    Theme.of(context).brightness ==
                                        Brightness.dark)
                            ? 'assets/images/app_logo_dark.png'
                            : 'assets/images/app_logo_light.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  // const SizedBox(height: 5),
//                 ShaderMask(
//   shaderCallback: (bounds) {
//     return  LinearGradient(
//       colors: [
//         Theme.of(context).colorScheme.secondary,
//         Theme.of(context).colorScheme.primary,

//       ],
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//     ).createShader(
//       Rect.fromLTWH(0, 0, bounds.width, bounds.height),
//     );
//   },
//   child: Text(
//     'app_name'.tr,
//     style: const TextStyle(
//       fontSize: 32,
//       fontWeight: FontWeight.bold,
//       color: Colors.white, // IMPORTANT
//     ),
//   ),
// ),

                  const SizedBox(height: 8),
                  Text(
                    'app_subtitle'.tr,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                  const SizedBox(height: 32),

                  // Role Selection
                  RoleSelectionWidget(
                    selectedRole: selectedRole,
                    onRoleChanged: (role) {
                      setState(() {
                        selectedRole = role;
                      });
                    },
                  ),
                  const SizedBox(height: 24),

                  // Email Field
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'email'.tr,
                      labelStyle: context.theme.textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Color(0xff9ca3af),
                      ),
                      filled: true,
                      fillColor: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest
                          .withOpacity(0.3),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.7),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'password'.tr,
                      labelStyle: context.theme.textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color(0xff9ca3af),
                      ),
                      suffixIcon: const Icon(
                        Icons.visibility_rounded,
                        color: Color(0xff9ca3af),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.7),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest
                          .withOpacity(0.3),
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
                              color: Theme.of(context)
                                  .colorScheme
                                  .onErrorContainer,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                authController.errorMessage,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onErrorContainer,
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
                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: authController.isLoading
                            ? null
                            : () {
                                authController..clearError()
                                ..login(
                                  emailController.text.trim(),
                                  passwordController.text,
                                  // selectedRole: selectedRole,
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:  Theme.of(context).colorScheme.secondary,
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
                                    Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              )
                            : Text('login'.tr),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Demo Credentials
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'demo_credentials'.tr,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
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
        ),
      ),
    );
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
}
