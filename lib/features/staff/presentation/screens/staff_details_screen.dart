import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/staff_model.dart';

class StaffDetailsScreen extends StatelessWidget {
  const StaffDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final staff = Get.arguments as Staff;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const primaryBlue = Color(0xFF145BD9);
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text(staff.fullName),
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileHeader(staff, cardColor, isDark, primaryBlue),
            const SizedBox(height: 20),
            _buildInfoCard(
              'Personal Information',
              [
                _buildInfoRow('Email', staff.email, Icons.email),
                _buildInfoRow('Phone', staff.phone, Icons.phone),
                _buildInfoRow('Date of Birth', staff.dob, Icons.cake),
                _buildInfoRow('Age', '${staff.age} years', Icons.person),
                _buildInfoRow('Gender', staff.gender,
                    staff.gender == 'Male' ? Icons.male : Icons.female),
              ],
              cardColor,
              isDark,
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              'Professional Information',
              [
                _buildInfoRow('Category', staff.staffCategory, Icons.work),
                _buildInfoRow(
                    'Qualification', staff.qualification, Icons.school),
                _buildInfoRow('Address', staff.address, Icons.location_on),
              ],
              cardColor,
              isDark,
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              'Account Information',
              [
                _buildInfoRow('Staff ID', '#${staff.id}', Icons.badge),
                _buildInfoRow(
                    'Category ID', '#${staff.staffCategoryId}', Icons.category),
                _buildInfoRow('Status',
                    staff.status == 1 ? 'Active' : 'Inactive', Icons.info),
                _buildInfoRow('Joined', staff.createdAt.split(' ')[0],
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
      Staff staff, Color cardColor, bool isDark, Color primaryBlue) {
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
            child: staff.image.isNotEmpty
                ? ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: staff.image,
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
            staff.fullName,
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
              staff.staffCategory,
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
