import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_system_app/screens/dashboards/student_registration.dart';
import 'package:school_system_app/screens/dashboards/view_student.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            'Welcome to the School Admin Dashboard',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),

          ListTile(
            leading: Icon(Icons.person_add),
            title: Text('Register New Student'),
            onTap: () => _navigateTo(context, StudentRegistrationScreen()),
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.group),
            title: Text('View All Students'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ViewStudentsScreen())),

          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text('View Performance'),
            onTap: () {
              // TODO: Implement View Performance screen
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Coming soon...')));
            },
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.school),
            title: Text('View Teacher Details'),
            onTap: () {
              // TODO: Implement View Teacher screen
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Coming soon...')));
            },
          ),
        ],
      ),
    );
  }
}
