import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentsListScreen extends StatelessWidget {
  const StudentsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String selectedLevel = args['level']!;
    final String selectedClass = args['class']!;

    final studentsQuery = FirebaseFirestore.instance
        .collection('students')
        .where('level', isEqualTo: selectedLevel)
        .where('class', isEqualTo: selectedClass);
    // final studentsQuery = FirebaseFirestore.instance.collection('students');


    return Scaffold(
      appBar: AppBar(title: Text('$selectedClass ($selectedLevel) Students')),
      body: StreamBuilder<QuerySnapshot>(
        stream: studentsQuery.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text('Error loading students'));
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final students = snapshot.data!.docs;

          if (students.isEmpty) return Center(child: Text('No students found.'));

          return ListView.separated(
            itemCount: students.length,
            separatorBuilder: (_, __) => Divider(),
            itemBuilder: (context, index) {
              final studentData = students[index].data()! as Map<String, dynamic>;
              return ListTile(
                leading: Icon(Icons.person),
                title: Text(studentData['fullName'] ?? 'No Name'),
                subtitle: Text('ID: ${studentData['studentID'] ?? 'N/A'}'),
              );
            },
          );
        },
      ),
    );
  }
}
