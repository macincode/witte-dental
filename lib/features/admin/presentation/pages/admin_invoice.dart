import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/widgets/network_aware_widget.dart';
import '../../../../core/theme/app_theme.dart';

class AdminInvoice extends StatefulWidget {
  const AdminInvoice({super.key});

  @override
  State<AdminInvoice> createState() => _AdminInvoiceState();
}

class _AdminInvoiceState extends State<AdminInvoice> {

  @override
  Widget build(BuildContext context) {
    return NetworkAwareWidget(
        child: Scaffold(
      // drawer: const RoleBasedDrawer(),
      appBar: AppBar(
        title: const Text('Admin Invoice'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildDashboardCard(
                    context,
                    'Invoice Amount',
                    Icons.group,
                    '27k',
                  ),
                  const SizedBox(height: 16),
                  _buildDashboardCard(
                    context,
                    'Billed Amount',
                    Icons.medical_services,
                    '7.45k',
                  ),
                  const SizedBox(height: 16),
                  _buildDashboardCard(
                    context,
                    'Payment Amount',
                    Icons.people,
                    '100k',
                  ),
                  const SizedBox(height: 16),
                  _buildDashboardCard(
                    context,
                    'Doctors',
                    Icons.monitor_heart,
                    '2',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildDashboardCard(
    BuildContext context,
    String title,
    IconData icon,
    String amt,
    // Color color,
  ) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1,
                        color: Theme.of(context).colorScheme.onPrimary),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    size: 24,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),

            // const SizedBox(height: 4),
            Text(
              '₹ ${amt}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold
                        ,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
