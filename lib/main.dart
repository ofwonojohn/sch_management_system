import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:school_system_app/models/student_model.dart';
import 'package:school_system_app/screens/auth/login_screen.dart';
import 'package:school_system_app/screens/auth/signup_screen.dart';
import 'package:school_system_app/screens/dashboards/admin_dashboard.dart';
import 'package:school_system_app/screens/dashboards/select_class.dart';
import 'package:school_system_app/screens/dashboards/student_list.dart';
import 'package:school_system_app/screens/dashboards/view_student.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter('hive_data');
  Hive.registerAdapter(StudentModelAdapter());
  await Hive.openBox<StudentModel>('studentsBox');

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(SchoolApp());
}

class SchoolApp extends StatelessWidget {
  const SchoolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin School App',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/viewStudents': (context) => ViewStudentsScreen(),
        '/selectClass': (context) => SelectClassScreen(),
        '/studentsList': (context) => StudentsListScreen(),
      },
    );
  }
}
