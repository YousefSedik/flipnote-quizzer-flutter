import 'package:flutter/material.dart';

class RecentActivity extends StatelessWidget {
  const RecentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Recent Activity",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        ...List.generate(12, (index) {
          return Card(
            child: ListTile(
              title: Text("Activity ${index+1}"),
              subtitle: Text("Description of Activity ${index + 1}"),
              trailing: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "New",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
