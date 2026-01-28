import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_constants.dart';

class RoleSelectionWidget extends StatelessWidget {
  const RoleSelectionWidget({
    required this.onRoleChanged,
    super.key,
    this.selectedRole,
  });
  final String? selectedRole;
  final Function(String?) onRoleChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'select_role'.tr,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildRoleCard(
                context,
                AppConstants.roleDoctor,
                Icons.medical_services,
                'Doctor',
                Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildRoleCard(
                context,
                AppConstants.rolePatient,
                Icons.person,
                'Patient',
                Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildRoleCard(
                context,
                AppConstants.roleAdmin,
                Icons.admin_panel_settings,
                'Admin',
                Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildRoleCard(
                context,
                AppConstants.roleStaff,
                Icons.support_agent,
                'Staff',
                Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRoleCard(
    BuildContext context,
    String role,
    IconData icon,
    String title,
    Color color,
  ) {
    final isSelected = selectedRole == role;

    return GestureDetector(
      onTap: () => onRoleChanged(role),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withOpacity(0.1)
              : Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest
                  .withOpacity(0.3),
          border: Border.all(
            color: isSelected
                ? color
                : Theme.of(context).colorScheme.outline.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? color
                  : Theme.of(context).colorScheme.onSecondary,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isSelected
                        ? color
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
