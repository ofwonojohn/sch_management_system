import 'package:flutter/material.dart';
import 'package:school_system_app/screens/students/add_academic_record_screen.dart';

class StudentDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> studentData;
  final String studentDocId;

  const StudentDetailsScreen({
    super.key,
    required this.studentData,
    required this.studentDocId,
  });

  @override
  Widget build(BuildContext context) {
    final isALevel = studentData['level']?.toLowerCase() == "a'level";

    return Scaffold(
      appBar: AppBar(
        title: Text('${studentData['fullName']} Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildDetailRow("Name", studentData['fullName']),
            _buildDetailRow("Student ID", studentData['studentID']),
            _buildDetailRow("Class", studentData['class']),
            _buildDetailRow("Level", studentData['level']),
            _buildDetailRow("Gender", studentData['gender']),
            _buildDetailRow("Date of Birth", studentData['dob']),

            // --- A'Level subjects section ---
            if (isALevel) ...[
              const SizedBox(height: 16),
              Text('Subject Combination:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              _buildDetailRow("Subject 1", studentData['subject1']),
              _buildDetailRow("Subject 2", studentData['subject2']),
              _buildDetailRow("Subject 3", studentData['subject3']),
              _buildDetailRow("Subsidiary", studentData['subsidiary']),
              _buildDetailRow("GP", studentData['gp']),
            ],

            const SizedBox(height: 30),

            // --- Button to add academic records ---
            ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text("Add Academic Record"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddAcademicRecordScreen(studentId: studentDocId),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

    Widget _buildDetailRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Text('$label: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Expanded(child: Text(value?.toString() ?? 'N/A', style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

}
