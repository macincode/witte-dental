import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:witte_dental_pms/features/admin/presentation/controllers/admin_doctor_controller.dart';

class DoctorlistManagement extends StatefulWidget {
  const DoctorlistManagement({super.key});

  @override
  State<DoctorlistManagement> createState() => _DoctorlistManagementState();
}

class _DoctorlistManagementState extends State<DoctorlistManagement> {
  final AdminDoctorController _doctorController =
      Get.put(AdminDoctorController());
  final TextEditingController _searchController = TextEditingController();
  final RxList<dynamic> _filteredDoctors = <dynamic>[].obs;
  String? _selectedFilter;
  String? _selectedFilterValue;

  @override
  void initState() {
    super.initState();
    _filteredDoctors.value = _doctorController.adminDoctorList;
  }

  void _filterDoctors(String query) {
    List<dynamic> doctors = _doctorController.adminDoctorList.toList();
    
    if (_selectedFilter != null && _selectedFilterValue != null) {
      doctors = doctors.where((doctor) {
        return (doctor as Map)[_selectedFilter] == _selectedFilterValue;
      }).toList();
    }
    
    if (query.isEmpty) {
      _filteredDoctors.value = doctors;
    } else {
      _filteredDoctors.value = doctors.where((doctor) {
        final doc = doctor as Map;
        final name = '${doc['first_name']} ${doc['surname']}'.toLowerCase();
        final phone = (doc['phone'] ?? '').toString().toLowerCase();
        final searchLower = query.toLowerCase();
        return name.contains(searchLower) || phone.contains(searchLower);
      }).toList();
    }
  }

  void _showFilterOptions(String filterType) {
    final values = _doctorController.adminDoctorList
        .map((d) => (d as Map)[filterType])
        .where((v) => v != null && v.toString().isNotEmpty)
        .toSet()
        .toList();

    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 8,
      color: Theme.of(context).colorScheme.surface,
      items: values.map((value) => PopupMenuItem(
        value: value,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 18,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
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
      )).toList(),
    ).then((selectedValue) {
      if (selectedValue != null) {
        setState(() {
          _selectedFilter = filterType;
          _selectedFilterValue = selectedValue.toString();
        });
        _filterDoctors(_searchController.text);
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
        title: const Text('Doctor List'),
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
                      onChanged: _filterDoctors,
                      decoration: InputDecoration(
                        hintText: 'Search by doctor name,mobile...',
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 8,
                  offset: const Offset(0, 50),
                  icon: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
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
                      value: 'qualification',
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Icon(Icons.school, size: 20, color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 12),
                          const Text('Qualification'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'specialist',
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Icon(Icons.medical_services, size: 20, color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 12),
                          const Text('Specialist'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'department_name',
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Icon(Icons.business, size: 20, color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 12),
                          const Text('Department'),
                        ],
                      ),
                    ),
                    if (_selectedFilter != null) 
                      // const PopupMenuDivider(),
                      PopupMenuItem(
                        value: 'clear',
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            Icon(Icons.clear, size: 20, color: Colors.red[400]),
                            const SizedBox(width: 12),
                            Text('Clear Filter', style: TextStyle(color: Colors.red[400])),
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
                      _filterDoctors(_searchController.text);
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
              () => _filteredDoctors.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.people_outline,
                              size: 48, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text('No Doctors found',
                              style: TextStyle(color: Colors.grey[500])),
                        ],
                      ),
                    ) :
              ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                itemCount: _filteredDoctors.length,
                itemBuilder: (context, index) {
                  final doctor = _filteredDoctors[index];
                final doctorName =
                    '${doctor['first_name']} ${doctor['surname']}';
                final phone = doctor['phone'] ?? '';
                final department = doctor['department_name'] ?? '';
                final specialist = doctor['specialist'] ?? '';
                final qualification = doctor['qualification'] ?? '';
                final employeeNumber = doctor['employee_number'] ?? 'N/A';
                final status = doctor['status'] == 1 ? 'Active' : 'Inactive';

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
                                doctorName[4],
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
                                    doctorName,
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
                                    employeeNumber,
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
                            department,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                        const SizedBox(height: 12),
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
                                  color: Theme.of(context).colorScheme.primary,
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
                                  Icons.grade_outlined,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Qualification :',
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
                                        qualification,
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
                                  const SizedBox(width: 8),
                                  Container(
                                    height: 30,
                                    width: 2,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary
                                        .withOpacity(0.3),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Specialist :',
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
                                        specialist,
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
                                ],
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
                                    AddDoctorHelper.addDoctorSheet(context,
                                        doctorData: doctor);
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
                            // Expanded(
                            //   child: Container(
                            //     decoration: BoxDecoration(
                            //       gradient: LinearGradient(
                            //         colors: [
                            //           Theme.of(context)
                            //               .colorScheme
                            //               .error
                            //               .withOpacity(0.4),
                            //           Theme.of(context)
                            //               .colorScheme
                            //               .error
                            //               .withOpacity(0.9),
                            //         ],
                            //         begin: Alignment.topLeft,
                            //         end: Alignment.bottomRight,
                            //       ),
                            //       borderRadius: BorderRadius.circular(10),
                            //       boxShadow: [
                            //         BoxShadow(
                            //           color: Colors.red.withOpacity(0.3),
                            //           blurRadius: 6,
                            //           offset: const Offset(0, 2),
                            //         ),
                            //       ],
                            //     ),
                            //     child: ElevatedButton.icon(
                            //       onPressed: () {},
                            //       icon: const Icon(Icons.delete,
                            //           size: 16, color: Colors.white),
                            //       label: const Text('Delete',
                            //           style: TextStyle(
                            //               color: Colors.white,
                            //               fontWeight: FontWeight.w600)),
                            //       style: ElevatedButton.styleFrom(
                            //         backgroundColor: Colors.transparent,
                            //         shadowColor: Colors.transparent,
                            //         padding: const EdgeInsets.symmetric(
                            //             vertical: 12),
                            //         shape: RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.circular(10),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),),
        ],
      ),
    );
  }
}

class AddDoctorHelper {
  static void addDoctorSheet(BuildContext context,
      {Map<String, dynamic>? doctorData}) {
    final firstNameController =
        TextEditingController(text: doctorData?['first_name']);
    final surnameController =
        TextEditingController(text: doctorData?['surname']);
    final phoneController = TextEditingController(text: doctorData?['phone']);
    final qualificationController =
        TextEditingController(text: doctorData?['qualification']);
    final specialistController =
        TextEditingController(text: doctorData?['specialist']);
    final emailController = TextEditingController(text: doctorData?['email']);
    final dobController = TextEditingController(text: doctorData?['dob']);
    final ageController =
        TextEditingController(text: doctorData?['age']?.toString());
    final aadharController =
        TextEditingController(text: doctorData?['aadhar_number']);
    final addressController =
        TextEditingController(text: doctorData?['address']);
    final practicingController =
        TextEditingController(text: doctorData?['currently_practicing']);
    final experienceController =
        TextEditingController(text: doctorData?['experience']);
    final awardsController =
        TextEditingController(text: doctorData?['awards_achievements']);
    final journeyController =
        TextEditingController(text: doctorData?['journey']);
    String? selectedGender = doctorData?['gender'];

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
                      doctorData != null ? 'Edit Doctor' : 'Add Doctor',
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
                          'Qualification',
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
                            controller: qualificationController,
                            decoration: _getInputDecoration(
                              context,
                              'Enter qualification',
                            ),
                          ),
                        ),
                        _buildFormField(
                          context,
                          'Specialist',
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
                            controller: specialistController,
                            decoration: _getInputDecoration(
                              context,
                              'Enter specialist area',
                            ),
                          ),
                        ),
                        _buildFormField(
                          context,
                          'Email',
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
                          'Aadhar Number',
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
                            controller: aadharController,
                            decoration: _getInputDecoration(
                              context,
                              'Enter Aadhar Number',
                            ),
                          ),
                        ),
                        _buildFormField(
                          context,
                          'Address',
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
                            controller: addressController,
                            decoration: _getInputDecoration(
                              context,
                              'Enter Address',
                            ),
                          ),
                        ),
                        _buildFormField(
                          context,
                          'Currently Practicing',
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
                            controller: practicingController,
                            decoration: _getInputDecoration(
                              context,
                              'Enter current practice',
                            ),
                          ),
                        ),
                        _buildFormField(
                          context,
                          'Experience (Years)',
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
                            controller: experienceController,
                            decoration: _getInputDecoration(
                              context,
                              'Enter years of experience',
                            ),
                          ),
                        ),
                        _buildFormField(
                          context,
                          'Awards & Achievements',
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
                            controller: awardsController,
                            maxLines: 2,
                            decoration: _getInputDecoration(
                              context,
                              'Enter awards and achievements',
                            ),
                          ),
                        ),
                        _buildFormField(
                          context,
                          'Experience Journey',
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
                            controller: journeyController,
                            maxLines: 2,
                            decoration: _getInputDecoration(
                              context,
                              'Describe your professional journey and experience',
                            ),
                          ),
                        ),
                        if (doctorData == null || doctorData.isEmpty)
                          _buildFormField(
                            context,
                            'Password',
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
                              decoration: _getInputDecoration(
                                  context, 'Enter password'),
                            ),
                          ),
                        if (doctorData == null || doctorData.isEmpty)
                          _buildFormField(
                            context,
                            'Confirm Password',
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
                              decoration: _getInputDecoration(
                                context,
                                'Confirm password',
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
                                  onPressed: () {
                                    if (doctorData != null) {
                                      final updatedData = {
                                        'first_name': firstNameController.text,
                                        'surname': surnameController.text,
                                        'phone': phoneController.text,
                                        'qualification':
                                            qualificationController.text,
                                        'specialist': specialistController.text,
                                        'email': emailController.text,
                                        'dob': dobController.text,
                                        'age': ageController.text,
                                        'gender': selectedGender,
                                        'aadhar_number': aadharController.text,
                                        'address': addressController.text,
                                        'currently_practicing':
                                            practicingController.text,
                                        'experience': experienceController.text,
                                        'awards_achievements':
                                            awardsController.text,
                                        'journey': journeyController.text,
                                      };

                                      print('Updated Data: $updatedData');
                                      final doctorController =
                                          Get.find<AdminDoctorController>();
                                      doctorController
                                          .updateDoctorData(updatedData);
                                      Navigator.pop(context);
                                    } else {
                                      final addData = {
                                        'first_name': firstNameController.text,
                                        'surname': surnameController.text,
                                        'phone': phoneController.text,
                                        'qualification':
                                            qualificationController.text,
                                        'specialist': specialistController.text,
                                        'department_id': '1',
                                        'email': emailController.text,
                                        'dob': dobController.text,
                                        'age': ageController.text,
                                        'gender': selectedGender,
                                        'aadhar_number': aadharController.text,
                                        'address': addressController.text,
                                        'currently_practicing':
                                            practicingController.text,
                                        'experience': experienceController.text,
                                        'awards_achievements':
                                            awardsController.text,
                                        'journey': journeyController.text,
                                      };
                                      print('Add Data: $addData');
                                      final doctorController =
                                          Get.find<AdminDoctorController>();
                                      doctorController.addDoctorData(addData);
                                      Navigator.pop(context);
                                    }
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
                                  child: doctorData != null
                                      ? const Text('Update')
                                      : const Text('Submit'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
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
