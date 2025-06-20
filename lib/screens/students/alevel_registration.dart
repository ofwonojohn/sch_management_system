import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ALevelRegistrationScreen extends StatefulWidget {
  const ALevelRegistrationScreen({super.key});

  @override
  State<ALevelRegistrationScreen> createState() => _ALevelRegistrationScreenState();
}

class _ALevelRegistrationScreenState extends State<ALevelRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  List<String> _selectedSubjects = [];
  String? _selectedSubSubject;

  final List<String> allSubjects = [
    'Mathematics', 'Physics', 'Chemistry', 'Biology', 'Economics',
    'Entrepreneurship', 'Geography', 'History', 'Agriculture',
    'Divinity', 'Literature', 'Art'
  ];

  final List<String> subSubjects = ['Sub ICT', 'Sub Mathematics'];

  bool _isLoading = false;

void _submitForm() async {
  if (!_formKey.currentState!.validate()) return;
  if (_selectedSubjects.length != 3 || _selectedSubSubject == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please select exactly 3 subjects and a subsidiary subject")),
    );
    return;
  }

  setState(() => _isLoading = true);

  final studentData = {
    'fullName': _fullNameController.text.trim(),
    'studentID': _studentIdController.text.trim(),
    'class': _classController.text.trim(),
    'level': "A'Level",
    'gender': _genderController.text.trim(),
    'dob': _dobController.text.trim(),
    'subject1': _selectedSubjects[0],
    'subject2': _selectedSubjects[1],
    'subject3': _selectedSubjects[2],
    'subsidiary': _selectedSubSubject,
    'gp': 'GP',
    'timestamp': FieldValue.serverTimestamp(),
  };

  try {
    await FirebaseFirestore.instance.collection('students').add(studentData);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Student registered successfully')));
    Navigator.pop(context);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
  }

  setState(() => _isLoading = false);
}


  @override
  void dispose() {
    _fullNameController.dispose();
    _studentIdController.dispose();
    _classController.dispose();
    _genderController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register A'Level Student")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(labelText: 'Full Name'),
                  validator: (value) => value!.isEmpty ? 'Enter name' : null,
                ),
                TextFormField(
                  controller: _studentIdController,
                  decoration: InputDecoration(labelText: 'Student ID'),
                  validator: (value) => value!.isEmpty ? 'Enter ID' : null,
                ),
                TextFormField(
                  controller: _classController,
                  decoration: InputDecoration(labelText: 'Class(S5 or S6)'),
                  validator: (value) => value!.isEmpty ? 'Enter class' : null,
                ),
                TextFormField(
                  controller: _genderController,
                  decoration: InputDecoration(labelText: 'Gender'),
                  validator: (value) => value!.isEmpty ? 'Enter gender' : null,
                ),
                TextFormField(
                  controller: _dobController,
                  decoration: InputDecoration(labelText: 'Date of Birth (YYYY-MM-DD)'),
                  validator: (value) => value!.isEmpty ? 'Enter DOB' : null,
                ),
                SizedBox(height: 16),
                Text('Select 3 Main Subjects', style: TextStyle(fontWeight: FontWeight.bold)),
                Wrap(
                  spacing: 10,
                  children: allSubjects.map((subject) {
                    final isSelected = _selectedSubjects.contains(subject);
                    return FilterChip(
                      label: Text(subject),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            if (_selectedSubjects.length < 3) _selectedSubjects.add(subject);
                          } else {
                            _selectedSubjects.remove(subject);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Subsidiary Subject'),
                  value: _selectedSubSubject,
                  items: subSubjects.map((sub) => DropdownMenuItem(
                    value: sub,
                    child: Text(sub),
                  )).toList(),
                  onChanged: (val) => setState(() => _selectedSubSubject = val),
                  validator: (val) => val == null ? 'Select subsidiary subject' : null,
                ),
                SizedBox(height: 20),
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _submitForm,
                        child: Text('Register Student'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
