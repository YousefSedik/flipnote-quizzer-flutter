import 'package:flutter/material.dart';

PreferredSizeWidget getAppBar({String? title}) {
  return AppBar(
    title: Text(
      title ?? "Flipnote Quizzer",
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    shape: Border(bottom: BorderSide(color: Colors.grey, width: .25)),
  );
}
