import 'package:flutter/material.dart';

class BlackButton extends StatelessWidget {
  BlackButton({super.key, required this.text, this.onPressed, this.icon});
  final String text;
  Icon? icon;
  Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        onPressed: onPressed,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 7,
          children: [
            icon ?? Container(),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
