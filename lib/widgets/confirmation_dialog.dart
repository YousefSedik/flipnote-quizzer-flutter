import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> _showConfirmationDialog(
  BuildContext context,
  String confirmationMessage,
  List<String> options,
) async {
  final bool? confirmed = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirmation'),
        content: Text(confirmationMessage),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back(result: false);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back(result: true);
            },
            child: Text('Delete'),
          ),
        ],
      );
    },
  );

  if (confirmed == true) {
    print('Item deleted!');
  } else {
    print('Deletion canceled.');
  }
}
