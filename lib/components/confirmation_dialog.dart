import 'package:flutter/material.dart';

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
              Navigator.of(context).pop(false);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('Delete'),
          ),
        ],
      );
    },
  );

  if (confirmed == true) {
    // Perform the action after confirmation
    print('Item deleted!');
  } else {
    print('Deletion canceled.');
  }
}
