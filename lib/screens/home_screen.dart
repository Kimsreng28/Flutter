import 'package:class_check/models/students.dart';
import 'package:class_check/services/student_service.dart';
import 'package:class_check/utils/validators.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final groupController = TextEditingController();
  final phoneController = TextEditingController();
  final classNameController = TextEditingController();
  final genderController = TextEditingController();
  final dateRegisteredController = TextEditingController();
  bool isPresent = false;

  final StudentService _studentService = StudentService();

  List<Student> studentList = [];
  List<bool> iconStatus = [];
  bool isEditing = false;
  int? currentStudentId;

  Future<void> insertStudent() async {
    final student = Student(
      name: nameController.text,
      email: emailController.text,
      studentGroup: groupController.text,
      phone: phoneController.text,
      className: classNameController.text,
      gender: genderController.text,
      dateRegistered: dateRegisteredController.text,
      present: isPresent,
    );

    await _studentService.insertStudent(student);
    await loadStudents();
    resetForm();
  }

  Future<void> updateStudent() async {
    if (currentStudentId == null) return;

    final student = Student(
      id: currentStudentId,
      name: nameController.text,
      email: emailController.text,
      studentGroup: groupController.text,
      phone: phoneController.text,
      className: classNameController.text,
      gender: genderController.text,
      dateRegistered: dateRegisteredController.text,
      present: isPresent,
    );

    await _studentService.updateStudent(student);
    await loadStudents();
    resetForm();
  }

  Future<void> deleteStudent(int id) async {
    await _studentService.deleteStudent(id);
    await loadStudents();
    if (currentStudentId == id) {
      resetForm();
    }
  }

  Future<void> loadStudents() async {
    final students = await _studentService.getAllStudents();
    setState(() {
      studentList = students;
      iconStatus = List.generate(students.length, (_) => false);
    });
  }

  void resetForm() {
    setState(() {
      _formKey.currentState?.reset();
      nameController.clear();
      emailController.clear();
      groupController.clear();
      phoneController.clear();
      classNameController.clear();
      genderController.clear();
      dateRegisteredController.clear();
      isPresent = false;
      isEditing = false;
      currentStudentId = null;
    });
  }

  void editStudent(Student student) {
    setState(() {
      nameController.text = student.name;
      emailController.text = student.email;
      groupController.text = student.studentGroup;
      phoneController.text = student.phone;
      classNameController.text = student.className;
      genderController.text = student.gender;
      dateRegisteredController.text = student.dateRegistered;
      isPresent = student.present;
      isEditing = true;
      currentStudentId = student.id;
    });
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    groupController.dispose();
    phoneController.dispose();
    classNameController.dispose();
    genderController.dispose();
    dateRegisteredController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Check Attendance'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Form Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          isEditing ? 'Edit Student' : 'Add New Student',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Name Field
                        _buildTextField(
                          controller: nameController,
                          label: 'Name',
                          validator: Validators.validateName,
                          icon: Icons.person,
                        ),

                        // Email Field
                        _buildTextField(
                          controller: emailController,
                          label: 'Email',
                          validator: Validators.validateEmail,
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        // Phone Field
                        _buildTextField(
                          controller: phoneController,
                          label: 'Phone',
                          validator: Validators.validatePhone,
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                        ),

                        // Group Field
                        _buildTextField(
                          controller: groupController,
                          label: 'Group',
                          validator: Validators.validateGroup,
                          icon: Icons.group,
                        ),

                        // Class Name Field
                        _buildTextField(
                          controller: classNameController,
                          label: 'Class Name',
                          icon: Icons.school,
                        ),

                        // Gender Field
                        _buildTextField(
                          controller: genderController,
                          label: 'Gender',
                          icon: Icons.transgender,
                        ),

                        // Date Registered Field
                        _buildTextField(
                          controller: dateRegisteredController,
                          label: 'Registered Date',
                          icon: Icons.calendar_today,
                          onTap: () => _selectDate(context),
                        ),

                        // Present Switch
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.check_circle,
                                  color: Colors.green),
                              const SizedBox(width: 12),
                              const Text(
                                'Present',
                                style: TextStyle(fontSize: 16),
                              ),
                              const Spacer(),
                              Switch(
                                value: isPresent,
                                onChanged: (value) =>
                                    setState(() => isPresent = value),
                                activeColor: Colors.green,
                              ),
                            ],
                          ),
                        ),

                        // Submit Button And Edit Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (isEditing) {
                                  updateStudent();
                                } else {
                                  insertStudent();
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade700,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              isEditing ? 'Update Student' : 'Add Student',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),

                        // Cancel Button
                        if (isEditing) ...[
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: resetForm,
                              style: OutlinedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Students List
              if (studentList.isNotEmpty) ...[
                const Text(
                  'Student List',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: studentList.length,
                  itemBuilder: (context, index) {
                    final student = studentList[index];
                    return Card(
                      elevation: 1,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ExpansionTile(
                        initiallyExpanded: iconStatus[index],
                        onExpansionChanged: (expanded) {
                          setState(() {
                            iconStatus[index] = expanded;
                          });
                        },
                        leading: Icon(
                          student.present ? Icons.check_circle : Icons.cancel,
                          color: student.present ? Colors.green : Colors.red,
                          size: 30,
                        ),
                        title: Text(
                          student.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                          student.email,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildInfoRow('Phone', student.phone),
                                _buildInfoRow('Group', student.studentGroup),
                                _buildInfoRow('Class', student.className),
                                _buildInfoRow('Gender', student.gender),
                                _buildInfoRow(
                                  'Registered',
                                  student.dateRegistered,
                                ),
                                _buildInfoRow(
                                  'Status',
                                  student.present ? 'Present' : 'Absent',
                                  valueColor: student.present
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      color: Colors.red,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text('Delete Student'),
                                            content: const Text(
                                                'Are you sure you want to delete this student?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  deleteStudent(student.id!);
                                                },
                                                child: const Text('Delete'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      color: Colors.blue.shade700,
                                      onPressed: () => editStudent(student),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Text Field Widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blue.shade700),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
        ),
      ),
    );
  }

  // Info Row Widget Display Student
  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: valueColor),
            ),
          ),
        ],
      ),
    );
  }

  // Date Picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        dateRegisteredController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }
}
