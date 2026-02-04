import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../data/models/patient_model.dart';

class PatientDetailsScreen extends StatefulWidget {
  const PatientDetailsScreen({super.key});

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = [
    'Summary',
    'Appointments',
    'Diagnosis',
    'Treatment Plan',
    'Medical Report',
    'Prescription',
    'PACS',
    'Payment',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Rebuild to update chip selection
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final patient = Get.arguments as Patient;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    const primaryBlue = Color(0xFF145BD9);
    final bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FD);
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(patient.fullName),
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Smart Card
            _PatientSmartCard(patient: patient),

            // Call Action Row
            _CallActionRow(patient: patient),

            // Emergency Information Card
            _EmergencyInfoCard(
                patient: patient, cardColor: cardColor, textColor: textColor),

            // Chip-style Tabs
            _ChipTabs(
                tabController: _tabController,
                tabs: _tabs,
                primaryBlue: primaryBlue,
                cardColor: cardColor,
                textColor: textColor),

            // Tab Content
            SizedBox(
              height: 400,
              child: TabBarView(
                controller: _tabController,
                children: const [
                  SummaryTab(),
                  AppointmentsTab(),
                  DiagnosisTab(),
                  TreatmentPlanTab(),
                  MedicalReportTab(),
                  PrescriptionTab(),
                  PACSTab(),
                  PaymentTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- New Widget Components ---

class _PatientSmartCard extends StatelessWidget {
  const _PatientSmartCard({required this.patient});
  final Patient patient;

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF145BD9);

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: primaryBlue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white.withOpacity(0.2),
                  ),
                  child: _buildHospitalLogo(),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getHospitalName(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'UHID: #${patient.id}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Content - ID Card Layout
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Left: Profile Photo
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!, width: 2),
                  ),
                  child: patient.image.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: patient.image,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.grey),
                            errorWidget: (context, url, error) => const Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.grey),
                          ),
                        )
                      : const Icon(Icons.person, size: 40, color: Colors.grey),
                ),

                const SizedBox(width: 20),

                // Right: Primary Information
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Patient Name
                      Text(
                        patient.fullName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Basic Info Row
                      Row(
                        children: [
                          _buildInfoChip(
                              '${patient.age}Y', Icons.cake, Colors.blue),
                          const SizedBox(width: 8),
                          _buildInfoChip(
                              patient.gender, Icons.wc, Colors.purple),
                          const SizedBox(width: 8),
                          _buildInfoChip('O+', Icons.bloodtype,
                              Colors.red), // TODO: Use patient.bloodGroup
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Patient ID
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF145BD9).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: const Color(0xFF145BD9).withOpacity(0.3)),
                        ),
                        child: Text(
                          'Patient ID: #${patient.id}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF145BD9),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Date of Birth
                      Text(
                        'DOB: ${patient.dob}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHospitalLogo() {
    try {
      final authController = Get.find<AuthController>();
      final adminDashboard = authController.adminDashboard;

      if (adminDashboard?.data.hospitals.isNotEmpty ?? false) {
        final hospital = adminDashboard!.data.hospitals.first;
        final logoUrl = hospital.logo;

        if (logoUrl != null && logoUrl.isNotEmpty) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: logoUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Icon(Icons.local_hospital,
                  size: 24, color: Colors.white),
              errorWidget: (context, url, error) => const Icon(
                  Icons.local_hospital,
                  size: 24,
                  color: Colors.white),
            ),
          );
        }
      }
    } catch (e) {
      // Fallback if AuthController not found
    }
    return const Icon(Icons.local_hospital, size: 24, color: Colors.white);
  }

  String _getHospitalName() {
    try {
      final authController = Get.find<AuthController>();
      final adminDashboard = authController.adminDashboard;

      if (adminDashboard?.data.hospitals.isNotEmpty ?? false) {
        return adminDashboard!.data.hospitals.first.name;
      }
    } catch (e) {
      // Fallback if AuthController not found
    }
    return 'Witte Dental Hospital';
  }

  Widget _buildInfoChip(String text, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _CallActionRow extends StatelessWidget {
  const _CallActionRow({required this.patient});
  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
              child: _buildActionButton(Icons.call, 'Call', Colors.green,
                  () => _makeCall(patient.phone))),
          const SizedBox(width: 12),
          Expanded(
              child: _buildActionButton(Icons.email, 'Email', Colors.orange,
                  () => _sendEmail(patient.email))),
          const SizedBox(width: 12),
          Expanded(
              child: _buildActionButton(Icons.location_on, 'Address',
                  Colors.blue, () => _showAddress(patient.address))),
          const SizedBox(width: 12),
          Expanded(
              child: _buildActionButton(Icons.edit, 'Edit',
                  const Color(0xFF145BD9), _showComingSoon)),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 4),
            Text(label,
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w600, color: color)),
          ],
        ),
      ),
    );
  }

  void _makeCall(String phone) {
    Get.snackbar('Call', 'Calling $phone', snackPosition: SnackPosition.BOTTOM);
  }

  void _sendEmail(String email) {
    Get.snackbar('Email', 'Opening email to $email',
        snackPosition: SnackPosition.BOTTOM);
  }

  void _showAddress(String address) {
    Get.snackbar('Address', address, snackPosition: SnackPosition.BOTTOM);
  }

  void _showComingSoon() {
    Get.snackbar('Coming Soon', 'Edit feature will be available soon',
        snackPosition: SnackPosition.BOTTOM);
  }
}

class _EmergencyInfoCard extends StatelessWidget {
  const _EmergencyInfoCard(
      {required this.patient,
      required this.cardColor,
      required this.textColor});
  final Patient patient;
  final Color cardColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.contact_emergency, color: Colors.red[600], size: 20),
              const SizedBox(width: 8),
              Text(
                'Emergency Information',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.person, 'Contact Name',
              patient.primaryContactName, textColor),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.family_restroom, 'Relationship',
              patient.relationship, textColor),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
      IconData icon, String label, String value, Color textColor) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[500]),
        const SizedBox(width: 8),
        Text('$label: ',
            style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: textColor),
          ),
        ),
      ],
    );
  }
}

class _ChipTabs extends StatelessWidget {
  const _ChipTabs({
    required this.tabController,
    required this.tabs,
    required this.primaryBlue,
    required this.cardColor,
    required this.textColor,
  });
  final TabController tabController;
  final List<String> tabs;
  final Color primaryBlue;
  final Color cardColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final isSelected = tabController.index == index;
          return GestureDetector(
            onTap: () => tabController.animateTo(index),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? primaryBlue : cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                      isSelected ? primaryBlue : Colors.grey.withOpacity(0.3),
                ),
              ),
              child: Center(
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : textColor,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// --- UI Components ---
// --- Delegate for Sticky Tab Bar ---
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar, this._backgroundColor);
  final TabBar _tabBar;
  final Color _backgroundColor;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(
      color: _backgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

// --- Tab Content Classes (Placeholders) ---

class SummaryTab extends StatelessWidget {
  const SummaryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: _ComingSoonPlaceholder(title: 'Additional Patient Summary'),
    );
  }
}

class AppointmentsTab extends StatelessWidget {
  const AppointmentsTab({super.key});
  @override
  Widget build(BuildContext context) =>
      const _ComingSoonPlaceholder(title: 'Appointments History');
}

class DiagnosisTab extends StatelessWidget {
  const DiagnosisTab({super.key});
  @override
  Widget build(BuildContext context) =>
      const _ComingSoonPlaceholder(title: 'Diagnosis Records');
}

class TreatmentPlanTab extends StatelessWidget {
  const TreatmentPlanTab({super.key});
  @override
  Widget build(BuildContext context) =>
      const _ComingSoonPlaceholder(title: 'Treatment Plans');
}

class MedicalReportTab extends StatelessWidget {
  const MedicalReportTab({super.key});
  @override
  Widget build(BuildContext context) =>
      const _ComingSoonPlaceholder(title: 'Medical Reports');
}

class PrescriptionTab extends StatelessWidget {
  const PrescriptionTab({super.key});
  @override
  Widget build(BuildContext context) =>
      const _ComingSoonPlaceholder(title: 'Prescriptions');
}

class PACSTab extends StatelessWidget {
  const PACSTab({super.key});
  @override
  Widget build(BuildContext context) =>
      const _ComingSoonPlaceholder(title: 'PACS / Imaging');
}

class PaymentTab extends StatelessWidget {
  const PaymentTab({super.key});
  @override
  Widget build(BuildContext context) =>
      const _ComingSoonPlaceholder(title: 'Billing & Payments');
}

class _ComingSoonPlaceholder extends StatelessWidget {
  const _ComingSoonPlaceholder({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.construction, size: 40, color: Colors.blue),
          ),
          const SizedBox(height: 16),
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            'This feature is coming soon.',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
