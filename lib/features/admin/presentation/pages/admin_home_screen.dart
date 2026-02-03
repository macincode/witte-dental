import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:witte_dental_pms/core/controllers/language_controller.dart';
import 'package:witte_dental_pms/core/controllers/theme_controller.dart';
import 'package:witte_dental_pms/features/admin/presentation/controllers/admin_dashboard_controller.dart';
import 'package:witte_dental_pms/features/auth/presentation/controllers/auth_controller.dart';
import 'package:witte_dental_pms/features/dashboard/presentation/screens/hospital_dashboard_screen.dart';
import 'package:witte_dental_pms/features/shared/widgets/network_aware_widget.dart';
import 'package:witte_dental_pms/features/shared/widgets/role_based_drawer.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final themeController = Get.find<ThemeController>();
  final authController = Get.find<AuthController>();
  late AdminDashboardController _controller;
  DateTime? _lastBackPressed;

  // Brand Colors
  final Color _primaryBlue = const Color(0xFF145BD9);
  final Color _lightBlue = const Color(0xFF07BDFF);

  @override
  void initState() {
    super.initState();
    _controller = Get.put(AdminDashboardController(Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authController.loadAdminDashboard();
    });
  }

  IconData _getThemeIcon(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return Icons.wb_sunny_rounded;
      case AppThemeMode.dark:
        return Icons.nightlight_round;
      case AppThemeMode.system:
        return Icons.auto_mode_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FD);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: NetworkAwareWidget(
        child: Scaffold(
          backgroundColor: backgroundColor,
          drawer: const RoleBasedDrawer(),
          body: Obx(() {
            if (authController.isLoading) {
              return Center(
                child: CircularProgressIndicator(color: _primaryBlue),
              );
            }

            if (authController.errorMessage.isNotEmpty) {
              return _buildErrorState(context);
            }

            final adminDashboard = authController.adminDashboard;
            if (adminDashboard == null) {
              return const Center(child: Text('No data available'));
            }

            return RefreshIndicator(
              onRefresh: authController.loadAdminDashboard,
              color: _primaryBlue,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  _buildSliverAppBar(context, isDark),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        _buildGreetingHeader(
                          context,
                          adminDashboard.data.business.ownerName,
                        ),
                        const SizedBox(height: 12),
                        _buildBusinessHero(
                          context,
                          adminDashboard.data.business,
                        ),
                        const SizedBox(height: 16),
                        _buildSectionTitle(context, 'Analytics Overview'),
                        _buildModernStatsGrid(
                          context,
                          adminDashboard.data.stats,
                          isDark,
                        ),
                        const SizedBox(height: 24),
                        _buildSectionTitle(context, 'Hospital Branches'),
                        _buildHospitalsList(
                          context,
                          adminDashboard.data.hospitals,
                          isDark,
                        ),
                        const SizedBox(height: 40), // Bottom padding
                      ]),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  // --- UI Components ---

  Widget _buildSliverAppBar(BuildContext context, bool isDark) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      elevation: 0,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black87),
      title: Text(
        'Dashboard',
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        _buildThemeAction(),
        IconButton(
          onPressed: () => Get.find<LanguageController>().showLanguageDialog(),
          icon: const Icon(Icons.language_rounded),
          tooltip: 'change_language'.tr,
        ),
        IconButton(
          onPressed: () => _showLogoutDialog(context),
          icon: const Icon(Icons.logout_rounded),
          tooltip: 'logout'.tr,
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildThemeAction() {
    return Obx(
      () => PopupMenuButton<AppThemeMode>(
        icon: Icon(_getThemeIcon(themeController.currentThemeMode)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onSelected: themeController.setThemeMode,
        itemBuilder: (context) => [
          _buildPopupMenuItem(
            AppThemeMode.light,
            Icons.wb_sunny_rounded,
            'Light',
          ),
          _buildPopupMenuItem(
            AppThemeMode.dark,
            Icons.nightlight_round,
            'Dark',
          ),
          _buildPopupMenuItem(
            AppThemeMode.system,
            Icons.auto_mode_rounded,
            'System',
          ),
        ],
      ),
    );
  }

  PopupMenuItem<AppThemeMode> _buildPopupMenuItem(
    AppThemeMode mode,
    IconData icon,
    String text,
  ) {
    return PopupMenuItem(
      value: mode,
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Text(text),
          if (themeController.currentThemeMode == mode) ...[
            const Spacer(),
            Icon(Icons.check, color: _primaryBlue, size: 18),
          ],
        ],
      ),
    );
  }

  Widget _buildGreetingHeader(BuildContext context, String? ownerName) {
    final hour = DateTime.now().hour;
    var greeting = 'Good Morning';
    if (hour >= 12 && hour < 17) greeting = 'Good Afternoon';
    if (hour >= 17) greeting = 'Good Evening';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          greeting + ', ' + (ownerName ?? 'Admin'),
          style: TextStyle(
            color: Theme.of(context).textTheme.bodySmall?.color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessHero(BuildContext context, dynamic business) {
    // Safe data extraction (assuming your Business model maps these fields)
    final sub = business.subscription;
    final planName = sub?.plan?.name ?? 'Standard Plan';
    final status = sub?.status ?? 'inactive';
    final isActive = status == 'active';
    
    // Parse date safely
    String expiryText = 'N/A';
    if (sub?.currentPeriodEnd != null) {
      final date = DateTime.tryParse(sub.currentPeriodEnd.toString());
      if (date != null) {
        expiryText = "${date.day}/${date.month}/${date.year}";
      }
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [_primaryBlue, _lightBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: _primaryBlue.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Decor
          Positioned(
            right: -20,
            top: -20,
            child: Icon(
              Icons.business,
              size: 150,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Type and Status Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        (business.businessType ?? 'Business').toString().toUpperCase().replaceAll('_', ' '),
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Subscription Status Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: isActive ? Colors.greenAccent.shade400 : Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                           BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0,2))
                        ]
                      ),
                      child: Row(
                        children: [
                          Icon(isActive ? Icons.check_circle : Icons.warning, size: 12, color: Colors.black87),
                          const SizedBox(width: 4),
                          Text(
                            status.toString().toUpperCase(),
                            style: const TextStyle(color: Colors.black87, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                
                // Business Name
                Text(
                  business.name ?? 'Unknown Business',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                
                // Owner Info
                Row(
                  children: [
                    const Icon(Icons.verified_user_outlined, color: Colors.white70, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      'Owner: ${business.ownerName ?? 'N/A'}',
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                Divider(color: Colors.white.withOpacity(0.2)),
                const SizedBox(height: 10),

                // Plan & Expiry Footer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('CURRENT PLAN', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 10, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 2),
                        Text(planName, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('RENEWS ON', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 10, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 2),
                        Text(expiryText, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildModernStatsGrid(
    BuildContext context,
    dynamic stats,
    bool isDark,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
          childAspectRatio: 1.3,
          children: [
            _buildStatItem(
              context,
              'Hospitals',
              stats.totalHospitals.toString(),
              Icons.domain_add_rounded,
              _lightBlue,
              isDark,
            ),
            _buildStatItem(
              context,
              'Patients',
              stats.totalPatients.toString(),
              Icons.people_alt_rounded,
              _primaryBlue,
              isDark,
            ),
            _buildStatItem(
              context,
              'Staff',
              stats.totalStaff.toString(),
              Icons.badge_rounded,
              _primaryBlue,
              isDark,
            ),
            _buildStatItem(
              context,
              'Today',
              stats.appointmentsToday.toString(),
              Icons.calendar_month_rounded,
              _lightBlue,
              isDark,
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color accentColor,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            bottom: -10,
            child: Icon(
              icon,
              size: 60,
              color: accentColor.withOpacity(0.1),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: accentColor, size: 20),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHospitalsList(BuildContext context, List<dynamic> hospitals, bool isDark) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: hospitals.length,
      separatorBuilder: (c, i) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final hospital = hospitals[index];
        
        // Handle both Hospital objects and Map<String, dynamic>
        final bool isMain;
        final String city;
        final String state;
        final int hospitalId;
        final String hospitalName;
        
        if (hospital is Map<String, dynamic>) {
          isMain = hospital['is_main'] ?? false;
          final address = hospital['address'] as Map<String, dynamic>?;
          city = address?['city'] ?? 'Unknown City';
          state = address?['state'] ?? '';
          hospitalId = hospital['id'];
          hospitalName = hospital['name'];
        } else {
          // Assume it's a Hospital object
          isMain = hospital.isMain;
          city = hospital.address?['city'] ?? 'Unknown City';
          state = hospital.address?['state'] ?? '';
          hospitalId = hospital.id;
          hospitalName = hospital.name;
        }
        
        return Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isMain ? _primaryBlue.withOpacity(0.3) : Colors.transparent,
              width: 1.5,
            ),
            boxShadow: [
              if (!isDark)
                BoxShadow(
                  color: Colors.grey.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Get.to(() => HospitalDashboardScreen(
                      hospitalId: hospitalId,
                      hospitalName: hospitalName,
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Icon Container
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isMain ? _primaryBlue.withOpacity(0.1) : _lightBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Icon(
                          isMain ? Icons.star_rounded : Icons.local_hospital_rounded,
                          color: isMain ? _primaryBlue : _lightBlue,
                          size: 26,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Info Column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  hospitalName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (isMain) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _primaryBlue,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text('MAIN', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                                )
                              ]
                            ],
                          ),
                          const SizedBox(height: 4),
                          // Location Row
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined, size: 12, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  "$city, $state", 
                                  style: TextStyle(
                                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          // Code & License
                          Text(
                            'Code: ${hospital.code}',
                            style: TextStyle(
                              color: isDark ? Colors.grey[500] : Colors.grey[500],
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: isDark ? Colors.grey[600] : Colors.grey[300],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 40,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Unable to load dashboard',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              authController.errorMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton.icon(
                onPressed: () {
                  authController.clearError();
                  authController.loadAdminDashboard();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Try Again'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    final now = DateTime.now();
    if (_lastBackPressed == null ||
        now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
      _lastBackPressed = now;
      Get.snackbar(
        'Press again to exit',
        'Tap back again to close the app',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black87,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 2),
      );
      return false;
    }
    return true;
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Logout'),
          content: const Text(
            'Are you sure you want to exit your business session?',
          ),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                authController.logout();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
