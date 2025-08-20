import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.title,
    required this.lastItem,
    required this.isObscureText,
  });
  final TextEditingController controller;
  final String hintText;
  final String title;
  final bool lastItem;
  final bool isObscureText;

  @override
  Widget build(BuildContext context) {
    double sizedBoxSize = 24;
    if (lastItem) {
      sizedBoxSize = 32;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: 'SF Pro Text',
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          
          controller: controller,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'SF Pro Text',
            color: Colors.black,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontFamily: 'SF Pro Text',
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.black, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          obscureText: isObscureText,
        ),
        SizedBox(height: sizedBoxSize),
      ],
    );
  }
}
