import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddAcademicRecordScreen extends StatefulWidget {
  final String studentId;

  const AddAcademicRecordScreen({super.key, required this.studentId});

  @override
  State<AddAcademicRecordScreen> createState() => _AddAcademicRecordScreenState();
}

class _AddAcademicRecordScreenState extends State<AddAcademicRecordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _scoreController = TextEditingController();
  final _termController = TextEditingController();
  final _yearController = TextEditingController();

  bool _isLoading = false;

  Future<void> _submitRecord() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final record = {
      'subject': _subjectController.text.trim(),
      'score': int.parse(_scoreController.text.trim()),
      'term': _termController.text.trim(),
      'year': _yearController.text.trim(),
      'timestamp': FieldValue.serverTimestamp(),
    };

    try {
      await FirebaseFirestore.instance
          .collection('students')
          .doc(widget.studentId)
          .collection('academic_records')
          .add(record);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Record added successfully')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _scoreController.dispose();
    _termController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Academic Record')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _subjectController,
                decoration: InputDecoration(labelText: 'Subject'),
                validator: (value) => value!.isEmpty ? 'Enter subject' : null,
              ),
              TextFormField(
                controller: _scoreController,
                decoration: InputDecoration(labelText: 'Score'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty || int.tryParse(value) == null ? 'Enter valid score' : null,
              ),
              TextFormField(
                controller: _termController,
                decoration: InputDecoration(labelText: 'Term'),
                validator: (value) => value!.isEmpty ? 'Enter term' : null,
              ),
              TextFormField(
                controller: _yearController,
                decoration: InputDecoration(labelText: 'Year'),
                validator: (value) => value!.isEmpty ? 'Enter year' : null,
              ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submitRecord,
                      child: Text('Add Record'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
