import 'package:flutter/material.dart';

class PharmacylistManagement extends StatefulWidget {
  const PharmacylistManagement({super.key});

  @override
  State<PharmacylistManagement> createState() => _PharmacylistManagementState();
}

class _PharmacylistManagementState extends State<PharmacylistManagement> {
  int? _selectedIndex;
  final List<String> _options = [
    'All Items',
    'Materials',
    'Instruments',
    'Equipments',
    'Stationary',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('All Medicines List'),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search medicines by name...',
                        hintStyle:
                            TextStyle(color: Colors.grey[400], fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surface,
                        prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.tune,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                // const SizedBox(width: 8),
                // DecoratedBox(
                //   decoration: BoxDecoration(
                //     color: Theme.of(context).colorScheme.primary,
                //     borderRadius: BorderRadius.circular(12),
                //   ),
                //   child: IconButton(
                //     onPressed: _showAddCategoryDialog,
                //     icon: const Icon(Icons.add, color: Colors.white),
                //   ),
                // ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              itemCount: 20,
              itemBuilder: (context, index) {
                final categories = [
                  'Toothbrush & Interdental Aids',
                  'Oral Gels',
                ];
                final icons = [
                  Icons.medical_services,
                  Icons.content_cut,
                ];
                final colors = [
                  Colors.blue,
                  Colors.green,
                ];

                final categoryName = categories[index % categories.length];
                final category = [
                  'STIM FLOSS',
                  'MUCOPAIN 15GM GEL',
                ];
                final categorynum = category[index % categories.length];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    categoryName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  // const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      Text(
                                        '•',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: Colors.grey[600],
                                            ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        categorynum,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: Colors.grey[600],
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.09),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'In Stock',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.09),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Stock Available:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                  ),
                                  Text(
                                    '6',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.09),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Price (₹):',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                  ),
                                  Text(
                                    '6',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          spacing: 10,
                          children: [
                            Expanded(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context).colorScheme.secondary,
                                      Theme.of(context).colorScheme.primary,
                                    ],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.3),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    AddPharmacyHelper.addPharmacySheet(context);
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    'Edit',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context)
                                          .colorScheme
                                          .error
                                          .withOpacity(0.4),
                                      Theme.of(context)
                                          .colorScheme
                                          .error
                                          .withOpacity(0.9),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.red.withOpacity(0.3),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.delete,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AddPharmacyHelper {
  static void addPharmacySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.70,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Add New Medicine',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildFormField(
                          context,
                          'Category',
                          isRequired: true,
                          child: DropdownButtonFormField<String>(
                            decoration: _getInputDecoration(
                              context,
                            ),
                            items: ['Antibiotics', 'Steroids']
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {},
                          ),
                        ),
                        _buildFormField(
                          context,
                          'Medicine Name',
                          isRequired: true,
                          child: TextField(
                            decoration: _getInputDecoration(
                              context,
                              'Enter medicine name',
                            ),
                          ),
                        ),
                        _buildFormField(
                          context,
                          'Stock Quantity',
                          isRequired: true,
                          child: TextField(
                            decoration: _getInputDecoration(
                              context,
                              'Enter stock quantity',
                            ),
                          ),
                        ),
                        _buildFormField(
                          context,
                          'Price (₹) ',
                          isRequired: true,
                          child: TextField(
                            decoration: _getInputDecoration(
                              context,
                              'Enter price',
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context)
                                          .colorScheme
                                          .onSecondary
                                          .withOpacity(0.02),
                                      Theme.of(context)
                                          .colorScheme
                                          .onSecondary
                                          .withOpacity(0.5),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  border: Border.all(
                                    width: 0.5,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: ElevatedButton.icon(
                                  onPressed: () {},
                                  label: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context).colorScheme.secondary,
                                      Theme.of(context).colorScheme.primary,
                                    ],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text('Submit'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildFormField(
    BuildContext context,
    String title, {
    required Widget child,
    bool isRequired = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: RichText(
              text: TextSpan(
                text: title,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
                children: [
                  if (isRequired)
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  static InputDecoration _getInputDecoration(
    BuildContext context, [
    String? label,
    IconData? icon,
  ]) {
    return InputDecoration(
      hintText: label,
      hintStyle: label != null
          ? TextStyle(
              color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.5),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            )
          : null,
      prefixIcon: icon != null
          ? Icon(
              icon,
              color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.7),
            )
          : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
      ),
      filled: true,
      fillColor: Theme.of(context).colorScheme.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
    );
  }
}
