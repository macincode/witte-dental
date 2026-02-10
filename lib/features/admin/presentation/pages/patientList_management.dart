import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:witte_dental_pms/features/admin/presentation/controllers/admin_patient_controller.dart';

class PatientlistManagement extends StatefulWidget {
  const PatientlistManagement({super.key});

  @override
  State<PatientlistManagement> createState() => _PatientlistManagementState();
}

class _PatientlistManagementState extends State<PatientlistManagement> {
  final AdminPatientController _patientController =
      Get.put(AdminPatientController());
  final TextEditingController _searchController = TextEditingController();
  final RxList<dynamic> _filteredPatients = <dynamic>[].obs;
  String? _selectedFilter;
  String? _selectedFilterValue;

  @override
  void initState() {
    super.initState();
    _filteredPatients.value = _patientController.adminPatientList;
  }

  void _filterPatients(String query) {
    List<dynamic> patients = _patientController.adminPatientList.toList();

    if (_selectedFilter != null && _selectedFilterValue != null) {
      patients = patients.where((patient) {
        return (patient as Map)[_selectedFilter] == _selectedFilterValue;
      }).toList();
    }

    if (query.isEmpty) {
      _filteredPatients.value = patients;
    } else {
      _filteredPatients.value = patients.where((patient) {
        final pat = patient as Map;
        final name = '${pat['first_name']} ${pat['surname']}'.toLowerCase();
        final phone = (pat['phone'] ?? '').toString().toLowerCase();
        final regNo = (pat['patient_reg_no'] ?? '').toString().toLowerCase();
        final searchLower = query.toLowerCase();
        return name.contains(searchLower) ||
            phone.contains(searchLower) ||
            regNo.contains(searchLower);
      }).toList();
    }
  }

  void _showFilterOptions(String filterType) {
    final values = _patientController.adminPatientList
        .map((p) => (p as Map)[filterType])
        .where((v) => v != null && v.toString().isNotEmpty)
        .toSet()
        .toList();

    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 8,
      color: Theme.of(context).colorScheme.surface,
      items: values
          .map((value) => PopupMenuItem(
                value: value,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 18,
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.7),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        value.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    ).then((selectedValue) {
      if (selectedValue != null) {
        setState(() {
          _selectedFilter = filterType;
          _selectedFilterValue = selectedValue.toString();
        });
        _filterPatients(_searchController.text);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Patient List'),
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
                      controller: _searchController,
                      onChanged: _filterPatients,
                      decoration: InputDecoration(
                        hintText: 'Search by patient name,mobile...',
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
                PopupMenuButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 8,
                  offset: const Offset(0, 50),
                  icon: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Icon(
                        Icons.tune,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'gender',
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Icon(Icons.person,
                              size: 20,
                              color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 12),
                          const Text('Gender'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'patient_type',
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Icon(Icons.category,
                              size: 20,
                              color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 12),
                          const Text('Patient Type'),
                        ],
                      ),
                    ),
                    if (_selectedFilter != null)
                      PopupMenuItem(
                        value: 'clear',
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            Icon(Icons.clear, size: 20, color: Colors.red[400]),
                            const SizedBox(width: 12),
                            Text('Clear Filter',
                                style: TextStyle(color: Colors.red[400])),
                          ],
                        ),
                      ),
                  ],
                  onSelected: (value) {
                    if (value == 'clear') {
                      setState(() {
                        _selectedFilter = null;
                        _selectedFilterValue = null;
                      });
                      _filterPatients(_searchController.text);
                    } else {
                      _showFilterOptions(value.toString());
                    }
                  },
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
            child: Obx(
              () => ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                itemCount: _filteredPatients.length,
                itemBuilder: (context, index) {
                  final patient = _filteredPatients[index];
                  final patientId = patient['id'] ?? '';
                  final patientName =
                      '${patient['first_name']} ${patient['surname']}';
                  final phone = patient['phone'] ?? '';
                  final regNo = patient['patient_reg_no'] ?? 'N/A';
                  final age = patient['age'] ?? 'N/A';
                  final gender = patient['gender'] ?? '';
                  final status = patient['status'] == 1 ? 'Active' : 'Inactive';
                  final createdAt = patient['created_at'] ?? '';

                  final colors = [
                    Colors.blue,
                    Colors.green,
                    Colors.orange,
                    Colors.purple
                  ];
                  final categoryColor = colors[index % colors.length];

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
                              Container(
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: categoryColor.withOpacity(0.1),
                                  // borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  patientName.isNotEmpty ? patientName[0] : 'P',
                                  style: TextStyle(
                                    color: categoryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      patientName,
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
                                        Icon(
                                          Icons.phone,
                                          size: 14,
                                          color: Colors.grey[600],
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          phone,
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
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
                                    child: Text(
                                      'Age: $age • $gender',
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
                                  ),
                                  const SizedBox(height: 4),
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
                                    child: Text(
                                      status,
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
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.08),
                                  Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.03),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.3),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.schedule_outlined,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Registered:',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary,
                                              fontSize: 11,
                                            ),
                                      ),
                                      Text(
                                        createdAt.isNotEmpty
                                            ? createdAt.split(' ')[0]
                                            : 'N/A',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontWeight: FontWeight.w600,
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
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.3),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    regNo,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 11,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            spacing: 5,
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
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.visibility_outlined,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                    label: const Text(
                                      'View',
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
                                      AddPatientHelper.addPatientSheet(context,
                                          patientData: patient);
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
                                    onPressed: () {
                                      _patientController
                                          .deletePatientData(patient['id'].toString());
                                    },
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
          ),
        ],
      ),
    );
  }
}

class AddPatientHelper {
  static void addPatientSheet(BuildContext context,
      {Map<String, dynamic>? patientData}) {
    final firstNameController =
        TextEditingController(text: patientData?['first_name']);
    final surnameController =
        TextEditingController(text: patientData?['surname']);
    final phoneController = TextEditingController(text: patientData?['phone']);
    final emailController = TextEditingController(text: patientData?['email']);
    final dobController = TextEditingController(text: patientData?['dob']);
    final ageController =
        TextEditingController(text: patientData?['age']?.toString());
    final regNoController =
        TextEditingController(text: patientData?['patient_reg_no']);
    final professionController =
        TextEditingController(text: patientData?['profession']);
    final addressController =
        TextEditingController(text: patientData?['address']);
    final contactNameController =
        TextEditingController(text: patientData?['primary_contact_name']);
    final relationshipController =
        TextEditingController(text: patientData?['relationship']);
    final contactMobileController =
        TextEditingController(text: patientData?['contact_mobile']);
    String? selectedGender = patientData?['gender'];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.85,
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
                      patientData != null ? 'Edit Patient' : 'Add Patient',
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
                          'First Name',
                          isRequired: true,
                          child: TextField(
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary
                                      .withOpacity(0.8),
                                ),
                            controller: firstNameController,
                            decoration: _getInputDecoration(context),
                          ),
                        ),
                        _buildFormField(
                          context,
                          'Last Name',
                          isRequired: true,
                          child: TextField(
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary
                                      .withOpacity(0.8),
                                ),
                            controller: surnameController,
                            decoration: _getInputDecoration(context),
                          ),
                        ),
                        _buildFormField(
                          context,
                          'Mobile Number',
                          isRequired: true,
                          child: TextField(
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary
                                      .withOpacity(0.8),
                                ),
                            controller: phoneController,
                            decoration: _getInputDecoration(
                              context,
                              'Enter mobile number',
                              Icons.phone,
                            ),
                          ),
                        ),
                        _buildFormField(
                          context,
                          'Date of Birth',
                          isRequired: true,
                          child: TextField(
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary
                                      .withOpacity(0.8),
                                ),
                            controller: dobController,
                            decoration: _getInputDecoration(
                              context,
                              'MM/DD/YYYY',
                              Icons.calendar_today,
                            ),
                            readOnly: true,
                            onTap: () async {
                              final pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 365)),
                              );
                              if (pickedDate != null) {
                                dobController.text =
                                    '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
                              }
                            },
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: _buildFormField(
                                context,
                                isRequired: true,
                                'Age',
                                child: TextField(
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary
                                            .withOpacity(0.8),
                                      ),
                                  controller: ageController,
                                  decoration: _getInputDecoration(
                                    context,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildFormField(
                                context,
                                'Gender',
                                isRequired: true,
                                child: DropdownButtonFormField<String>(
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary
                                            .withOpacity(0.8),
                                      ),
                                  value: selectedGender,
                                  decoration: _getInputDecoration(
                                    context,
                                  ),
                                  items: ['Male', 'Female', 'Others']
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    selectedGender = value;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        _buildFormField(
                          context,
                          'Registration Number',
                          isRequired: true,
                          child: TextField(
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary
                                      .withOpacity(0.8),
                                ),
                            controller: regNoController,
                            decoration: _getInputDecoration(
                              context,
                              'Auto Generated if empty',
                            ),
                          ),
                        ),
                        _buildFormField(
                          context,
                          'Email',
                          child: TextField(
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary
                                      .withOpacity(0.8),
                                ),
                            controller: emailController,
                            decoration: _getInputDecoration(
                              context,
                              'Enter email',
                              Icons.email,
                            ),
                          ),
                        ),
                        _buildFormField(
                          context,
                          'Profession',
                          child: TextField(
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary
                                      .withOpacity(0.8),
                                ),
                            controller: professionController,
                            decoration: _getInputDecoration(
                              context,
                              'Enter profession',
                              Icons.work,
                            ),
                          ),
                        ),
                        _buildFormField(
                          context,
                          'Emergency Contact Name',
                          child: TextField(
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary
                                      .withOpacity(0.8),
                                ),
                            controller: contactNameController,
                            decoration: _getInputDecoration(
                              context,
                            ),
                          ),
                        ),
                        _buildFormField(
                          context,
                          'Relationship',
                          child: TextField(
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary
                                      .withOpacity(0.8),
                                ),
                            controller: relationshipController,
                            decoration: _getInputDecoration(
                              context,
                            ),
                          ),
                        ),
                        _buildFormField(
                          context,
                          'Emergency Contact Mobile',
                          child: TextField(
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary
                                      .withOpacity(0.8),
                                ),
                            controller: contactMobileController,
                            decoration: _getInputDecoration(
                              context,
                            ),
                          ),
                        ),
                        _buildFormField(
                          context,
                          'Address',
                          child: TextField(
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary
                                      .withOpacity(0.8),
                                ),
                            controller: addressController,
                            maxLines: 2,
                            decoration: _getInputDecoration(
                              context,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary
                                      .withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.grey),
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
                                  onPressed: () {
                                    final updatedData = {
                                      'first_name': firstNameController.text,
                                      'surname': surnameController.text,
                                      'phone': phoneController.text,
                                      'email': emailController.text,
                                      'dob': dobController.text,
                                      'age': ageController.text,
                                      'gender': selectedGender,
                                      'patient_reg_no': regNoController.text,
                                      'profession': professionController.text,
                                      'address': addressController.text,
                                      'primary_contact_name':
                                          contactNameController.text,
                                      'relationship':
                                          relationshipController.text,
                                      'contact_mobile':
                                          contactMobileController.text,
                                    };
                                    print(updatedData);
                                    final _patientController =
                                        Get.find<AdminPatientController>();

                                    if (patientData != null) {
                                      _patientController
                                          .updatePatientData(updatedData);
                                    } else {
                                      _patientController
                                          .addPatientData(updatedData);
                                    }
                                    Navigator.pop(context);
                                  },
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
                                  child: Text(patientData != null
                                      ? 'Update'
                                      : 'Submit'),
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
