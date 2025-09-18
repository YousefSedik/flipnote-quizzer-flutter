import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> showConfirmationDialog(String confirmationMessage) async {
  List<String> options = ['Cancel', 'Confirm'];
  final bool? confirmed = await Get.dialog<bool>(
    AlertDialog(
      title: Text('Confirmation'),
      content: Text(confirmationMessage),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(result: false);
          },
          child: Text("Cancel", style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () {
            Get.back(result: true);
          },
          child: Text("Confirm", style: TextStyle(color: Colors.black)),
        ),
      ],
    ),
  );
  print(confirmed);
  return confirmed ?? false;
}
