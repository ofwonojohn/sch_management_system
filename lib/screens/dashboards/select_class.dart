import 'package:flutter/material.dart';

class SelectClassScreen extends StatelessWidget {
  const SelectClassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String level = ModalRoute.of(context)!.settings.arguments as String;

    final classes = level == "O'Level" ? ['S1', 'S2', 'S3', 'S4'] : ['S5', 'S6'];


    return Scaffold(
      appBar: AppBar(title: Text('Select Class - $level')),
      body: ListView.builder(
        itemCount: classes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(classes[index]),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/studentsList',
                arguments: {
                  'level': level,
                  'class': classes[index],
                },
              );
            },
          );
        },
      ),
    );
  }
}
