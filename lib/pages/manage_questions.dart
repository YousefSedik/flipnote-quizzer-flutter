import 'package:flutter/material.dart';
import 'package:project/components/app_bar.dart';

class CreateAndEditQuestions extends StatelessWidget {
  const CreateAndEditQuestions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: getAppBar(title: "Manage Questions"));
  }
}
