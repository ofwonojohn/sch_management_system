import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_system_app/screens/dashboards/student_registration.dart';
import 'package:school_system_app/screens/students/alevel_registration.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  void _showLevelSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Level'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: Text("O'Level"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/selectClass', arguments: "O'Level");
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text("A'Level"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/selectClass', arguments: "A'Level");
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showRegistrationLevelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Select Student Level"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _navigateTo(context, StudentRegistrationScreen()); // O'Level screen
              },
              child: Text("O'Level Student"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _navigateTo(context, ALevelRegistrationScreen()); // A'Level screen
              },
              child: Text("A'Level Student"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _funAcronym(BuildContext context) {
    final color = Colors.blue[700];
    final textStyle = TextStyle(fontSize: 13, color: Colors.blue[900], fontWeight: FontWeight.w600);

    Widget letterBox(String letter) {
      return Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          letter,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      );
    }

    Widget meaning(String word) {
      return Text(word, style: textStyle);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        letterBox('F'),
        SizedBox(width: 6),
        meaning('Functionality'),
        SizedBox(width: 16),
        letterBox('U'),
        SizedBox(width: 6),
        meaning('Usability'),
        SizedBox(width: 16),
        letterBox('N'),
        SizedBox(width: 6),
        meaning('Neatness'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OurLady'),
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
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            child: Column(
              children: [
                Icon(Icons.school, size: 80, color: Colors.blue[700]),
                SizedBox(height: 10),
                Text(
                  'OurLady OF Fatima',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Built With',
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.blue[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),
                Text(
                  'FUN',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                    letterSpacing: 6,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                _funAcronym(context),
              ],
            ),
          ),
          Divider(thickness: 2),
          SizedBox(height: 4),

          Text(
            'Welcome to the School Admin Dashboard',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),

          ListTile(
            leading: Icon(Icons.person_add),
            title: Text('Register New Student'),
            onTap: () => _showRegistrationLevelDialog(context), // ← Modified
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.group),
            title: Text('View All Students'),
            onTap: () => _showLevelSelectionDialog(context),
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text('View Performance'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Coming soon...')));
            },
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.school),
            title: Text('View Teacher Details'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Coming soon...')));
            },
          ),
        ],
      ),
    );
  }
}
