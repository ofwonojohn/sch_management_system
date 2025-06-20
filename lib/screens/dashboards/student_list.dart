import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_system_app/screens/students/student_detail_screen.dart';

class StudentsListScreen extends StatelessWidget {
  const StudentsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String selectedLevel = args['level'] ?? '';
    final String selectedClass = args['class'] ?? '';

    final studentsQuery = FirebaseFirestore.instance
        .collection('students')
        .where('level', isEqualTo: selectedLevel)
        .where('class', isEqualTo: selectedClass);

    return Scaffold(
      appBar: AppBar(
        title: Text('$selectedClass ($selectedLevel) Students'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: studentsQuery.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading students'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final students = snapshot.data?.docs ?? [];

          if (students.isEmpty) {
            return const Center(child: Text('No students found.'));
          }

          return ListView.separated(
            itemCount: students.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final student = students[index];
              final studentData = student.data() as Map<String, dynamic>;

              final studentName = studentData['fullName'] ?? 'Unnamed';
              final studentId = studentData['studentID'] ?? 'N/A';

              return ListTile(
                title: Text(studentName),
                subtitle: Text('ID: $studentId'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StudentDetailsScreen(
                        studentData: studentData,
                        studentDocId: students[index].id,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
