import 'package:flutter/material.dart';
import 'package:project/components/app_bar.dart';

class UnauthorizedPage extends StatelessWidget {
  const UnauthorizedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: getAppBar(title: "Unauthorized"));
  }
}
