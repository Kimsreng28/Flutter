import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/students.dart';

class StudentService {
  static final StudentService _instance = StudentService._internal();

  factory StudentService() {
    return _instance;
  }

  StudentService._internal();

  Database? _database;

  Future<Database> getDatabase() async {
    if (_database != null) return _database!;

    _database = await openDatabase(
      join(await getDatabasesPath(), 'class_check.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, studentGroup TEXT, phone TEXT, className TEXT, gender TEXT, dateRegistered TEXT, present INTEGER)',
        );
      },
      version: 1,
    );
    return _database!;
  }

  Future<void> insertStudent(Student student) async {
    final db = await getDatabase();
    await db.insert('students', student.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // get all students
  Future<List<Student>> getAllStudents() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('students');

    // Add debug print to verify the data
    debugPrint('Retrieved students: $maps');

    return List.generate(maps.length, (i) {
      final student = Student.fromMap(maps[i]);
      debugPrint('Student ${i + 1}: id=${student.id}');
      return student;
    });
  }

  Future<int> updateStudent(Student student) async {
    final db = await getDatabase();
    return await db.update(
      'students',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<int> deleteStudent(int id) async {
    final db = await getDatabase();
    return await db.delete(
      'students',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
