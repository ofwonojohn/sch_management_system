import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:school_system_app/models/student_model.dart';

class StudentRegistrationScreen extends StatefulWidget {
  @override
  _StudentRegistrationScreenState createState() => _StudentRegistrationScreenState();
}

class _StudentRegistrationScreenState extends State<StudentRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final studentIDController = TextEditingController();
  final dobController = TextEditingController();
  final guardianContactController = TextEditingController();

  String selectedClass = 'S1';
  String selectedLevel = 'O\'Level';
  String selectedGender = 'Male';

  final List<String> classes = ['S1', 'S2', 'S3', 'S4', 'S5', 'S6'];
  final List<String> levels = ['O\'Level', 'A\'Level'];
  final List<String> genders = ['Male', 'Female'];

  void registerStudent() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Save to Firebase
        await FirebaseFirestore.instance.collection('students').add({
          'fullName': fullNameController.text.trim(),
          'studentID': studentIDController.text.trim(),
          'class': selectedClass,
          'level': selectedLevel,
          'dob': dobController.text.trim(),
          'gender': selectedGender,
          'guardianContact': guardianContactController.text.trim(),
          'createdAt': Timestamp.now(),
        });

        // Save to Hive
        final studentBox = Hive.box<StudentModel>('studentsBox');
        final student = StudentModel(
          fullName: fullNameController.text.trim(),
          studentID: studentIDController.text.trim(),
          studentClass: selectedClass,
          level: selectedLevel,
          dob: dobController.text.trim(),
          gender: selectedGender,
          guardianContact: guardianContactController.text.trim(),
        );
        await studentBox.add(student);

        // Notify success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Student registered successfully')),
        );

        // Reset form
        _formKey.currentState!.reset();
        fullNameController.clear();
        studentIDController.clear();
        dobController.clear();
        guardianContactController.clear();

        setState(() {
          selectedClass = 'S1';
          selectedLevel = 'O\'Level';
          selectedGender = 'Male';
        });

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register Student')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) => value!.isEmpty ? 'Enter full name' : null,
              ),
              TextFormField(
                controller: studentIDController,
                decoration: InputDecoration(labelText: 'Student ID'),
                validator: (value) => value!.isEmpty ? 'Enter student ID' : null,
              ),
              DropdownButtonFormField(
                value: selectedClass,
                items: classes.map((cls) => DropdownMenuItem(child: Text(cls), value: cls)).toList(),
                onChanged: (value) => setState(() => selectedClass = value!),
                decoration: InputDecoration(labelText: 'Class'),
              ),
              DropdownButtonFormField(
                value: selectedLevel,
                items: levels.map((lvl) => DropdownMenuItem(child: Text(lvl), value: lvl)).toList(),
                onChanged: (value) => setState(() => selectedLevel = value!),
                decoration: InputDecoration(labelText: 'Level'),
              ),
              DropdownButtonFormField(
                value: selectedGender,
                items: genders.map((g) => DropdownMenuItem(child: Text(g), value: g)).toList(),
                onChanged: (value) => setState(() => selectedGender = value!),
                decoration: InputDecoration(labelText: 'Gender'),
              ),
              TextFormField(
                controller: dobController,
                decoration: InputDecoration(labelText: 'Date of Birth (YYYY-MM-DD)'),
                validator: (value) => value!.isEmpty ? 'Enter DOB' : null,
              ),
              TextFormField(
                controller: guardianContactController,
                decoration: InputDecoration(labelText: 'Guardian Contact'),
                validator: (value) => value!.isEmpty ? 'Enter contact' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: registerStudent,
                child: Text('Register Student'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
