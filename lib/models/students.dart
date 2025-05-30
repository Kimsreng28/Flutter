class Student {
  final int? id;
  final String name;
  final String email;
  final String phone;
  final String studentGroup;
  final String className;
  final String gender;
  final String dateRegistered;
  final bool present;

  Student({
    this.id,
    required this.name,
    required this.email,
    required this.studentGroup,
    required this.phone,
    required this.className,
    required this.gender,
    required this.dateRegistered,
    required this.present,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'studentGroup': studentGroup,
      'phone': phone,
      'className': className,
      'gender': gender,
      'dateRegistered': dateRegistered,
      'present': present ? 1 : 0,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] as int, // Make sure this is correctly mapped
      name: map['name'] as String,
      email: map['email'] as String,
      studentGroup: map['studentGroup'] as String,
      phone: map['phone'] as String,
      className: map['className'] as String,
      gender: map['gender'] as String,
      dateRegistered: map['dateRegistered'] as String,
      present: (map['present'] as int) == 1, // SQLite stores bool as 0 or 1
    );
  }
}
