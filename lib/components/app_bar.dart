import 'package:flutter/material.dart';

PreferredSizeWidget getAppBar() {
  return AppBar(
    title: Text(
      "Flipnote Quizzer",
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    shape: Border(
      bottom: BorderSide(
        color: Colors.grey,
        width: .25,
      ),
    ),
  );
}
