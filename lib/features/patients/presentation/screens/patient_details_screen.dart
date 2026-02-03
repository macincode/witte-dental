import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/patient_model.dart';

class PatientDetailsScreen extends StatelessWidget {
  const PatientDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final patient = Get.arguments as Patient;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const primaryBlue = Color(0xFF145BD9);
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text(patient.fullName),
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileHeader(patient, cardColor, isDark, primaryBlue),
            const SizedBox(height: 20),
            _buildInfoCard(
              'Personal Information',
              [
                _buildInfoRow('Email', patient.email, Icons.email),
                _buildInfoRow('Phone', patient.phone, Icons.phone),
                _buildInfoRow('Date of Birth', patient.dob, Icons.cake),
                _buildInfoRow('Age', '${patient.age} years', Icons.person),
                _buildInfoRow('Gender', patient.gender,
                    patient.gender == 'Male' ? Icons.male : Icons.female),
              ],
              cardColor,
              isDark,
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              'Address & Contact',
              [
                _buildInfoRow('Address', patient.address, Icons.location_on),
                _buildInfoRow(
                    'Profession',
                    patient.profession.isEmpty
                        ? 'Not specified'
                        : patient.profession,
                    Icons.work),
                if (patient.primaryContactName.isNotEmpty)
                  _buildInfoRow('Emergency Contact', patient.primaryContactName,
                      Icons.contact_emergency),
                if (patient.relationship.isNotEmpty)
                  _buildInfoRow('Relationship', patient.relationship,
                      Icons.family_restroom),
              ],
              cardColor,
              isDark,
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              'Account Information',
              [
                _buildInfoRow('Patient ID', '#${patient.id}', Icons.badge),
                _buildInfoRow(
                    'User ID', '#${patient.userId}', Icons.account_circle),
                _buildInfoRow('Status',
                    patient.status == 1 ? 'Active' : 'Inactive', Icons.info),
                _buildInfoRow('Registered', patient.createdAt.split(' ')[0],
                    Icons.calendar_today),
              ],
              cardColor,
              isDark,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(
      Patient patient, Color cardColor, bool isDark, Color primaryBlue) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[300],
            child: patient.image.isNotEmpty
                ? ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: patient.image,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.grey[600],
                      ),
                    ),
                  )
                : Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.grey[600],
                  ),
          ),
          const SizedBox(height: 16),
          Text(
            patient.fullName,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Patient',
              style: TextStyle(
                color: primaryBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
      String title, List<Widget> children, Color cardColor, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: const Color(0xFF145BD9),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
