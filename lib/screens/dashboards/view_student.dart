import 'package:flutter/material.dart';

class ViewStudentsScreen extends StatelessWidget {
  const ViewStudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Level')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("O'Level"),
              onPressed: () {
                Navigator.pushNamed(context, '/selectClass', arguments: "O'Level");
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("A'Level"),
              onPressed: () {
                Navigator.pushNamed(context, '/selectClass', arguments: "A'Level");
              },
            ),
          ],
        ),
      ),
    );
  }
}
